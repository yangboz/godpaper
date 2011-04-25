package come2play_as3.api
{
	import come2play_as3.api.auto_copied.AS3_vs_AS2;
	import come2play_as3.api.auto_copied.ErrorHandler;
	import come2play_as3.api.auto_copied.Logger;
	import come2play_as3.api.auto_copied.StaticFunctions;
	import come2play_as3.api.auto_copied.T;
	import come2play_as3.api.auto_generated.API_DoStoreState;
	import come2play_as3.api.auto_generated.API_Message;
	import come2play_as3.api.auto_generated.ServerEntry;
	import come2play_as3.api.auto_generated.UserEntry;
	
	import flash.events.*;
	import flash.net.*;
	import flash.system.Capabilities;
	import flash.system.System;
	
	public final class RtmfpConnection 
	{
		// stratus address, hosted by Adobe
		public static var connectUrl:String = "rtmfp://stratus.adobe.com";
		// Come2Play's developer key
		public static var DeveloperKey:String = "34e104209abff35489368cee-9de59a1f6064";
		private static var LOG:Logger = new Logger("RTMFP",20);
		private static var LOG_Broadcasts:Logger = new Logger("RTMFP-Broadcasts",20);
		public static var SINGLETON:RtmfpConnection = null;
			
		// this is the connection to stratus
		private var netConnection:NetConnection;
		private var listenerStream:NetStream;
		private var playStreams:Object/*userId -> NetStream*/ = {};
		private var waitingToPlay:Array/*ServerEntry*/ = [];
		private var game:BaseGameAPI;
		private var isConnected:Boolean = false;
		private var isInProgress:Boolean = false;
		
		public function RtmfpConnection(game:BaseGameAPI) {
			this.game = game;
			LOG.log("Created RtmfpConnection! vmVersion=",System.vmVersion, " flashVersion=",Capabilities.version, " initialMemory=",System.totalMemory);
			StaticFunctions.assert(SINGLETON==null,"Created RtmfpConnection twice!");
			SINGLETON = this;
			
			netConnection = new NetConnection();
			var events:Array = [NetStatusEvent.NET_STATUS,SecurityErrorEvent.SECURITY_ERROR,
				IOErrorEvent.IO_ERROR,AsyncErrorEvent.ASYNC_ERROR];
			for each (var event:String in events)
				AS3_vs_AS2.myAddEventListener("RTMFP",
					netConnection,event, netConnectionHandler);
			netConnection.connect(connectUrl + "/" + DeveloperKey);				
		}
		public static var CONN_NAME:String = "control";
		public static var PREFIX:String = "nearID for ";
		private function myId():int { 
			return (T.custom(API_Message.CUSTOM_INFO_KEY_myUserId, null) as int);
		}
		private function storeNearId():void {
			game.sendMessage(API_DoStoreState.create([UserEntry.create(PREFIX+myId(), netConnection["nearID"])]));
		}
		public function gotMatchStarted():void {
			//StaticFunctions.assert(isConnected, "The game cannot start before RtmfpConnection is ready!");
			isInProgress = true;
			if (isConnected) {
				ErrorHandler.myTimeout("RTMFP",storeNearId,100); // I can't send doStore from inside gotMatchStarted 
			}			
		}
		private function playTarget(entry:ServerEntry):void {
			var target:String = entry.value as String;
			var userId:int = entry.storedByUserId;
			if (playStreams[userId]!=null) return;
			var ctor:Class = NetStream;
			var sender:NetStream = new ctor(netConnection, target);
			var client:Object = new Object();
			client.gotBroadcast = ErrorHandler.wrapWithCatch("RTMFP",gotBroadcast);
			sender.client = client;
			var events:Array = [AsyncErrorEvent.ASYNC_ERROR,IOErrorEvent.IO_ERROR,NetStatusEvent.NET_STATUS];
			for each (var event:String in events)
				AS3_vs_AS2.myAddEventListener("RTMFP",
					sender,event,listenerHandler);
			sender.receiveAudio(false);
			sender.receiveVideo(false);						
			sender.play(CONN_NAME + target);
			playStreams[userId] = sender;
		}
		
		public function gotStateChanged(serverEntries:Array/*ServerEntry*/):Boolean {
			if (serverEntries.length!=1) return false;
			var entry:ServerEntry = serverEntries[0];
			if (!StaticFunctions.startsWith(entry.key,PREFIX)) return false;
			
			if (entry.storedByUserId!=myId()) {
				if (!isConnected)
					waitingToPlay.push(entry);
				else
					playTarget(entry); 
			}
			return true;
		}
		public function gotMatchEnded():void {
			isInProgress = false;
			//for each (var sender:NetStream in playStreams) sender.close();
		}
		public function gotBroadcast(fromUserId:int, msg:Object):void {
			LOG_Broadcasts.log("Got broadcast fromUserId=",fromUserId," msg=",msg);
			game.gotDirectBroadcast(fromUserId,msg);		
		}
		public function broadcast(msg:Object):void {
			LOG_Broadcasts.log("Send broadcast: ",msg);
			if (isConnected) // if I'm not yet connected then this msg will be lost! 
				listenerStream.send("gotBroadcast",myId(),msg);
		}
		private function netConnectionHandler(event:Event):void {
			LOG.log("RtmfpConnection event: ",event);
			if (isConnected) return; // I get more events, e.g., NetStream.Connect.Success
			StaticFunctions.assert(event is NetStatusEvent && (event as NetStatusEvent).info.code=="NetConnection.Connect.Success","Connection with RTMFP failed!");
			LOG.log("nearID=",netConnection["nearID"]); // can now use netConnection.nearID
			
			var ctor:Class = NetStream;
			listenerStream = new ctor(netConnection, "directConnections"); //NetStream.DIRECT_CONNECTIONS
			listenerStream.client = { gotBroadcast : function (fromUserId:int, msg:Object):void {
				LOG_Broadcasts.log("Should not be called on myself! myId=",myId(),"fromUserId=",fromUserId);
			} };
			AS3_vs_AS2.myAddEventListener("RTMFP",
				listenerStream,NetStatusEvent.NET_STATUS, listenerHandler);
			listenerStream.publish(CONN_NAME + netConnection["nearID"]);
			
			isConnected = true;
			if (isInProgress) // game is in progress
				storeNearId();
			for each (var entry:ServerEntry in waitingToPlay) {
				playTarget(entry);
			}
			waitingToPlay = null;
		}
		private function listenerHandler(event:Event):void {
			LOG.log("Listener event: ", event);
		}
	}
}