package come2play_as3.api.auto_generated {
//Do not change the code below because this class was generated automatically!

	import flash.display.*;	import flash.utils.*;
	import come2play_as3.api.*;
	import come2play_as3.api.auto_copied.*;
	import come2play_as3.api.auto_generated.*;

	public  class API_GotStateChanged extends API_Message {
		public var msgNum:int;
		public var serverEntries:Array/*ServerEntry*/;
		public static function create(msgNum:int, serverEntries:Array/*ServerEntry*/):API_GotStateChanged {
			var res:API_GotStateChanged = new API_GotStateChanged();
			res.msgNum = msgNum;

// This is a AUTOMATICALLY GENERATED! Do not change!

			res.serverEntries = serverEntries;
			return res;
		}
		public static var FUNCTION_ID:int = -119;
		public static var METHOD_NAME:String = 'gotStateChanged';
		public static var METHOD_PARAMS:Array = ['msgNum', 'serverEntries'];
	}
}
