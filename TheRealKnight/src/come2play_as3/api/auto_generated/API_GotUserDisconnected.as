package come2play_as3.api.auto_generated {
//Do not change the code below because this class was generated automatically!

	import flash.display.*;	import flash.utils.*;
	import come2play_as3.api.*;
	import come2play_as3.api.auto_copied.*;
	import come2play_as3.api.auto_generated.*;

	public  class API_GotUserDisconnected extends API_Message {
		public var userId:int;
		public static function create(userId:int):API_GotUserDisconnected {
			var res:API_GotUserDisconnected = new API_GotUserDisconnected();
			res.userId = userId;
			return res;

// This is a AUTOMATICALLY GENERATED! Do not change!

		}
		public static var FUNCTION_ID:int = -122;
		public static var METHOD_NAME:String = 'gotUserDisconnected';
		public static var METHOD_PARAMS:Array = ['userId'];
	}
}
