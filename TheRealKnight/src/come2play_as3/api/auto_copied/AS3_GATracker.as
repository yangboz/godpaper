package come2play_as3.api.auto_copied
{
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	public final class AS3_GATracker
	{				
		//For each visit (user session), a maximum of approximately 500 combined GATC requests (both events and page views) can be tracked.
		public static var MAX_EVENTS:int = 200;
		public static var MAX_LABEL_LEN:int = 500; // the max label we saw on google was 750, but if you send other parameters (like flash parameters), the limit is even lower.
		/**
		 * This is an example of what is sent in the GET request (that failed with 414) to google:
		 http://www.google-analytics.com/__utm.gif?utmwv=4.3as&utmn=2036791660&utmhn=static.come2play.net&utmt=event&utme=5(Loading*Game%20Loading*Load%20http://static.come2play.net/shared/swf/components/FlexContainers/FlashCode_1_1210.swf/[[DYNAMIC]]/1)(792)&utmcs=UTF-8&utmsr=1400x1050&utmsc=32-bit&utmul=en-us&utmje=0&utmfl=10.0%20r12&utmdt=RoomList%20Flex3&utmhid=813401973&utmr=http://testfb.come2play.com/GameWindow.asp?popup_type=start%5Fgame%5Ffrom%5Finvite%5Furl&user_id=2749296&site_id=27&random_hash=731944573&player_ids=2749296%2C2755063&room_id=304062&start_scenario=SentInvitation&flash_type=game&origin=FlexGame&white_player_id=2749296&black_player_id=2755063&GameName=MineSweeper&utmp=/shared/flex_object/index.asp?swf_version=Code_61_4&site_lang=en&swf_IntroClip=http://static.come2play.net/shared/swf/en/IntroClip&swf_EndMovieAnimation=http://static.come2play.net/shared/swf/en/EndMovieAnimation&swf_FlexBoards=http://static.come2play.net/shared/swf/components/FlexBoards/MineSweeperAS3_board/MineSweeperAS3_board_1_1058&swf_FlexContainers=http://static.come2play.net/shared/swf/components/FlexContainers/FlashCode_1_1210&swf_FlexContainersRelease=http://static.come2play.net/shared/swf/components/FlexContainersRelease/FlashCode_1_1154&swf_FlexGraphics=http://static.come2play.net/shared/swf/components/FlexGraphics/GameGraphics_1_964&swf_AnimatedLogo=http://static.come2play.net/shared/swf/components/AnimatedLogo/AnimatedLogo_0_2&swf_distribution=http://static.come2play.net/shared/swf/components/distribution/distribution_1_980&swf_chatGraphics=http://static.come2play.net/shared/swf/components/chatGraphics/chatGraphics_1_965&swf_Preloader=http://static.come2play.net/shared/swf/components/Preloader/Preloader_1_965&swf_language=http://static.come2play.net/shared/swf/en/language_2&swf_width=460&swf_height=491&popup_type=start_game_from_invite_url&user_id=2749296&site_id=27&random_hash=731944573&player_ids=2749296,2755063&room_id=304062&start_scenario=SentInvitation&flash_type=game&origin=FlexGame&white_player_id=2749296&black_player_id=2755063&GameName=MineSweeper&game_height=491&game_width=460&ts=1243773843&all_java_ips=&utmac=UA-154580-30&utmcn=1&utmcc=__utma%3D225149272.2062124502778886400.1243762273.1243762618.1243763124.3%3B%2B__utmz%3D225149272.1243763124.3.3.utmcsr%3Dtestfb.come2play.com%7Cutmccn%3D(referral)%7Cutmcmd%3Dreferral%7Cutmcct%3D%2Fgamewindow.asp%3B%2B__utmv%3D225149272.MineSweeper%3B
		 * 
		 */
		
		static private var ANALYTIC_LOG:Logger = new Logger("Analytic",30);
		static private var SameKey_LOG:Logger = new Logger("AnalyticSameKey",30);
		static private var ANALYTIC_ERRORS_LOG:Logger = new Logger("AnalyticError",10);
		static private var ANALYTIC_INIT_LOG:Logger = new Logger("AnalyticInit",10);
		public static var COME2PLAY_TRACKER:AS3_GATracker = new AS3_GATracker(null,"UA-154580-30");
				
		private static var TRACK_ONCE:Dictionary = new Dictionary();
		public static function trackWarningOnce(action:String,label:String=null,value:Number=1):void {
			if (TRACK_ONCE[action]!=null) return;
			TRACK_ONCE[action] = true;
			trackWarning(action,label,value);
		}
		public static function trackWarning(action:String,label:String=null,value:Number=1):void {
			COME2PLAY_TRACKER.trackEvent("Warning",action,label,value);
		}
		
		private var realGATracker:Object;
		private var pausedEvents:Array = new Array();
		private var uniqueEvents:Dictionary = new Dictionary();
		private var eventsSent:int = 0;
		public function AS3_GATracker(disp:DisplayObject,id:String,isAS3:String="AS3",arg3:Boolean=false)
		{
			reconstruct(disp,id,isAS3,arg3)
		}
		public function reconstruct(disp:DisplayObject,id:String,isAS3:String="AS3",arg3:Boolean=false):void{
			if(realGATracker!=null)	return;
			var now:int = getTimer();
			try {
				var c:Class = AS3_vs_AS2.getClassByName("com.google.analytics::GATracker");
				realGATracker = new c(disp,id,isAS3,arg3)
				if(varToSet!="")	setVar(varToSet)
				for each(var obj:Object in pausedEvents){
					sendTrackEvent(obj.catagory,obj.action,obj.label,obj.value)
				}
				pausedEvents = [];
				ANALYTIC_INIT_LOG.log("successfully created analytics");
			} catch (err:Error) {
				ANALYTIC_INIT_LOG.log("failed to create analytics");
			}
			var delta:int = getTimer() - now;
			if (delta>2000) {
				ANALYTIC_ERRORS_LOG.log("WARNING: creating analytics took ", delta, " milliseconds");
			}
		}
		private var varToSet:String
		public function setVar(newVal:String):void{
			if(realGATracker == null){
				varToSet = newVal
				return;
			}	
			realGATracker.setVar(newVal)	
		}
		public function trackEvent(catagory:String,action:String,label:String=null,value:Number=1):void{
			ANALYTIC_LOG.log("trackEvent",catagory,action,label,value);
			if(realGATracker==null){
				if (pausedEvents.length>MAX_EVENTS)	return;
				pausedEvents.push({catagory:catagory,action:action,label:label,value:value})
				return;
			}
			if(label==null)	label = action;
			sendTrackEvent(catagory,action,label,value);	
		}
		
		public static var ILLEGAL_CHARS:String = "#";
		public static var ILLEGAL_CHARS_REPLACEMENT:String = "-";
		private function makeLegal(str:String):String {
			// make sure the string is not too long
			str = StaticFunctions.cutString(str,MAX_LABEL_LEN);
			// make sure the string doesn't contain illegal characters
			for (var i:int=0; i<ILLEGAL_CHARS.length; i++) {
				var ch:String = ILLEGAL_CHARS.charAt(i);
				str = StaticFunctions.replaceAll(str,ch,ILLEGAL_CHARS_REPLACEMENT.charAt(i));
			}
			return str;
		}		
		
		private function sendTrackEvent(catagory:String,action:String,label:String,value:Number):void {			
			catagory = makeLegal(catagory);
			action = makeLegal(action);
			label = makeLegal(label);
			
			var uniqueKey:String = catagory+"--"+action+"--"+label;
			if (uniqueEvents[uniqueKey]==true) {
				SameKey_LOG.log("Already used key=",uniqueKey);
				return;
			}
			uniqueEvents[uniqueKey] = true;
			
			eventsSent++;
			
			
			if (eventsSent>=MAX_EVENTS) {
				if (eventsSent==MAX_EVENTS) {
					realGATracker.trackEvent("Errors","Sent too many google events","",getTimer());
					ANALYTIC_ERRORS_LOG.log("ERROR!!! Sent too many events");
				}
				return;				
			}
			realGATracker.trackEvent(catagory,action,label,value);			
		}


	}
}