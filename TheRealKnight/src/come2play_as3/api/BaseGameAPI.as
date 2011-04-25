package come2play_as3.api {
	import come2play_as3.api.auto_copied.*;
	import come2play_as3.api.auto_generated.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.external.*;
	import flash.net.*;
	import flash.utils.*;
	
	/**
	 * See http://code.google.com/p/multiplayer-api
	 */ 
	public class BaseGameAPI extends LocalConnectionUser 
	{        
		private static var ANIMATIONS_LOG:Logger = new Logger("ANIMATIONS",20);
		public static var ERROR_DO_ALL:String = "You can only call a doAll* message when the server calls gotStateChanged, gotMatchStarted, gotMatchEnded, or gotRequestStateCalculation.";
		public static var GAME_USE_KEYBOARD:Boolean = true;
		
		private var msgsInTransaction:Array/*API_Message*/ = null;
		private var serverStateMiror:ObjectDictionary;
		private var currentCallback:API_Message = null;
		private var hackerUserId:int = -1;
		private var runningAnimations:Array/*String*/ = [];
		private var keys:Array;
		private var singlePlayerEmulator:SinglePlayerEmulator;
		
		private var singlePlayerGamesDone:int = 0
		private var normalGamesDone:int = 0
		private static var ALL_LOG:Logger = new Logger("BaseGameAPI",10);
		private static var KEYBOARD_LOG:Logger = new Logger("KEYBOARD",20);
		
		public function BaseGameAPI(_someMovieClip:DisplayObjectContainer) {
			super(_someMovieClip, false, getPrefixFromFlashVars(_someMovieClip),true);	
			
			if (GAME_USE_RTMFP) RTMFP = new RtmfpConnection(this);
			
			ErrorHandler.IGNORE_FREEZE_BUG = true;
			ALL_LOG.hugeLog(this);
			ErrorHandler.SEND_BUG_REPORT = AS3_vs_AS2.delegate(this, this.sendBugReport);
			if (GAME_USE_KEYBOARD) 
				AS3_vs_AS2.addKeyboardListener(_someMovieClip, AS3_vs_AS2.delegate(this,this.keyPressed));
			if (originalPrefix==null) 
				singlePlayerEmulator = new SinglePlayerEmulator(_someMovieClip); // to prevent garbage collection
			//come2play_as3.api::BaseGameAPI.abc = 666
		}
		private function sendBugReport(bug_id:int, errMessage:String):void {
				// we take the traces in the container in AS3 by calling come2play_as3.api::StaticFunctions.getTraces()
				// in AS2, I limit the traces to 10KB because LocalConnection has a limit of 40KB for messages.
			if (!AS3_vs_AS2.isAS3)
				errMessage = errMessage + StaticFunctions.cutString(StaticFunctions.getTraces(),10000); 
			sendMessage( API_DoAllFoundHacker.create(hackerUserId,errMessage) ); 
		}
		override public function toString():String {
			var output:Array/*String*/ = [];
			output.push("Server State(client side) : \n\n");					
			var serverEntries:Array/*ServerEntry*/ = new Array();
			if(serverStateMiror!=null){
				for each(var serverEntry:ServerEntry in serverStateMiror.allValues){
					serverEntries.push(serverEntry);
					output.push(serverEntry.toString() + "\n");
				}
			}
			
			output.push("Custom Data:\n\n"+getTAsArray().join("\n"));
			var currentPlayers:CurrentPlayers = verifier.getCurrentPlayers();
			var gotMatchStarted:API_GotMatchStarted = API_GotMatchStarted.create(0,currentPlayers.getAllPlayerIds(),currentPlayers.getFinishedPlayerIds(),serverEntries)
			return "\n\nBaseGameAPI:"+
				"\nrunningAnimations="+runningAnimations+
				"\ncurrentCallback="+currentCallback+
				"\nmsgsInTransaction="+JSON.stringify(msgsInTransaction)+
				"\nSingle Player games done="+singlePlayerGamesDone+
				"\nMulti Player games done="+normalGamesDone+
				"\n\nfake gotMatchStarted for user("+getMyUserId()+"): \n\n"+JSON.stringify(gotMatchStarted)+
				"\n"+output.join("");					
		}
		
		private function keyPressed(is_key_down:Boolean, charCode:int, keyCode:int, keyLocation:int, altKey:Boolean, ctrlKey:Boolean, shiftKey:Boolean):void{
			KEYBOARD_LOG.log("is_key_down=",is_key_down,"charCode=",charCode,"keyCode=",keyCode,"keyLocation=",keyLocation,"altKey=",altKey,"ctrlKey=",ctrlKey,"shiftKey=",shiftKey);
			
			if((shiftKey) && (ctrlKey) && (altKey) && (is_key_down) && T.custom("ENABLE COMMANDS",true) ) {
				if('G'.charCodeAt(0) == charCode)	AS3_vs_AS2.showMessage(StaticFunctions.getTraces(), "traces");
				if('E'.charCodeAt(0) == charCode) {
					// testing throwing an error	
					//throw new Error("Testing throwing an error!");
				}
			}
			if (!T.custom(API_Message.CUSTOM_INFO_KEY_isFocusInChat,false) &&
				!T.custom(API_Message.CUSTOM_INFO_KEY_isPause,false)){				 	
					var keyBoardEvent:API_GotKeyboardEvent = API_GotKeyboardEvent.create(is_key_down, charCode, keyCode, keyLocation, altKey, ctrlKey, shiftKey)					
					dispatchMessage(keyBoardEvent);
				 }
				
		}
		private function getTAsArray():Array/*InfoEntry*/
		{
			var infoEntries:Array/*InfoEntry*/ = new Array();
			var custom:Object = T.getCustom();
			for(var str:String in custom)
				infoEntries.push(InfoEntry.create(str,custom[str]))
			return infoEntries;
		}
		public function tryIncreaseBet():void{
			StaticFunctions.someMovieClip.dispatchEvent(new Event(StaticFunctions.INCREASE_BET_EVENT))
		}
		public function getMyUserId():int {
			return AS3_vs_AS2.as_int(T.custom(API_Message.CUSTOM_INFO_KEY_myUserId,0));
		}
		public function trackEvent(catagory:String,action:String,label:String=null,value:Number=1):void{
			
		}
		/**
		 * If your overriding 'got' methods will throw an Error,
		 * 	then hackerUserId will be declared as a hacker.
		 * We automatically set hackerUserId to storedByUserId 
		 * 	whenever receiving gotStateChanged,
		 * 	however, when the state changes after doAllReveal then
		 * 	storedByUserId is -1, so your code should call setMaybeHackerUserId.
		 */
		
		public function setMaybeHackerUserId(hackerUserId:int):void {
			this.hackerUserId = hackerUserId;			
		}
		/** 
		 * A transaction starts when the server calls
		 * 	a 'got' method (e.g., gotStateChanged).
		 * The transaction normally ends when your overriding 'got' method returns.
		 * However, if you start animations, 
		 * 	then the transaction continues until all the animation will end.
		 * A transaction must be ended after X seconds (see ProtocolVerifier.MAX_ANIMATION_MILLISECONDS),
		 * so make sure your animations are short (less than 5 seconds).
		 * 
		 * You may call doAll methods if and only if you are inside a transaction,
		 * and doStoreState if and only if you are not inside a transaction.
		 * 
		 * Animations may be displayed only inside a transaction.
		 */		 
        public function animationStarted(animationName:String):void {
        	checkInsideTransaction();
        	ANIMATIONS_LOG.log(["Started:",animationName]);
        	runningAnimations.push(animationName);        	
        }
        public function animationEnded(animationName:String):void {
        	checkInsideTransaction();
        	ANIMATIONS_LOG.log(["Ended:",animationName]);
        	var wasRemoved:Boolean = StaticFunctions.removeElement(runningAnimations,animationName);
        	if (!wasRemoved)
        		throwError("Called animationEnded with animationName="+animationName+" that is not a running animation!");
        	sendFinishedCallback();        	        	
        }		
		
		/****************************
		 * Below this line we only have private and overriding methods.
		 */
        public function isInTransaction():Boolean {
        	return msgsInTransaction!=null
        }
        private function checkInsideTransaction():void {
        	if (!isInTransaction()) 
        		throwError("You can start/end an animation only when the server called some 'got' callback");
        }
        private function sendFinishedCallback():void {
        	checkInsideTransaction();        	
        	if (runningAnimations.length>0) return;
        	var msgNum:int = LocalConnectionUser.getMsgNum(currentCallback); 
        	var transaction:API_Transaction = API_Transaction.create(API_DoFinishedCallback.create(StaticFunctions.getMethodName(currentCallback),msgNum), msgsInTransaction);
    		
    		msgsInTransaction = null;
			currentCallback = null;
       		super.sendMessage(transaction);
        }
        private function updateMirorServerState(serverEntries:Array/*ServerEntry*/):void
        {
        	for each (var serverEntry:ServerEntry in serverEntries) {
        	    serverStateMiror.addEntry(serverEntry);	
        	}     	
        }
        public function getServerEntry(key:Object):ServerEntry
        {
        	return /*as*/serverStateMiror.getValue(key) as ServerEntry;
        }
        
        override public function gotMessage(msg:API_Message):void {
        	if (isInTransaction()) {					
    			throwError("The container sent an API message without waiting for DoFinishedCallback");
			}
    		if (runningAnimations.length!=0 || currentCallback!=null)
    			throwError("Internal error! runningAnimations="+runningAnimations+" msgsInTransaction="+msgsInTransaction+" currentCallback="+currentCallback);
    			
        	try {        		
				msgsInTransaction = []; // we start a transaction
				animationStarted("BaseGameAPI.gotMessage");
				currentCallback = msg;
				
        		hackerUserId = -1;
        		
        		var isRTMFPMessage:Boolean = false;
        		
	    		if (msg is API_GotStateChanged) {
	    			var stateChanged:API_GotStateChanged = /*as*/msg as API_GotStateChanged;
	    			if (RTMFP!=null) isRTMFPMessage = RTMFP.gotStateChanged(stateChanged.serverEntries);
	    			 
	    			if (!isRTMFPMessage && stateChanged.serverEntries.length >= 1) {
	    				updateMirorServerState(stateChanged.serverEntries);
		    			var serverEntry:ServerEntry = stateChanged.serverEntries[0];
		    			hackerUserId = serverEntry.storedByUserId;
		    		}
		    		
	    		} else if (msg is API_GotMatchEnded) {
					if (RTMFP!=null) RTMFP.gotMatchEnded();
					
	    		} else if (msg is API_GotMatchStarted) {
	    			serverStateMiror = new ObjectDictionary();
					var matchStarted:API_GotMatchStarted = /*as*/msg as API_GotMatchStarted;
					if(matchStarted.allPlayerIds.length == 1){
						singlePlayerGamesDone++;
					}else{
						normalGamesDone++;
					}
					updateMirorServerState(matchStarted.serverEntries);
					if (RTMFP!=null) RTMFP.gotMatchStarted();
	    		} else if (msg is API_GotCustomInfo) {	 					    			
					var customInfo:API_GotCustomInfo = /*as*/msg as API_GotCustomInfo;
					var i18nObj:Object = {};
					var customObj:Object = {};
					for each (var entry:InfoEntry in customInfo.infoEntries) {
						var key:String = entry.key;
						var value:Object = entry.value;
						if (key==API_Message.CUSTOM_INFO_KEY_i18n) {
							i18nObj = value;
						} else if (key==API_Message.CUSTOM_INFO_KEY_reflection) {
							for (var reflectionKey:String in value) {
								StaticFunctions.performReflectionObject(reflectionKey,value[reflectionKey]);
							}
						} else if (key==API_Message.CUSTOM_INFO_KEY_checkThrowingAnError && value==true) {
							throw new Error("We check throwing an error.");
						} else {
							customObj[key] = value;
						}
					}		
					T.initI18n(i18nObj, customObj); // may be called several times because we may pass different 'secondsPerMatch' every time a game starts					
				}else if(msg is API_GotUserInfo){
					var infoMessage:API_GotUserInfo =/*as*/ msg as API_GotUserInfo;
					var userObject:Object = {};
					for each(var infoEntry:InfoEntry  in infoMessage.infoEntries){
						userObject[infoEntry.key] = infoEntry.value;
					}
					T.updateUser(infoMessage.userId, userObject);
					
				}
				if (!isRTMFPMessage) dispatchMessage(msg)

        	} catch (err:Error) {
        		try{				
        			showError(getErrorMessage(msg, err));
				} catch (err2:Error) { 
					// to avoid an infinite loop, I can't call passError again.
					showError("Another error occurred when calling gotError. The new error is="+AS3_vs_AS2.error2String(err2));
				}
    		}
    		animationEnded("BaseGameAPI.gotMessage");     		   	
        }
        public function dispatchMessage(msg:API_Message):void {
        	var methodName:String = StaticFunctions.getMethodName(msg);
			if (AS3_vs_AS2.isAS3 && !this.hasOwnProperty(methodName)) return;
			var func:Function = /*as*/this[methodName] as Function;
			if (func==null) return;
			var params:Array = StaticFunctions.getMethodParameters(msg);
			if (msg is API_GotMatchStarted || msg is API_GotMatchEnded || msg is API_GotStateChanged) {
				StaticFunctions.assert(AS3_vs_AS2.isOnStage(StaticFunctions.someMovieClip),"The game must be on stage when the game is in progress");
				params.shift();
			}
			func.apply(this, params);
        }
        override public function sendMessage(doMsg:API_Message):void {        	
        	if (doMsg is API_DoAllFoundHacker) {
        		var stackTraces:String = AS3_vs_AS2.myGetStackTrace(new Error());
        		if (stackTraces!=null)
        			(/*as*/doMsg as API_DoAllFoundHacker).errorDescription += "\n\nStack traces when sending DoAllFoundHacker:\n"+stackTraces;        		
        	}
        	
        	if (ProtocolVerifier.isPassThrough(doMsg) || doMsg is API_DoStoreState) {
        		super.sendMessage(doMsg);
        		return;
        	}        	
			      	
			if (!isInTransaction()) 
				throwError(ERROR_DO_ALL);	
			
			msgsInTransaction.push(doMsg);			
        }
        
        
        /**
         * Added support for RTMFP
         */  
        public static var GAME_USE_RTMFP:Boolean = false;
		private static var RTMFP:RtmfpConnection;
		
        public final function doDirectBroadcast(msg:Object):void {
        	assert(RTMFP!=null, "You must set GAME_USE_RTMFP to true if you want to use doDirectBroadcast"); 
        	RTMFP.broadcast(msg);        	
        }        
        public function gotDirectBroadcast(fromUserId:int, msg:Object):void {
        	// You should override this method
        }
	}
}