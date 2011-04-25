package come2play_as3.api.auto_generated {
//Do not change the code below because this class was generated automatically!

	import flash.display.*;	import flash.utils.*;
	import come2play_as3.api.*;
	import come2play_as3.api.auto_copied.*;
	import come2play_as3.api.auto_generated.*;

	public  class API_DoAllStoreState extends API_Message {
		public var userEntries:Array/*UserEntry*/;
		public static function create(userEntries:Array/*UserEntry*/):API_DoAllStoreState {
			var res:API_DoAllStoreState = new API_DoAllStoreState();
			res.userEntries = userEntries;
			return res;

// This is a AUTOMATICALLY GENERATED! Do not change!

		}
		public static var FUNCTION_ID:int = -117;
		public static var METHOD_NAME:String = 'doAllStoreState';
		public static var METHOD_PARAMS:Array = ['userEntries'];
	}
}
