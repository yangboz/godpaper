package come2play_as3.api
{
	import come2play_as3.api.auto_copied.AS3_vs_AS2;
	import come2play_as3.api.auto_generated.API_Message;
	import come2play_as3.api.auto_generated.ClientGameAPI;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;

	public class EventClientGameAPI extends ClientGameAPI
	{
		static public const API_GotStateChanged:String = "API_GotStateChanged";
		static public const API_GotMatchStarted:String = "API_GotMatchStarted";
		static public const API_GotMatchEnded:String = "API_GotMatchEnded";
		static public const API_GotCustomInfo:String = "API_GotCustomInfo";
		static public const API_GotUserInfo:String = "API_GotUserInfo";
		static public const API_GotUserDisconnected:String = "API_GotUserDisconnected";
		
		
		public var dispatcher:EventDispatcher;
		public function EventClientGameAPI(someMovieClip:DisplayObjectContainer)
		{
			super(someMovieClip);
			dispatcher = new EventDispatcher();
		}
		public function addEventListener(type:String,listener:Function,useCapture:Boolean = false,priority:int = 0,useWeakReference:Boolean = false ):void
		{
			AS3_vs_AS2.myAddEventListener(dispatcher, type,listener,useCapture,priority,useWeakReference);
		}
		override public function dispatchMessage(msg:API_Message):void
		{
			dispatcher.dispatchEvent(msg);
		}
		
	}
}