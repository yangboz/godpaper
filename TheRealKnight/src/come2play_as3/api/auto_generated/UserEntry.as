package come2play_as3.api.auto_generated {
//Do not change the code below because this class was generated automatically!

	import flash.display.*;	import flash.utils.*;
	import come2play_as3.api.*;
	import come2play_as3.api.auto_copied.*;
	import come2play_as3.api.auto_generated.*;

	public  class UserEntry extends API_Message {
		public var key:*;
		public var value:*;
		public var isSecret:Boolean;
		public static function create(key:*, value:*, isSecret:Boolean/*<InAS3>*/ = false /*</InAS3>*/):UserEntry {
			var res:UserEntry = new UserEntry();

// This is a AUTOMATICALLY GENERATED! Do not change!

			res.key = key;
			res.value = value;
			/*<InAS2> if (isSecret==null) isSecret = false;</InAS2>*/
			res.isSecret = isSecret;
			return res;
		}
		public static var FUNCTION_ID:int = -87;
		public static var METHOD_NAME:String = 'userEntry';
		public static var METHOD_PARAMS:Array = ['key', 'value', 'isSecret'];
	}

// This is a AUTOMATICALLY GENERATED! Do not change!

}
