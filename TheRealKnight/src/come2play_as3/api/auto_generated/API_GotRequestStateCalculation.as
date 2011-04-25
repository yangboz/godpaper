package come2play_as3.api.auto_generated {
//Do not change the code below because this class was generated automatically!

	import flash.display.*;	import flash.utils.*;
	import come2play_as3.api.*;
	import come2play_as3.api.auto_copied.*;
	import come2play_as3.api.auto_generated.*;

	public  class API_GotRequestStateCalculation extends API_Message {
		public var requestId:int;
		public var serverEntries:Array/*ServerEntry*/;
		public static function create(requestId:int, serverEntries:Array/*ServerEntry*/):API_GotRequestStateCalculation {
			var res:API_GotRequestStateCalculation = new API_GotRequestStateCalculation();
			res.requestId = requestId;

// This is a AUTOMATICALLY GENERATED! Do not change!

			res.serverEntries = serverEntries;
			return res;
		}
		public static var FUNCTION_ID:int = -109;
		public static var METHOD_NAME:String = 'gotRequestStateCalculation';
		public static var METHOD_PARAMS:Array = ['requestId', 'serverEntries'];
	}
}
