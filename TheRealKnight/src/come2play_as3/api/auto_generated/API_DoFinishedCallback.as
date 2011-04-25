package come2play_as3.api.auto_generated {
//Do not change the code below because this class was generated automatically!

	import flash.display.*;	import flash.utils.*;
	import come2play_as3.api.*;
	import come2play_as3.api.auto_copied.*;
	import come2play_as3.api.auto_generated.*;

	public  class API_DoFinishedCallback extends API_Message {
		public var callbackName:String;
		public var msgNum:int;
		public static function create(callbackName:String, msgNum:int):API_DoFinishedCallback {
			var res:API_DoFinishedCallback = new API_DoFinishedCallback();
			res.callbackName = callbackName;

// This is a AUTOMATICALLY GENERATED! Do not change!

			res.msgNum = msgNum;
			return res;
		}
		public static var FUNCTION_ID:int = -128;
		public static var METHOD_NAME:String = 'doFinishedCallback';
		public static var METHOD_PARAMS:Array = ['callbackName', 'msgNum'];
	}
}
