package come2play_as3.api.auto_generated {
//Do not change the code below because this class was generated automatically!

	import flash.display.*;	import flash.utils.*;
	import come2play_as3.api.*;
	import come2play_as3.api.auto_copied.*;
	import come2play_as3.api.auto_generated.*;

	public  class API_DoAllSetTurn extends API_Message {
		public var userId:int;
		public var milliSecondsInTurn:int;
		public static function create(userId:int, milliSecondsInTurn:int/*<InAS3>*/ = -1 /*</InAS3>*/):API_DoAllSetTurn {
			var res:API_DoAllSetTurn = new API_DoAllSetTurn();
			res.userId = userId;

// This is a AUTOMATICALLY GENERATED! Do not change!

			/*<InAS2> if (milliSecondsInTurn==null) milliSecondsInTurn = -1;</InAS2>*/
			res.milliSecondsInTurn = milliSecondsInTurn;
			return res;
		}
		public static var FUNCTION_ID:int = -115;
		public static var METHOD_NAME:String = 'doAllSetTurn';
		public static var METHOD_PARAMS:Array = ['userId', 'milliSecondsInTurn'];
	}
}
