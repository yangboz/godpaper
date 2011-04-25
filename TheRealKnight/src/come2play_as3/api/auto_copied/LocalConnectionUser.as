package come2play_as3.api.auto_copied
{
	import come2play_as3.api.auto_generated.*;
	
	import flash.display.*;
	import flash.external.*;
	import flash.net.*;
	 
	public class LocalConnectionUser extends MovieClip
	{
		public static var REVIEW_USER_ID:int = -1; // special userId that is used for reviewing games
		public static var IS_LOCAL_CONNECTION_UDERSCORE:Boolean = false;		
		public static var DEFAULT_LOCALCONNECTION_PREFIX:String = ""+AS3_vs_AS2.convertToInt(10000*Math.random());
		public static var MILL_WAIT_BEFORE_DO_REGISTER:int = 100;
		public static var TRACE_RETRY:Boolean = false;	
		
		public static var MILL_AFTER_ALLOW_DOMAINS:int = 100;
		public static var AGREE_ON_PREFIX:Boolean = true;
		public static var ALLOW_DOMAIN:String = "*";
		public static function showError(msg:String):void {
			StaticFunctions.showError(msg);
		}
		public static function throwError(msg:String):void {
			StaticFunctions.throwError(msg);
		}		
		public static function assert(val:Boolean, name:String, ...args):void {
			StaticFunctions.assert(val, name, args);
		}

		// I added the "_" on purpose because of different domains issues, see: http://livedocs.adobe.com/flex/gumbo/langref/flash/net/LocalConnection.html
		public static function getDoChanelString(sRandomPrefix:String):String {
			if(IS_LOCAL_CONNECTION_UDERSCORE)
				return "_DO_CHANEL_"+sRandomPrefix;
			return "DO_CHANEL_"+sRandomPrefix;
		}
		public static function getGotChanelString(sRandomPrefix:String):String {
			if(IS_LOCAL_CONNECTION_UDERSCORE)
				return "_GOT_CHANEL_"+sRandomPrefix;
			return "GOT_CHANEL_"+sRandomPrefix;
		}
		public static function getInitChanelString(sPrefix:String):String {
			if(IS_LOCAL_CONNECTION_UDERSCORE)
				return "_INIT_CHANEL_"+sPrefix;
			return "INIT_CHANEL_"+sPrefix;
		}
		public static function getLoaderInfoParameter(_someMovieClip:DisplayObjectContainer, param:String):String {
			return AS3_vs_AS2.getLoaderInfoParameters(_someMovieClip)[param];
		}
		public static function getPrefixFromFlashVars(_someMovieClip:DisplayObjectContainer):String {
			var parameters:Object = AS3_vs_AS2.getLoaderInfoParameters(_someMovieClip);
			var sPrefix:String = parameters["prefix"];
			if (sPrefix==null) sPrefix = parameters["?prefix"];
			return getPrefixFromString(sPrefix);
		}		
		public static function getPrefixFromString(sPrefix:String):String {			
			return sPrefix;
		}
		
		
		/**
		 * In AS3 it is more efficient to use direct method calls then to use LocalConnection.
		 * If the game is loaded with the parameter "prefix=usingAS3"
		 * using method calls instead of LocalConnection in AS3.
		 * We still must serialize and deserialize because the API_* classes are different.
		 */ 
		public static var CREATED_STACKTRACE:Error = null;
		public static var SINGLETON:LocalConnectionUser = null;
		public static var USING_AS3_PREFIX:String = "usingAS3";
		public static var AS3_RECEIVER_CLASS_NAME:String = "come2play_as3.auto_copied::LocalConnectionUser"; // set using reflection
		public function trySendMessageUsingAS3(msg:Object):String {
			var xlass:Class;
			try {
				xlass = AS3_vs_AS2.getClassByName(AS3_RECEIVER_CLASS_NAME);
			} catch (e:Error) {
				// because container or game were not loaded yet
				return "class not found";
			}
			var singleton:Object = xlass["SINGLETON"];
			if (singleton==null) return "singleton is null"; 
			// NOTE that singleton of the other class is not 
			// 	come2play_as3.api.auto_copied.LocalConnectionUser
			// but it is
			// 	come2play_as3.auto_copied.LocalConnectionUser
			// So you cannot cast it to LocalConnectionUser
			ErrorHandler.catchErrors("trySendMessageUsingAS3", singleton.localconnection_callback, [msg]);
			return null;
		}
		
				
		
		// we use a LocalConnection to communicate with the container
		private var lcUser:LocalConnection; 
		private var lcInit:LocalConnection;
		private var sSendChanel:String;
		private var sInitChanel:String;
		private var isContainer:Boolean;
		private var randomPrefix:String;
		private var sendPrefixInterval:MyInterval;
		private var handShakeMade:Boolean = false;
		public var verifier:ProtocolVerifier;
		public var _shouldVerify:Boolean;
		private var isUsingAS3:Boolean;
		public var originalPrefix:String;
		private var SENT_LOG:Logger;
		private var GOT_LOG:Logger;
		//Constructor
		public function LocalConnectionUser(_someMovieClip:DisplayObjectContainer, isContainer:Boolean, sPrefix:String,shouldVerify:Boolean) {
			try {
				var namePrefix:String = isContainer?"CONTAINER":"GAME";
				SENT_LOG = new Logger(namePrefix+"_SENT_MSG",50);
				GOT_LOG = new Logger(namePrefix+"_GOT_MSG",50);
				this.originalPrefix = sPrefix;
				this.isUsingAS3 = sPrefix==USING_AS3_PREFIX;
							
				if (!isContainer) // in the container we apply the reflection in RoomLogic (e.g., for a room we do not have a localconnection) 
					StaticFunctions.performReflectionFromFlashVars(_someMovieClip);
				StaticFunctions.allowDomains();
				_shouldVerify=shouldVerify;
				AS3_vs_AS2.registerNativeSerializers();
				API_LoadMessages.useAll();	
				verifier = new ProtocolVerifier();
				this.isContainer = isContainer;
				StaticFunctions.storeTrace(["ProtocolVerifier=",verifier]);
				StaticFunctions.someMovieClip = _someMovieClip;
				
				if (sPrefix==null) {
					lcTrace(["WARNING: didn't find 'prefix' in the loader info parameters. Probably because you are doing testing locally."]);
					sPrefix = DEFAULT_LOCALCONNECTION_PREFIX;
				}
				
				if (!isUsingAS3) {			
					sInitChanel = getInitChanelString(sPrefix);		
					if (MILL_AFTER_ALLOW_DOMAINS == 0){
						buildConnection();
					}else{
						ErrorHandler.myTimeout("buildConnection",AS3_vs_AS2.delegate(this,this.buildConnection),MILL_AFTER_ALLOW_DOMAINS);	
					}					
				} else {
					// in AS3 we prefer to use direct method calls (using the static SINGLETON member), 
					// instead of LocalConnection (which has size limitations)
					// putting a value in SINGLETON means that the init is done (so it must be done after API_LoadMessages) 
					StaticFunctions.assert(SINGLETON==null,"You can create a LocalConnectionUser only once!",[CREATED_STACKTRACE]);
					CREATED_STACKTRACE = new Error("CREATED_STACKTRACE");
					SINGLETON = this;
					
					madeConnection();
				}

			} catch (err:Error) {
				ErrorHandler.handleError(err, this);
			}	
		}
		
		private function buildConnection():void{
			var failedConnect:Boolean = false;
			try{
				if(AGREE_ON_PREFIX){
					if(lcInit == null){
						lcInit = createLocalConnection()
						AS3_vs_AS2.addStatusListener(lcInit, this, ["localconnection_init"],  AS3_vs_AS2.delegate(this, this.connectionHandler));
					}
					if(!isContainer){
						randomPrefix = String(StaticFunctions.random(1,1000000));
						lcTrace(["Game Attempting to send the randomPrefix with which LocalConnections will communicate. . . randomPrefix=",randomPrefix])
						localconnection_init(randomPrefix);
						sendPrefixInterval = new MyInterval( "sendLocalConnectionPrefix" );
						sendPrefixInterval.start( AS3_vs_AS2.delegate(this, this.sendPrefix),MILL_WAIT_BEFORE_DO_REGISTER);
					}else{
						lcTrace(["Container started listening to stuff on ",sInitChanel])
						lcInit.connect(sInitChanel);	
					}	
				}else{
					localconnection_init(sInitChanel)
				}	

			}catch (err:Error) { 
				failedConnect = true;
				ErrorHandler.myTimeout("buildLocalConnection", AS3_vs_AS2.delegate(this,this.buildConnection),1000);
			}
			if(!failedConnect) madeConnection();
			
		}
		protected function madeConnection():void {}
		
		private function connectionHandler(isSuccess:Boolean):void {
			lcTrace(["Depracated connectionHandler sending random prefix isSuccess: "+isSuccess,"my_user_prefix ",sInitChanel]);
		}

		private static var LC_LOG:Logger = new Logger("LocalConnection",10);
		private function lcTrace(msg:Array):void {	
			LC_LOG.log([AS3_vs_AS2.getClassName(this),": ",msg]);
		}
		
        protected function getErrorMessage(withObj:Object, err:Error):String {
        	return "Error occurred when passing "+JSON.stringify(withObj)+", the error is=\n\t\t"+AS3_vs_AS2.error2String(err);
        }
        
        public function gotMessage(msg:API_Message):void {}
        
       
		
        public function sendMessage(msg:API_Message):void {
        	SENT_LOG.log(msg);      		
			AS3_vs_AS2.checkObjectIsSerializable(msg);
    		verify(msg, true);    		     	
			retrySendMsg(msg);
        }
        private function retrySendMsg(msg:API_Message):void {
    		var serializedMsg:Object = msg.toObject();
        	var res:String = trySendMessage( serializedMsg );
        	if (res==null) return;
        	if (TRACE_RETRY) 
				StaticFunctions.storeTrace(["sendMessageUsing failed because:",res]);
			assert(/*is*/msg is API_DoRegisterOnServer, "Only DoRegisterOnServer can fail! res=",[res," msg=", msg]);
			ErrorHandler.myTimeout("RetrySendDoRegisterOnServer", AS3_vs_AS2.delegate(this,this.retrySendMsg, msg), MILL_WAIT_BEFORE_DO_REGISTER);			        	
        }
        private function trySendMessage(msg:Object):String { 
        	return isUsingAS3 ?	
        		trySendMessageUsingAS3(msg) : 
        		trySendMessageUsingLocalConnection(msg);
        }
        private function trySendMessageUsingLocalConnection(msg:Object):String {  
        	if (!handShakeMade) return "Did not finish handshake yet"; 
        	if (lcUser == null)	return "lcUser is still null";			  
			try{        	
				//Careful from ArgumentError: Error #2084: The AMF encoding of the arguments cannot exceed 40K.		
				lcUser.send(sSendChanel, "localconnection_callback", msg);  
			}catch(err:Error) { 
				ErrorHandler.handleError(err,msg);
			}        	
			return null;
        }
        private function sendPrefix():void {  				  
			try{
				lcTrace(["sent randomPrefix on ",sInitChanel," randomPrefix sent is:",randomPrefix," Is server: ",isContainer]);	
				lcInit.send(sInitChanel, "localconnection_init", randomPrefix);  
			}catch(err:Error) { 				
				ErrorHandler.handleError(err, ["prefix error,prefix :",randomPrefix]);
			}        	
        }
        private function sendHandShakeDoRegister():void{
        	try{
        		lcUser.send(sSendChanel, "localconnection_callback",API_DoRegisterOnServer.create().toObject());  
        	}catch(err:Error){
        		ErrorHandler.myTimeout("sendHandShakeDoRegister", AS3_vs_AS2.delegate(this,this.sendHandShakeDoRegister),1000);
        	}
        }
        private function verify(msg:API_Message, isSend:Boolean):void {
        	if (!_shouldVerify) return;
        	if (isContainer!=isSend)
    			verifier.msgFromGame(msg);
    		else
    			verifier.msgToGame(msg);        	
        }  
        private function createLocalConnection():LocalConnection{
        	var lc:LocalConnection = new LocalConnection();
        	StaticFunctions.allowDomainForLc(lc);
			lcTrace(["local connection Domain",lc.domain])	
			return lc;
        }
        public function localconnection_init(sRandomPrefix:String):void {
        	if (lcUser != null) return;
        	try{
        		lcTrace(["Container? :",isContainer,"got sRandomPrefix=",sRandomPrefix," on sInitChanel=",sInitChanel]);
        		lcUser = createLocalConnection()
				AS3_vs_AS2.addStatusListener(lcUser, this, ["localconnection_callback"]);
				
				var sDoChanel:String = getDoChanelString(sRandomPrefix);
				var sGotChanel:String = getGotChanelString(sRandomPrefix);
				var sListenChannel:String = 
					isContainer ? sDoChanel : sGotChanel;
				sSendChanel = 
					!isContainer ? sDoChanel : sGotChanel;				
				lcTrace(["Container? :",isContainer,"LocalConnection listens on channel=",sListenChannel," and sends on ",sSendChanel]);
				lcUser.connect(sListenChannel);
				if(isContainer)	sendHandShakeDoRegister();
			} catch(err:Error) { 
				ErrorHandler.handleError(err,"local connection init");
			} 
        }
                   
		
        public function localconnection_callback(msgObj:Object):void {
        	ErrorHandler.catchErrors("GotAPI_Msg",AS3_vs_AS2.delegate(this,this.p_localconnection_callback),[msgObj]);        	
        }
        private function p_localconnection_callback(msgObj:Object):void {
        	var msg:API_Message = null;
    		var deserializedMsg:Object = SerializableClass.deserialize(msgObj);
    		msg = /*as*/deserializedMsg as API_Message;
    		if (msg==null) throwError("msgObj="+JSON.stringify(msgObj)+" is not an API_Message");
    		
    		if (!isUsingAS3) {
        		if((msg is API_DoRegisterOnServer) && (!handShakeMade)){
        			handShakeMade = true;
	        		if(isContainer){	
	        			lcInit.close();	
	        		}else{
	        			sendPrefixInterval.clear();
	        			return;
	        		}
        		}
        	}
    		GOT_LOG.log(msg);
    		verify(msg, false);
    		gotMessage(msg);
        }  
	
		public static function getMsgNum(currentCallback:API_Message):int {
			var msgNum:int = -666;
	    	if (currentCallback is API_GotMatchStarted) msgNum = (/*as*/currentCallback as API_GotMatchStarted).msgNum;
	    	if (currentCallback is API_GotMatchEnded) msgNum = (/*as*/currentCallback as API_GotMatchEnded).msgNum;
	    	if (currentCallback is API_GotStateChanged) msgNum = (/*as*/currentCallback as API_GotStateChanged).msgNum;
	    	return msgNum;
	 	}			
	}
}