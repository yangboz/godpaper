package come2play_as3.api.auto_generated {
//Do not change the code below because this class was generated automatically!

	import flash.display.*;	import flash.utils.*;
	import come2play_as3.api.*;
	import come2play_as3.api.auto_copied.*;
	import come2play_as3.api.auto_generated.*;

	public  class API_DoAllEndMatch extends API_Message {
		public var finishedPlayers:Array/*PlayerMatchOver*/;
		public static function create(finishedPlayers:Array/*PlayerMatchOver*/):API_DoAllEndMatch {
			var res:API_DoAllEndMatch = new API_DoAllEndMatch();
			res.finishedPlayers = finishedPlayers;
			return res;

// This is a AUTOMATICALLY GENERATED! Do not change!

		}
		public static var FUNCTION_ID:int = -116;
		public static var METHOD_NAME:String = 'doAllEndMatch';
		public static var METHOD_PARAMS:Array = ['finishedPlayers'];
	}
}
