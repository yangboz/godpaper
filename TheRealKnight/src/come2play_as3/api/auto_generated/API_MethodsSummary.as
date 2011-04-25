package come2play_as3.api.auto_generated {
//Do not change the code below because this class was generated automatically!

	import flash.display.*;	import flash.utils.*;
	import come2play_as3.api.*;
	import come2play_as3.api.auto_copied.*;
	import come2play_as3.api.auto_generated.*;

	public  class API_MethodsSummary  {
		public var methodName:String;
		public var parameterNames:Array/*String*/;
		public var parameterTypes:Array/*String*/;
		public function API_MethodsSummary(methodName:String, parameterNames:Array/*String*/, parameterTypes:Array/*String*/) {
			this.methodName = methodName;

// This is a AUTOMATICALLY GENERATED! Do not change!

			this.parameterNames = parameterNames;
			this.parameterTypes = parameterTypes;
		}
		public static var SUMMARY_API:Array/*API_MethodsSummary*/ = [
		 new API_MethodsSummary('doRegisterOnServer', [], [] )
		, new API_MethodsSummary('doTrace', ['name', 'message'], ['String', 'Object'] )
		, new API_MethodsSummary('gotKeyboardEvent', ['isKeyDown', 'charCode', 'keyCode', 'keyLocation', 'altKey', 'ctrlKey', 'shiftKey'], ['Boolean', 'int', 'int', 'int', 'Boolean', 'Boolean', 'Boolean'] )
		, new API_MethodsSummary('gotCustomInfo', ['infoEntries'], ['Array/*InfoEntry*/'] )
		, new API_MethodsSummary('gotUserInfo', ['userId', 'infoEntries'], ['int', 'Array/*InfoEntry*/'] )
		, new API_MethodsSummary('gotUserDisconnected', ['userId'], ['int'] )

// This is a AUTOMATICALLY GENERATED! Do not change!

		, new API_MethodsSummary('gotMatchStarted', ['msgNum', 'allPlayerIds', 'finishedPlayerIds', 'serverEntries'], ['int', 'Array/*int*/', 'Array/*int*/', 'Array/*ServerEntry*/'] )
		, new API_MethodsSummary('gotMatchEnded', ['msgNum', 'finishedPlayerIds'], ['int', 'Array/*int*/'] )
		, new API_MethodsSummary('gotStateChanged', ['msgNum', 'serverEntries'], ['int', 'Array/*ServerEntry*/'] )
		, new API_MethodsSummary('doStoreState', ['userEntries', 'revealEntries'], ['Array/*UserEntry*/', 'Array/*RevealEntry*/'] )
		, new API_MethodsSummary('doAllStoreState', ['userEntries'], ['Array/*UserEntry*/'] )
		, new API_MethodsSummary('doAllEndMatch', ['finishedPlayers'], ['Array/*PlayerMatchOver*/'] )
		, new API_MethodsSummary('doAllSetTurn', ['userId', 'milliSecondsInTurn'], ['int', 'int'] )
		, new API_MethodsSummary('doAllSetMove', [], [] )
		, new API_MethodsSummary('doAllRevealState', ['revealEntries'], ['Array/*RevealEntry*/'] )
		, new API_MethodsSummary('doAllShuffleState', ['keys'], ['Array/*Object*/'] )

// This is a AUTOMATICALLY GENERATED! Do not change!

		, new API_MethodsSummary('doAllRequestRandomState', ['key', 'isSecret'], ['Object', 'Boolean'] )
		, new API_MethodsSummary('doAllFoundHacker', ['userId', 'errorDescription'], ['int', 'String'] )
		, new API_MethodsSummary('doAllRequestStateCalculation', ['keys'], ['Array/*Object*/'] )
		, new API_MethodsSummary('gotRequestStateCalculation', ['requestId', 'serverEntries'], ['int', 'Array/*ServerEntry*/'] )
		, new API_MethodsSummary('doAllStoreStateCalculation', ['requestId', 'userEntries'], ['int', 'Array/*UserEntry*/'] )
		];
	}
}
