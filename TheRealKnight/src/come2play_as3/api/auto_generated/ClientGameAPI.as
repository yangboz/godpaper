package come2play_as3.api.auto_generated {
//Do not change the code below because this class was generated automatically!

	import flash.display.*;	import flash.utils.*;
	import come2play_as3.api.*;
	import come2play_as3.api.auto_copied.*;
	import come2play_as3.api.auto_generated.*;

	public  class ClientGameAPI extends BaseGameAPI {
		public function ClientGameAPI(someMovieClip:DisplayObjectContainer) {
			super(someMovieClip);
		}
		public function doRegisterOnServer():void { sendMessage( API_DoRegisterOnServer.create() ); }
		public function doTrace(name:String, message:Object):void { sendMessage( API_DoTrace.create(name, message) ); }

// This is a AUTOMATICALLY GENERATED! Do not change!

		
		public function gotKeyboardEvent(isKeyDown:Boolean, charCode:int, keyCode:int, keyLocation:int, altKey:Boolean, ctrlKey:Boolean, shiftKey:Boolean):void {}
		public function gotCustomInfo(infoEntries:Array/*InfoEntry*/):void {}
		public function gotUserInfo(userId:int, infoEntries:Array/*InfoEntry*/):void {}
		public function gotUserDisconnected(userId:int):void {}
		
		public function gotMatchStarted(allPlayerIds:Array/*int*/, finishedPlayerIds:Array/*int*/, serverEntries:Array/*ServerEntry*/):void {}
		public function gotMatchEnded(finishedPlayerIds:Array/*int*/):void {}
		public function gotStateChanged(serverEntries:Array/*ServerEntry*/):void {}
		

// This is a AUTOMATICALLY GENERATED! Do not change!

		public function doStoreState(userEntries:Array/*UserEntry*/, revealEntries:Array/*RevealEntry*//*<InAS3>*/ = null /*</InAS3>*/):void { sendMessage( API_DoStoreState.create(userEntries, revealEntries) ); }
		public function doAllStoreState(userEntries:Array/*UserEntry*/):void { sendMessage( API_DoAllStoreState.create(userEntries) ); }
		
		public function doAllEndMatch(finishedPlayers:Array/*PlayerMatchOver*/):void { sendMessage( API_DoAllEndMatch.create(finishedPlayers) ); }
		
		// if userId==-1, then nobody has the turn.
		// if milliSecondsInTurn==-1 then the default time per turn is used,
		// and if milliSecondsInTurn==0 then the user should do some actions immediately, i.e., without GUI intervention.
		// (The time given depends on the network delay).
		// doAllSetTurn automatically ends a move; a turn may have several moves.

// This is a AUTOMATICALLY GENERATED! Do not change!

		// The container may implement going back&forward or even rolling-back some moves/turns.
		public function doAllSetTurn(userId:int, milliSecondsInTurn:int/*<InAS3>*/ = -1 /*</InAS3>*/):void { sendMessage( API_DoAllSetTurn.create(userId, milliSecondsInTurn) ); }
		// Even realtime games may have moves (see, e.g., our multiplayer MineSweeper example)
		public function doAllSetMove():void { sendMessage( API_DoAllSetMove.create() ); }
		
		
		// if userId of RevealEntry is -1, then the entry becomes PUBLIC
		public function doAllRevealState(revealEntries:Array/*RevealEntry*/):void { sendMessage( API_DoAllRevealState.create(revealEntries) ); }
		
		public function doAllShuffleState(keys:Array/*Object*/):void { sendMessage( API_DoAllShuffleState.create(keys) ); }

// This is a AUTOMATICALLY GENERATED! Do not change!

		
		public function doAllRequestRandomState(key:Object, isSecret:Boolean/*<InAS3>*/ = false /*</InAS3>*/):void { sendMessage( API_DoAllRequestRandomState.create(key, isSecret) ); }
		
		// if userId=-1, then it is a bug of the game developer
		public function doAllFoundHacker(userId:int, errorDescription:String):void { sendMessage( API_DoAllFoundHacker.create(userId, errorDescription) ); }
		
		// doAllRequestStateCalculation is usually used to do a calculation
		// of an initial state that should be secret to all players.
		// (E.g., the initial board in multiplayer Sudoku or MineSweeper).
		// The server picks several random users (that we will call "calculators"),

// This is a AUTOMATICALLY GENERATED! Do not change!

		// and sends them gotRequestStateCalculation.
		// All these calculators must do the exact same call to doAllStoreStateCalculation,
		// i.e., the state calculation must be deterministic (you can use doAllRequestRandomState to create a hidden seed for the calculators).
		// serverEntries are all public (because the calculators should see state that is secret to the users)
		public function doAllRequestStateCalculation(keys:Array/*Object*/):void { sendMessage( API_DoAllRequestStateCalculation.create(keys) ); }
		public function gotRequestStateCalculation(requestId:int, serverEntries:Array/*ServerEntry*/):void {}
		public function doAllStoreStateCalculation(requestId:int, userEntries:Array/*UserEntry*/):void { sendMessage( API_DoAllStoreStateCalculation.create(requestId, userEntries) ); }
		
		
		

// This is a AUTOMATICALLY GENERATED! Do not change!

		
		public static const USER_INFO_KEY_name:String = "name";
		public static const USER_INFO_KEY_avatar_url:String = "avatar_url";
		public static const USER_INFO_KEY_supervisor:String = "supervisor";
		public static const USER_INFO_KEY_credibility:String = "credibility";
		public static const USER_INFO_KEY_game_rating:String = "game_rating";
		public static const USER_INFO_KEY_tokensBet:String = "tokensBet";
		public static const CUSTOM_INFO_KEY_canBet:String = "CONTAINER_canBet";
		public static const CUSTOM_INFO_KEY_logoFullUrl:String = "CONTAINER_logoFullUrl";
		public static const CUSTOM_INFO_KEY_secondsPerMatch:String = "CONTAINER_secondsPerMatch";

// This is a AUTOMATICALLY GENERATED! Do not change!

		public static const CUSTOM_INFO_KEY_secondsPerMove:String = "CONTAINER_secondsPerMove";
		public static const CUSTOM_INFO_KEY_gameHeight:String = "CONTAINER_gameHeight";
		public static const CUSTOM_INFO_KEY_gameWidth:String = "CONTAINER_gameWidth";
		public static const CUSTOM_INFO_KEY_gameFrameRate:String = "CONTAINER_gameFrameRate";
		public static const CUSTOM_INFO_KEY_myUserId:String = "CONTAINER_myUserId";
		public static const CUSTOM_INFO_KEY_isPause:String = "CONTAINER_isPause";
		public static const CUSTOM_INFO_KEY_isFocusInChat:String = "CONTAINER_isFocusInChat";
		public static const CUSTOM_INFO_KEY_i18n:String = "CONTAINER_i18n";
		public static const CUSTOM_INFO_KEY_reflection:String = "CONTAINER_reflection";
		public static const CUSTOM_INFO_KEY_checkThrowingAnError:String = "CONTAINER_checkThrowingAnError";

// This is a AUTOMATICALLY GENERATED! Do not change!

		public static const CUSTOM_INFO_KEY_isBack:String = "CONTAINER_isBack";
		public static const CUSTOM_INFO_KEY_isInReview:String = "CONTAINER_isInReview";
	}
}
