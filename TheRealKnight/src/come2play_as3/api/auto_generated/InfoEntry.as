package come2play_as3.api.auto_generated {
//Do not change the code below because this class was generated automatically!

	import flash.display.*;	import flash.utils.*;
	import come2play_as3.api.*;
	import come2play_as3.api.auto_copied.*;
	import come2play_as3.api.auto_generated.*;

	public  class InfoEntry extends API_Message {
		public var key:String;
		public var value:Object;
		public static function create(key:String, value:Object):InfoEntry {
			var res:InfoEntry = new InfoEntry();
			res.key = key;

// This is a AUTOMATICALLY GENERATED! Do not change!

			res.value = value;
			return res;
		}
		public static var FUNCTION_ID:int = -89;
		public static var METHOD_NAME:String = 'infoEntry';
		public static var METHOD_PARAMS:Array = ['key', 'value'];
	}
}
