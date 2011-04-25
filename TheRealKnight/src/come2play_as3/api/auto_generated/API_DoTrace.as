package come2play_as3.api.auto_generated {
//Do not change the code below because this class was generated automatically!

	import flash.display.*;	import flash.utils.*;
	import come2play_as3.api.*;
	import come2play_as3.api.auto_copied.*;
	import come2play_as3.api.auto_generated.*;

	public  class API_DoTrace extends API_Message {
		public var name:String;
		public var message:Object;
		public static function create(name:String, message:Object):API_DoTrace {
			var res:API_DoTrace = new API_DoTrace();
			res.name = name;

// This is a AUTOMATICALLY GENERATED! Do not change!

			res.message = message;
			return res;
		}
		public static var FUNCTION_ID:int = -126;
		public static var METHOD_NAME:String = 'doTrace';
		public static var METHOD_PARAMS:Array = ['name', 'message'];
	}
}
