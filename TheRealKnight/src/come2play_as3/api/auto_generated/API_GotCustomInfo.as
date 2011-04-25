package come2play_as3.api.auto_generated {
//Do not change the code below because this class was generated automatically!

	import flash.display.*;	import flash.utils.*;
	import come2play_as3.api.*;
	import come2play_as3.api.auto_copied.*;
	import come2play_as3.api.auto_generated.*;

	public  class API_GotCustomInfo extends API_Message {
		public var infoEntries:Array/*InfoEntry*/;
		public static function create(infoEntries:Array/*InfoEntry*/):API_GotCustomInfo {
			var res:API_GotCustomInfo = new API_GotCustomInfo();
			res.infoEntries = infoEntries;
			return res;

// This is a AUTOMATICALLY GENERATED! Do not change!

		}
		public static var FUNCTION_ID:int = -124;
		public static var METHOD_NAME:String = 'gotCustomInfo';
		public static var METHOD_PARAMS:Array = ['infoEntries'];
	}
}
