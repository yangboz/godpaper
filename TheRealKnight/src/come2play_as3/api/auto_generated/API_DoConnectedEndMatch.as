package come2play_as3.api.auto_generated {
//Do not change the code below because this class was generated automatically!

	import flash.display.*;	import flash.utils.*;
	import come2play_as3.api.*;
	import come2play_as3.api.auto_copied.*;
	import come2play_as3.api.auto_generated.*;

	public  class API_DoConnectedEndMatch extends API_Message {
		public var didWin:Boolean;
		public static function create(didWin:Boolean):API_DoConnectedEndMatch {
			var res:API_DoConnectedEndMatch = new API_DoConnectedEndMatch();
			res.didWin = didWin;
			return res;

// This is a AUTOMATICALLY GENERATED! Do not change!

		}
		public static var FUNCTION_ID:int = -106;
		public static var METHOD_NAME:String = 'doConnectedEndMatch';
		public static var METHOD_PARAMS:Array = ['didWin'];
	}
}
