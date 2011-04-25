package come2play_as3.api.auto_generated {
//Do not change the code below because this class was generated automatically!

	import flash.display.*;	import flash.utils.*;
	import come2play_as3.api.*;
	import come2play_as3.api.auto_copied.*;
	import come2play_as3.api.auto_generated.*;

	public  class API_DoStoreState extends API_Message {
		public var userEntries:Array/*UserEntry*/;
		public var revealEntries:Array/*RevealEntry*/;
		public static function create(userEntries:Array/*UserEntry*/, revealEntries:Array/*RevealEntry*//*<InAS3>*/ = null /*</InAS3>*/):API_DoStoreState {
			var res:API_DoStoreState = new API_DoStoreState();
			res.userEntries = userEntries;

// This is a AUTOMATICALLY GENERATED! Do not change!

			res.revealEntries = revealEntries;
			return res;
		}
		public static var FUNCTION_ID:int = -118;
		public static var METHOD_NAME:String = 'doStoreState';
		public static var METHOD_PARAMS:Array = ['userEntries', 'revealEntries'];
	}
}
