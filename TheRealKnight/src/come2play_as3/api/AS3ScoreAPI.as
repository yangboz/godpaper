package come2play_as3.api
{
	import flash.display.Loader;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	public class AS3ScoreAPI
	{
		//external flags
		// The following 2 parameters shouldn't change
		// If necessary, they must be changed before calling to preload
		static public var withPreloadLogo:Boolean = true;
		static private var defaultBet:Boolean = false;
		
		// internal flags
		static private var preloadCalled:Boolean = false;
		static public const LOCAL_TESTING:Boolean = false;	//don't change this
		
		// data and instances
		
		static private var myData:Object = null;
		static private var _stage:Stage;
		static private var as2_Loader:Loader;
		static private var oldFrameRate:Number;
		
		// callbacks to game
		static private var doneFunc:Function;
		static private var successFunc:Function;
		
		// connections
		static private var receiving_lc:LocalConnection;
		static private var sending_lc:LocalConnection;
		static private var lcid:uint; // random localconnection int
		static private var sendChannel:String;
		static private var receiveChannel:String;
		static private var myClient:Object;
		

		static public function preload(stage:Stage, game_id:String, game_width:Number, game_height:Number, doneFunc:Function = null):void
		{
			trace("AS3ScoreAPI: prelaod version 3: "+game_id);
			
			if ( preloadCalled ) throw new Error("AS3ScoreAPI: can't preload more than once");
			preloadCalled = true;
			
			AS3ScoreAPI.doneFunc = function():void{
				_stage.frameRate = oldFrameRate	
				if(doneFunc!=null)	doneFunc()
			};
			
			oldFrameRate = stage.frameRate;
			stage.frameRate = 18;
			
			init(stage,game_id, game_width, game_height);
		}
		
		static private function init(stage:Stage, game_id:String, game_width:Number, game_height:Number):void
		{
			trace("AS3ScoreAPI: init");
			if(stage == null)	throw new Error("Stage cannot be null");
			
			_stage = stage;
			myData = {game_id:game_id}
			for(var key:String in _stage.loaderInfo.parameters)
			{
				myData[key] = _stage.loaderInfo.parameters[key]
			}
			
			myData["width"] = game_width;
			myData["height"] = game_height;
			myData["url"] = _stage.loaderInfo.url;
			myData["withPreloadLogo"] = withPreloadLogo;
			myData["defaultBet"] = defaultBet;
			
			if ( LOCAL_TESTING )
			{
				//myData["c2p_hideChallenge"] = false;
				myData["c2p_preloaderLogo"] = "http://static.come2play.net/Shared/swf/components/AnimatedLogo/AnimatedLogo_0_3.swf";
				myData["loadBridgeURL"] = "X://come2play/svn/as2_singlePlayerBridge/main.swf?c2p_endMatchCall=endMatchCall&c2p_twitter=share_on_twitter&c2p_facebook=share_on_facebook&c2p_myspace=share_on_mypsace&c2p_challenge=send_challenge&c2p_hideChallenge=true";
				myData["c2p_preloaderLink"] = "http://come2play.com";
			}	
			
			createConnection();
			// real one
			var url:String = "http://www.come2play.com/shared/api/singlePlayer/get_swf_version.asp?type=singlePlayerBridgeV2&game_id="+myData.game_id+"&c2p_lcid=" + lcid.toString() + "&NoCache="+Math.random() * 10000000

			// amr
			//var url:String = "http://come2play.amr/shared/api/singlePlayer/get_swf_version.asp?type=singlePlayerBridgeV2&game_id="+myData.game_id+"&c2p_lcid=" + lcid.toString() + "&NoCache="+Math.random() * 10000000
			

			var request:URLRequest = new URLRequest(url);
			request.method = URLRequestMethod.POST;
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE,loadBridge);
			urlLoader.load(request)
		}
		
		static private function preloadingComplete():void
		{
			trace("AS3ScoreAPI: preloading complete callback");
			doneFunc();
		}
		
		static private function createConnection():void 
		{
			lcid = uint( uint.MAX_VALUE * Math.random() );
			sendChannel = "_client2bridge_" + lcid.toString();
			receiveChannel = "_bridge2client_" + lcid.toString();
			
			myClient = {}
			myClient.preloadingComplete = AS3ScoreAPI.preloadingComplete
			myClient.betSent = AS3ScoreAPI.betSent;
			myClient.scoreSent = AS3ScoreAPI.scoreSent;
			receiving_lc = new LocalConnection();
			receiving_lc.client = myClient;
			receiving_lc.allowInsecureDomain("*")
			receiving_lc.allowDomain("*")

			try{
				receiving_lc.connect(receiveChannel);
			} catch(error:ArgumentError) {
				trace(error.message);
				return;
			}
			
			sending_lc = new LocalConnection();
			sending_lc.addEventListener(StatusEvent.STATUS, onStatus);
		}
		
		static public function loadBridge(event:Event):void{
			trace("AS3ScoreAPI: loadBridge")
			var urlLoader:URLLoader = event.target as URLLoader
			var urlVars:URLVariables = new URLVariables(urlLoader.data as String)
			if(urlVars["result"] != "true") throw new Error("AS3ScoreAPI: failed to load bridge");
			
			if (LOCAL_TESTING == false )  loadBridgeURL(urlVars["file"])
			else loadBridgeURL("X://come2play/svn/\as2_singlePlayerBridge/main.swf?c2p_endMatchCall=endMatchCall&c2p_twitter=share_on_twitter&c2p_facebook=share_on_facebook&c2p_myspace=share_on_mypsace&c2p_challenge=send_challenge&c2p_hideChallenge=true&c2p_lcid=" + lcid.toString())
		}
		
		static private function loadBridgeURL(url:String):void
		{
			trace("AS3ScoreAPI: loadBridgeURL: "+url);
			as2_Loader = new Loader();
			as2_Loader.load(new URLRequest(url));
			as2_Loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadBridgeComplete);
			_stage.addChild(as2_Loader);
		}
		
		static private function loadBridgeComplete(event:Event):void
		{
			trace("AS3ScoreAPI: load Bridge Complete");
			sending_lc.send(sendChannel,"init", myData);
		}
		
		
		// callbacks from Bridge
		
		static private function scoreSent():void
		{
			trace("AS3ScoreAPI: scoreSent");
			if(successFunc!=null)	successFunc();
		}
		
		static private function betSent():void
		{
			trace("AS3ScoreAPI: betSent");
			if(successFunc!=null)	successFunc();
		}
		
		// calls to Bridge
		
		static public function sendScore(score:Number,successFunc:Function = null):void
		{
			if( !preloadCalled ) throw new Error("AS3ScoreAPI: Must call AS3ScoreAPI.preload before sending score");
			trace("AS3ScoreAPI: sendScore: "+sendScore);
			AS3ScoreAPI.successFunc = successFunc;
			sending_lc.send(sendChannel,"sendScore",score);
		}
		
		static public function sendBet(successFunc:Function = null):void
		{
			if( !preloadCalled ) throw new Error("AS3ScoreAPI: Must call AS3ScoreAPI.preload before sending score");
			if ( defaultBet == true ) throw new Error("AS3ScoreAPI: can't open bet while defaultBet is set to true");
			trace("AS3ScoreAPI: sendBet ");
			AS3ScoreAPI.successFunc = successFunc;
			
			sending_lc.send(sendChannel,"sendBet");
		}
		
		// very important !! 
		// status for sending_lc.send
		// when loading AS2 and sending it right after loading complete 
		// the event.level is "error" although it works :  so ignore this status 
		static private function onStatus(event:StatusEvent):void
		{
			if ( event.level == "error") trace("AS3ScoreAPI: sending_lc.send() failed");
		}
		
	}
}