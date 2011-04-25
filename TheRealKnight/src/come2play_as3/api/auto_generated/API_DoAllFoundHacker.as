package come2play_as3.api.auto_generated {
//Do not change the code below because this class was generated automatically!

	import flash.display.*;	import flash.utils.*;
	import come2play_as3.api.*;
	import come2play_as3.api.auto_copied.*;
	import come2play_as3.api.auto_generated.*;

	public  class API_DoAllFoundHacker extends API_Message {
		public var userId:int;
		public var errorDescription:String;
		public static function create(userId:int, errorDescription:String):API_DoAllFoundHacker {
			var res:API_DoAllFoundHacker = new API_DoAllFoundHacker();
			res.userId = userId;

// This is a AUTOMATICALLY GENERATED! Do not change!

			res.errorDescription = errorDescription;
			return res;
		}
		public static var FUNCTION_ID:int = -111;
		public static var METHOD_NAME:String = 'doAllFoundHacker';
		public static var METHOD_PARAMS:Array = ['userId', 'errorDescription'];
	}
}
