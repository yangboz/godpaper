package come2play_as3.api
{
	import come2play_as3.api.auto_copied.*;
	import come2play_as3.api.auto_generated.*;
	
	import flash.display.*;
	import flash.utils.*;
	
	/**
	 * This class simulates a server that works only for a single player.
	 * It opens a localconnection and waits for the player to connect,
	 * following the standard handshake:
	 * Player calls doRegisterOnServer,
	 * and then the server will call:
	 * gotCustomInfo
	 * gotUserInfo
	 * gotMatchStarted
	 * 
	 * When NUM_OF_PLAYERS=1, there is a single player,
	 * which is suitable for real-time games (like MineSweeper).
	 * In turn-based games (like Monopoly), you can simulate several players.
	 * The emulator will start with the first player,
	 * and whenever it receives a call doAllSetTurn(X),
	 * then it will end the match, change CUSTOM_INFO_KEY_myUserId to X,
	 * and load the match.
	 * 
	 * When the server gets doAllEndMatch,
	 * it will wait 2 seconds before starting a new match.
	 */
	public final class SinglePlayerEmulator extends LocalConnectionUser
	{
		public static var SHOW_TURN_MSGS:Boolean = false;
		public static var SHOW_GAME_OVER_MSGS:Boolean = true;
		public static var START_NEW_GAME_AFTER_MILLISECONDS:int = 5000;
		public static var NUM_OF_PLAYERS:int = 1;
		public static var DEFAULT_USER_IDS:Array/*int*/ = [42,43,44,45];
		private static function getFirstPlayerId():int {
			return DEFAULT_USER_IDS[0];
		}
		private static function getPlayerIds():Array/*int*/ {
			var res:Array/*int*/ = [];
			for (var i:int=0; i<NUM_OF_PLAYERS; i++)
				res.push(DEFAULT_USER_IDS[i]);
			return res;			
		}
		public static var DEFAULT_FINISHED_USER_IDS:Array/*int*/ = []; // if you want to simulate loading a match where some users already finished playing
		public static var DEFAULT_CUSTOM_INFO:Array/*InfoEntry*/ =
			[   
				InfoEntry.create(API_Message.CUSTOM_INFO_KEY_logoFullUrl,"../../Emulator/example_logo.jpg"), 
				InfoEntry.create(API_Message.CUSTOM_INFO_KEY_gameHeight,400), 
				InfoEntry.create(API_Message.CUSTOM_INFO_KEY_gameWidth,400),
				InfoEntry.create("checkThrowingAnError",false) // testing the red error window
			];
		public static var OVERRIDING_CUSTOM_INFO:Array/*InfoEntry*/ = []; // set by reflection, do not set it in the code!
		public static var DEFAULT_USERS_INFO:Array/*InfoEntry[]*/ =
			[
				[ 	InfoEntry.create(API_Message.USER_INFO_KEY_name, "Player A"),
					InfoEntry.create(API_Message.USER_INFO_KEY_avatar_url, "../../Emulator/Avatar_1.gif")
				],
				[ 	InfoEntry.create(API_Message.USER_INFO_KEY_name, "Player B"),
					InfoEntry.create(API_Message.USER_INFO_KEY_avatar_url, "../../Emulator/Avatar_2.gif")
				],
				[ 	InfoEntry.create(API_Message.USER_INFO_KEY_name, "Player C"),
					InfoEntry.create(API_Message.USER_INFO_KEY_avatar_url, "../../Emulator/Avatar_3.gif")
				],
				[ 	InfoEntry.create(API_Message.USER_INFO_KEY_name, "Player D"),
					InfoEntry.create(API_Message.USER_INFO_KEY_avatar_url, "../../Emulator/Avatar_4.gif")
				]
			];
		public static var DEFAULT_MATCH_STATE:Array/*ServerEntry*/ = []; // you can change this and load a saved match
		
		
		public static var WAIT_BETWEEN_EXTRA_CALLBACKS:int = 0;
		public static var EXTRA_CALLBACKS:Array/*API_Message*/ = [];
		private static var LOG:Logger = new Logger("SinglePlayerEmulator",10);
												 
		private var messageNum:int = 10000;
		private var curUserId:int; // the current userId (we change this curUserId when getting doAllSetTurn)
		private var finishedUserIds:Array/*int*/;
		private var apiMsgsQueue:Array/*API_Message*/ = [];
		private var serverStateMiror:ObjectDictionary;
		public function SinglePlayerEmulator(graphics:DisplayObjectContainer) {
			super(graphics,true, DEFAULT_LOCALCONNECTION_PREFIX,true);
			LOG.log("Created!!!");			
		}
		private function updateUserIds(userIdsToUpdate:Array/*int*/,userIdsToAdd:Array/*int*/):Boolean{
			var updated:Boolean = false;
			for each(var id:int in userIdsToAdd){
				if(AS3_vs_AS2.IndexOf(userIdsToUpdate,id)==-1){
					updated = true;
					userIdsToUpdate.push(id);
				}
			}
			return updated;
		}	
		private function doRevealEntry(revealEntry:RevealEntry):ServerEntry{
			var oldServerEntry:ServerEntry =/*as*/ serverStateMiror.getValue(revealEntry.key) as ServerEntry
			if (oldServerEntry == null) return null;
			var serverEntry:ServerEntry =ServerEntry.create(oldServerEntry.key,oldServerEntry.value,oldServerEntry.storedByUserId,oldServerEntry.visibleToUserIds,getTimer());
			if (serverEntry == null)return null;
			if (serverEntry.visibleToUserIds == null) return null;
			if (revealEntry.userIds == null) {
				serverEntry.visibleToUserIds = null;	
			}else if (!updateUserIds(serverEntry.visibleToUserIds,revealEntry.userIds)) return null;
			serverStateMiror.addEntry(serverEntry);	
			return serverEntry
		}
		private function doRevealPointer(revealEntry:RevealEntry):Object{
			var serverEntry:ServerEntry = doRevealEntry(revealEntry)
			if(serverEntry == null){
				serverEntry = /*as*/ serverStateMiror.getValue(revealEntry.key) as ServerEntry;
				if(serverEntry == null){
					return null;
				}else{
					return serverEntry.value
				}
			}else{
				return serverEntry;
			}
		}	
		private function doRevealEntries(revealEntries:Array/*RevealEntry*/):Array/*ServerEntries*/{
			var serverEntries:Array/*ServerEntry*/ = new Array();
			var serverEntry:ServerEntry;
			var pointerObject:Object;
			for each (var revealEntry:RevealEntry in revealEntries) {
				if (revealEntry.depth == 0) {
					serverEntry = doRevealEntry(revealEntry);
					if (serverEntry!=null)	serverEntries.push(serverEntry);
				}else if (revealEntry.depth > 0) {
					for(var i:int =0;i<=revealEntry.depth;i++){	
						pointerObject = doRevealPointer(revealEntry);
						if(pointerObject == null){
							//break;
						}else if(pointerObject is ServerEntry){
							serverEntry = /*as*/pointerObject as ServerEntry;
							serverEntries.push(serverEntry);
							revealEntry.key = serverEntry.value;	
						}else{
							revealEntry.key = pointerObject;
						}				
					}
				}
			}
			return serverEntries;
		}
		private function shuffleEntries(keys:Array/*Object*/,serverEntries:Array/*SErverEntry*/):Array/*ServerEntry*/{
			var randIndex:int;
			var newServerEntries:Array = new Array();
			var serverEntry:ServerEntry;
			var currentKey:Object;
			while(serverEntries.length > 0){
				randIndex =Math.random()*serverEntries.length;
				serverEntry = serverEntries[randIndex]
				serverEntries.splice(randIndex,1);
				currentKey = keys.pop()
				newServerEntries.unshift(ServerEntry.create(currentKey,null,-1,[],getTimer()));
				serverStateMiror.addEntry(ServerEntry.create(currentKey,serverEntry.value,-1,[],getTimer()));
			}
			return newServerEntries;
		}
		/*storePrefrence
		 * 1 - normal do store
		 * 2 - doAllStore
		 * 3 - calculator store
		 */
		private function extractStoredData(userEntries:Array/*UserEntry*/,storePrefrence:int):Array/*ServerEntries*/{
			var serverEntries:Array/*ServerEntry*/ = [];
			var serverEntry:ServerEntry;
			for each (var userEntry:UserEntry in userEntries) {
				switch(storePrefrence){
					case 1:serverEntry = ServerEntry.create(userEntry.key, userEntry.value,curUserId,userEntry.isSecret ? [curUserId] : null, getTimer()); break;
					case 2:serverEntry = ServerEntry.create(userEntry.key, userEntry.value,-1,userEntry.isSecret ? [] : null, getTimer()); break;
					case 3:serverEntry = ServerEntry.create(userEntry.key, userEntry.value,-1,userEntry.isSecret ? [] : null, getTimer()); break;
				}
				
				serverStateMiror.addEntry(serverEntry);
				
				if((userEntry.isSecret) && (storePrefrence!=1)){
					var secretServerEntry:ServerEntry = ServerEntry.create(serverEntry.key,null,serverEntry.storedByUserId,serverEntry.visibleToUserIds,serverEntry.changedTimeInMilliSeconds);
					serverEntries.push(secretServerEntry); 
				}else{
					serverEntries.push(serverEntry); 
				}
				
			}	
			return serverEntries;
		}
		private function combineServerEntries(serverEntries:Array/*ServerEntry*/):Array/*ServerEntry*/{
			var combinedServerEntries:Array/*ServerEntry*/ = new Array();	
			var dicArray:Array = new Array();
			for(var i:int = (serverEntries.length -1);i>=0;i--)
			{
				var serverEntry:ServerEntry = serverEntries[i];
				if(dicArray[JSON.stringify(serverEntry.key)] == null)
				{
					dicArray[JSON.stringify(serverEntry.key)] = true;
					combinedServerEntries.unshift(serverEntry);
				}
			}
			
			return combinedServerEntries
		}
		
		private function messageHandler(msg:API_Message,transactionEntries:Array/*<InAS3>*/ = null/*</InAS3>*/):Array{
		var serverEntries:Array/*ServerEntry*/ = [];
			var serverEntry:ServerEntry;
			if (msg is API_Transaction) {
				var transaction:API_Transaction = /*as*/msg as API_Transaction;
				var tempServerEntries:Array;
				for each (var innerMsg:API_Message in transaction.messages) {
					tempServerEntries = messageHandler(innerMsg,serverEntries);
					if(tempServerEntries.length>0)
					serverEntries = serverEntries.concat(tempServerEntries);
				}
				if(serverEntries.length > 0)
					queueSendMessage(API_GotStateChanged.create(++messageNum,combineServerEntries(serverEntries)))
				gotMessage(transaction.callback);
			}else if(msg is API_DoTrace){ 
				var doTrace:API_DoTrace = /*as*/msg as API_DoTrace;	
				trace(doTrace.name+" : "+doTrace.message);
			}else if (msg is API_DoStoreState) {
				var doStore:API_DoStoreState = /*as*/msg as API_DoStoreState;				
				serverEntries = extractStoredData(doStore.userEntries,1);
				if(doStore.revealEntries !=null)
					serverEntries = serverEntries.concat(doRevealEntries(doStore.revealEntries))
				if(transactionEntries == null)
					queueSendMessage(API_GotStateChanged.create(++messageNum,serverEntries));
				else
					return serverEntries;
				
			}else if (msg is API_DoAllStoreState) { 
				var doAllStoreMsg:API_DoAllStoreState = /*as*/msg as API_DoAllStoreState;
				serverEntries = extractStoredData(doAllStoreMsg.userEntries,2)
				if(transactionEntries == null)
					queueSendMessage(API_GotStateChanged.create(++messageNum,serverEntries));
				else
					return serverEntries;
        	}else if(msg is API_DoAllStoreStateCalculation){
        		var stateCalculations:API_DoAllStoreStateCalculation = /*as*/msg as API_DoAllStoreStateCalculation;
        		serverEntries = extractStoredData(stateCalculations.userEntries,3)
				queueSendMessage(API_GotStateChanged.create(++messageNum,serverEntries))
        	}else if (msg is API_DoAllShuffleState){
        		var shuffleState:API_DoAllShuffleState = /*as*/msg as API_DoAllShuffleState;
        		var Key:Object;
        		for(var i:int =0;i<shuffleState.keys.length;i++){
        			Key = shuffleState.keys[i];
        			serverEntry = /*as*/serverStateMiror.getValue(Key) as ServerEntry
        			if(serverEntry != null)
        				serverEntries.push(serverEntry);
        			else{
        				shuffleState.keys.splice(i,1);
        				i--;
        			}
        		}
        		serverEntries = shuffleEntries(shuffleState.keys,serverEntries);
        		if(transactionEntries == null)
					queueSendMessage(API_GotStateChanged.create(++messageNum,serverEntries));
				else
					return serverEntries;
        	}else if (msg is API_DoAllRevealState){
        		var revealStateMsg:API_DoAllRevealState = /*as*/msg as API_DoAllRevealState;
				serverEntries = doRevealEntries(revealStateMsg.revealEntries)
				if(transactionEntries == null)
					queueSendMessage(API_GotStateChanged.create(++messageNum,serverEntries));
				else
					return serverEntries;
        	}else if (msg is API_DoAllRequestRandomState) { 
        		var doAllSecretStateMsg:API_DoAllRequestRandomState = /*as*/msg as API_DoAllRequestRandomState;
				var randomINT:int = Math.random()*int.MAX_VALUE;
				serverEntry = ServerEntry.create(doAllSecretStateMsg.key,randomINT,-1,doAllSecretStateMsg.isSecret?[]:null,getTimer())
				serverStateMiror.addEntry(serverEntry);
				if(transactionEntries == null)
					queueSendMessage(API_GotStateChanged.create(++messageNum,[serverEntry]));
				else
					return [serverEntry];
        	}else if (msg is API_DoAllEndMatch) {
				var endMatch:API_DoAllEndMatch = /*as*/msg as API_DoAllEndMatch;
				var newlyFinishedUserIds:Array = [];
				var t:T = new T();
				t.add( T.i18n("Game is over for:\n") );
				for each (var matchOver:PlayerMatchOver in endMatch.finishedPlayers) {
					var playerId:int = matchOver.playerId;
					newlyFinishedUserIds.push( playerId );
					finishedUserIds.push( playerId );
					t.add( T.i18nReplace("$name$ score is $score$, and he will win $percent$ percent of the gambling pot.\n", {name: getUserName(playerId), score: matchOver.score, percent: matchOver.potPercentage }) );
				}				 
				queueSendMessage( API_GotMatchEnded.create(++messageNum,newlyFinishedUserIds) );
				if (finishedUserIds.length==NUM_OF_PLAYERS) {
					t.add( T.i18n("A new game will start in 5 seconds . . .\n") );
					// game is completely over for all players
					ErrorHandler.myTimeout("SinglePlayerEmulator.sendNewMatch",AS3_vs_AS2.delegate(this, this.sendNewMatch), START_NEW_GAME_AFTER_MILLISECONDS);
				}
				if (SHOW_GAME_OVER_MSGS) AS3_vs_AS2.showMessage(t.join(),"gameOver");
			} else if (msg is API_DoRegisterOnServer) {
				doRegisterOnServer();
			} else if (msg is API_DoAllRequestStateCalculation) { 
				var requestStateCalculationMsg:API_DoAllRequestStateCalculation = /*as*/msg as API_DoAllRequestStateCalculation;
				for each (var key:Object in requestStateCalculationMsg.keys){
					var entry:ServerEntry = /*as*/serverStateMiror.getValue(key) as ServerEntry;
					if(entry!= null)
						serverEntries.push(entry)
				}
				queueSendMessage(API_GotRequestStateCalculation.create(1,serverEntries))
        	} else if (msg is API_DoAllSetTurn) {
        		var setTurn:API_DoAllSetTurn = /*as*/msg as API_DoAllSetTurn;
        		if (setTurn.userId!=curUserId) {
        			// we switch users by ending and loading the match
        			var userId:int = setTurn.userId;
        			LOG.log("Switch turns:",curUserId," ---> ",userId);
					if (SHOW_TURN_MSGS) AS3_vs_AS2.showMessage( T.i18nReplace("The turn of $name$ is starting.\n", {name: getUserName(userId)}) , "newTurn");
					
        			var ongoingIds:Array/*int*/ = StaticFunctions.subtractArray(getPlayerIds(),finishedUserIds);
					queueSendMessage( API_GotMatchEnded.create(++messageNum,ongoingIds) );
					setCurUserId(userId);
					queueSendMessage( API_GotMatchStarted.create(++messageNum,getPlayerIds(), finishedUserIds, serverStateMiror.getValues() ) );
        		}
        		
			}else if(msg is API_DoAllFoundHacker){
				var foundHacker:API_DoAllFoundHacker = /*as*/msg as API_DoAllFoundHacker;
				AS3_vs_AS2.showMessage("\n User "+foundHacker.userId+" called \n"+foundHacker.errorDescription,"Found Hacker");
			}else if (msg is API_DoFinishedCallback) {
				if (apiMsgsQueue.length==0) throwError("Game sent too many DoFinishedCallback");
				apiMsgsQueue.shift();
				if (apiMsgsQueue.length>0) sendTopQueue();
			}	
			return [];	
		}
		
		private function setCurUserId(id:int):void {
			curUserId = id;
			queueSendMessage(API_GotCustomInfo.create([ InfoEntry.create(API_Message.CUSTOM_INFO_KEY_myUserId,curUserId) ]));
		}
		private function getUserName(id:int):String {
			return T.getUserValue(id,API_Message.USER_INFO_KEY_name,"Player "+id).toString();
		}
        override public function gotMessage(msg:API_Message):void {        	
			messageHandler(msg);			
  		}
  		private function doRegisterOnServer():void {
  			queueSendMessage(API_GotCustomInfo.create(DEFAULT_CUSTOM_INFO.concat(OVERRIDING_CUSTOM_INFO)) );
  			
  			if (DEFAULT_USERS_INFO.length>0) {
	  			var pos:int = 0;
	  			for each (var curUserId:int in getPlayerIds()) {
	  				queueSendMessage(API_GotUserInfo.create(curUserId, pos<DEFAULT_USERS_INFO.length ? DEFAULT_USERS_INFO[pos++] : DEFAULT_USERS_INFO[pos-1]) );
				}
	  		}
	  		sendNewMatch();
	  	}	  	
	  	private function sendNewMatch():void {
	  		setCurUserId( getFirstPlayerId() );
	  		
  			serverStateMiror = new ObjectDictionary();	
  			for each(var serverEntry:ServerEntry in DEFAULT_MATCH_STATE) {
  				serverStateMiror.addEntry(serverEntry);
			}
			finishedUserIds = DEFAULT_FINISHED_USER_IDS.concat(); // to create a copy
  			queueSendMessage(API_GotMatchStarted.create(++messageNum,getPlayerIds(), finishedUserIds, serverStateMiror.getValues() ) );
  			if (WAIT_BETWEEN_EXTRA_CALLBACKS==0) {
	  			for each (var extraCallback:API_Message in EXTRA_CALLBACKS) {
	  				LOG.log("Passing extraCallback=",extraCallback);
	  				queueSendMessage( extraCallback );
	  			}
	  		} else  				
  				checkExtraCallbacks();	 	
  		}
  		private function checkExtraCallbacks():void {
  			if (EXTRA_CALLBACKS.length==0) return;
  			ErrorHandler.myTimeout("SinglePlayerEmulator.sendExtraCallback", AS3_vs_AS2.delegate(this, this.sendExtraCallback), WAIT_BETWEEN_EXTRA_CALLBACKS);
  		}
  		private function sendExtraCallback():void {
  			var extraCallback:API_Message = /*as*/EXTRA_CALLBACKS.shift() as API_Message;
  			StaticFunctions.assert(extraCallback!=null,"Error in sendExtraCallback! EXTRA_CALLBACKS=",[EXTRA_CALLBACKS]);
  			queueSendMessage( extraCallback );
  			checkExtraCallbacks();  			
  		}
  		private function queueSendMessage(msg:API_Message):void {
  			apiMsgsQueue.push(msg);
  			if (apiMsgsQueue.length==1) sendTopQueue();
  		}
  		
  		private function sendTopQueue():void {  			
  			var msg:API_Message = apiMsgsQueue[0];
  			sendMessage(msg);
  		}
  		
  		
	}
}