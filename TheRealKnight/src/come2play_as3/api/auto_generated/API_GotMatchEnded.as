package come2play_as3.api.auto_generated {
//Do not change the code below because this class was generated automatically!

	import flash.display.*;	import flash.utils.*;
	import come2play_as3.api.*;
	import come2play_as3.api.auto_copied.*;
	import come2play_as3.api.auto_generated.*;

	public  class API_GotMatchEnded extends API_Message {
		public var msgNum:int;
		public var finishedPlayerIds:Array/*int*/;
		public static function create(msgNum:int, finishedPlayerIds:Array/*int*/):API_GotMatchEnded {
			var res:API_GotMatchEnded = new API_GotMatchEnded();
			res.msgNum = msgNum;

// This is a AUTOMATICALLY GENERATED! Do not change!

			res.finishedPlayerIds = finishedPlayerIds;
			return res;
		}
		public static var FUNCTION_ID:int = -120;
		public static var METHOD_NAME:String = 'gotMatchEnded';
		public static var METHOD_PARAMS:Array = ['msgNum', 'finishedPlayerIds'];
	}
}
