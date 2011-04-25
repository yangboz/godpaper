package come2play_as3.api.auto_generated {
//Do not change the code below because this class was generated automatically!

	import flash.display.*;	import flash.utils.*;
	import come2play_as3.api.*;
	import come2play_as3.api.auto_copied.*;
	import come2play_as3.api.auto_generated.*;

	public  class HistoryEntry extends API_Message {
		public var message:API_Message;
		public var gotTimeInMilliSeconds:int;
		public static function create(message:API_Message, gotTimeInMilliSeconds:int):HistoryEntry {
			var res:HistoryEntry = new HistoryEntry();
			res.message = message;

// This is a AUTOMATICALLY GENERATED! Do not change!

			res.gotTimeInMilliSeconds = gotTimeInMilliSeconds;
			return res;
		}
		public static var FUNCTION_ID:int = -85;
		public static var METHOD_NAME:String = 'historyEntry';
		public static var METHOD_PARAMS:Array = ['message', 'gotTimeInMilliSeconds'];
	}
}
