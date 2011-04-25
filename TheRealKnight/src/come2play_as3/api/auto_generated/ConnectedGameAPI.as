package come2play_as3.api.auto_generated {
//Do not change the code below because this class was generated automatically!

	import flash.display.*;	import flash.utils.*;
	import come2play_as3.api.*;
	import come2play_as3.api.auto_copied.*;
	import come2play_as3.api.auto_generated.*;

	public  class ConnectedGameAPI extends BaseGameAPI {
		public function ConnectedGameAPI(someMovieClip:DisplayObjectContainer) {
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
		
		public function doStoreState(userEntries:Array/*UserEntry*/, revealEntries:Array/*RevealEntry*//*<InAS3>*/ = null /*</InAS3>*/):void { sendMessage( API_DoStoreState.create(userEntries, revealEntries) ); }
		public function gotStateChanged(serverEntries:Array/*ServerEntry*/):void {}

// This is a AUTOMATICALLY GENERATED! Do not change!

		
		public function doConnectedSetScore(score:int):void { sendMessage( API_DoConnectedSetScore.create(score) ); }
		public function doConnectedEndMatch(didWin:Boolean):void { sendMessage( API_DoConnectedEndMatch.create(didWin) ); }
		
		
		
		
		
	}
}
