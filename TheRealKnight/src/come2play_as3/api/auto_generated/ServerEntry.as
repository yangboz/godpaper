package come2play_as3.api.auto_generated {
//Do not change the code below because this class was generated automatically!

	import flash.display.*;	import flash.utils.*;
	import come2play_as3.api.*;
	import come2play_as3.api.auto_copied.*;
	import come2play_as3.api.auto_generated.*;

	public  class ServerEntry extends API_Message {
		public var key:*;
		public var value:*;
		public var storedByUserId:int;
		public var visibleToUserIds:Array/*int*/;
		public var changedTimeInMilliSeconds:int;

// This is a AUTOMATICALLY GENERATED! Do not change!

		public static function create(key:*, value:*, storedByUserId:int, visibleToUserIds:Array/*int*/, changedTimeInMilliSeconds:int):ServerEntry {
			var res:ServerEntry = new ServerEntry();
			res.key = key;
			res.value = value;
			res.storedByUserId = storedByUserId;
			res.visibleToUserIds = visibleToUserIds;
			res.changedTimeInMilliSeconds = changedTimeInMilliSeconds;
			return res;
		}
		public static var FUNCTION_ID:int = -86;

// This is a AUTOMATICALLY GENERATED! Do not change!

		public static var METHOD_NAME:String = 'serverEntry';
		public static var METHOD_PARAMS:Array = ['key', 'value', 'storedByUserId', 'visibleToUserIds', 'changedTimeInMilliSeconds'];
	}
}
