package come2play_as3.api.auto_generated {
//Do not change the code below because this class was generated automatically!

	import flash.display.*;	import flash.utils.*;
	import come2play_as3.api.*;
	import come2play_as3.api.auto_copied.*;
	import come2play_as3.api.auto_generated.*;

	public  class API_Transaction extends API_Message {
		public var callback:API_DoFinishedCallback;
		public var messages:Array/*API_Message*/;
		public static function create(callback:API_DoFinishedCallback, messages:Array/*API_Message*/):API_Transaction {
			var res:API_Transaction = new API_Transaction();
			res.callback = callback;

// This is a AUTOMATICALLY GENERATED! Do not change!

			res.messages = messages;
			return res;
		}
		public static var FUNCTION_ID:int = -84;
		public static var METHOD_NAME:String = 'aPI_Transaction';
		public static var METHOD_PARAMS:Array = ['callback', 'messages'];
	}
}
