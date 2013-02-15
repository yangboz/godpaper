/**
 *  GODPAPER Confidential,Copyright 2013. All rights reserved.
 *
 *  Permission is hereby granted, free of charge, to any person obtaining
 *  a copy of this software and associated documentation files (the "Software"),
 *  to deal in the Software without restriction, including without limitation
 *  the rights to use, copy, modify, merge, publish, distribute, sub-license,
 *  and/or sell copies of the Software, and to permit persons to whom the
 *  Software is furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included
 *  in all copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 *  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 *  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
 *  IN THE SOFTWARE.
 */
package com.godpaper.as3.plugins.playerIO
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.configs.GameConfig;
	import com.godpaper.as3.configs.IndicatorConfig;
	import com.godpaper.as3.configs.PieceConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.core.FlexGlobals;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.plugins.IPlug;
	import com.godpaper.as3.plugins.IPlugData;
	import com.godpaper.as3.utils.LogUtil;
	import com.gskinner.motion.easing.Sine;
	
	import flash.geom.Point;
	
	import mx.logging.ILogger;
	import mx.utils.UIDUtil;
	
	import org.osflash.signals.Signal;
	
	import playerio.Client;
	import playerio.Connection;
	import playerio.Message;
	import playerio.PlayerIO;
	import playerio.PlayerIOError;

	/**
	 * PlayerIoPlugin.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Jan 31, 2013 8:06:03 PM
	 * @see http://playerio.com/documentation/gettingstarted/flashcombopackage
	 * @see http://playerio.com/documentation/reference/actionscript3
	 */   	 
	public class PlayerIoPlugin implements IPlug
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var _model:PlayerIoModel;
		//
		private var _client:Client;
		//Singals for external handlers.
		public var signal_room_refreshed:Signal;
		public var signal_hoster_joined:Signal;
		public var signal_user_joined:Signal;
		public var signal_piece_placed:Signal;
		public var signal_game_tie:Signal;
		public var signal_game_reset:Signal;
		public var signal_player_win:Signal;
		//
		public var roomID:String;
		public var connection:Connection;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(PlayerIoPlugin);
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//-------------------------------------------------------------------------- 
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function PlayerIoPlugin(gameID:String="", boardID:String="")
		{
			_model = new PlayerIoModel();
			_model.gameID = gameID;
			_model.boardID = boardID;
			//
			this.signal_room_refreshed = new Signal(Array);
			this.signal_hoster_joined = new Signal(String);
			this.signal_user_joined = new Signal();
			this.signal_piece_placed = new Signal(Message,int,int,String,int);
			this.signal_game_tie = new Signal();
			this.signal_game_reset = new Signal();
			this.signal_player_win = new Signal(int,String);//winner index,winner name.
		}
		
		public function get data():IPlugData
		{
			return _model;
		}
		
		public function initialization():void
		{
			//User peerID initialization
			var peerID:String = FlexGlobals.userModel.hosterPeerId;//Default get hoster peerID.
			var username:String = FlexGlobals.userModel.hostRoleName;
			//
			PlayerIO.connect(
				FlexGlobals.topLevelApplication.stage,								//Referance to stage
				data.gameID,			//Game id (Get your own at playerio.com)
				"public",							//Connection id, default is public
				username,						//Username
				"",									//User auth. Can be left blank if authentication is disabled on connection
				null,								//Current PartnerPay partner.
				handleConnect,						//Function executed on successful connect
				handleError							//Function executed if we recive an error
			);   
		}
		
		public function showData():Boolean
		{
			//TODO: implement function
			return false;
		}
		
		public function showStore():Boolean
		{
			//TODO: implement function
			return false;
		}
		
		public function showLeaderboard(value:Object):Boolean
		{
			//TODO: implement function
			return false;
		}
		
		public function showLoginWidget():Boolean
		{
			//TODO: implement function
			return false;
		}
		
		public function saveData(value:Object):Boolean
		{
			//TODO: implement function
			return false;
		}
		
		public function submitData(value:Object):Boolean
		{
			//TODO: implement function
			return false;
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		//Default as hoster/player1,roleIndx=0,
		public function createRoom(name:String,peerID:String,roleIndex:int=0):void
		{
			this._client.multiplayer.createRoom(
				null,								//Room id, null for auto generted
				this._model.boardID,							//RoomType to create, bounce is a simple bounce server
				true,								//Hide room from userlist
				{name:name},						//Room Join data, data is returned to lobby list. Variabels can be modifed on the server
				joinRoom,						//Auto join room as hoster.	
				handleError					//Error handler	
			);
		}
		//
		public function createJoinRoom(name:String):void
		{
			this._client.multiplayer.createJoinRoom(
				null,								//Room id, null for auto generted
				this._model.boardID,							//RoomType to create, bounce is a simple bounce server
				true,								//Hide room from userlist
				{name:name},						//Room Join data, data is returned to lobby list. Variabels can be modifed on the server
				handleJoin,							//Create handler
				handleError					//Error handler	
			);
		}
		//
		public function refreshRoomList():void
		{
			this._client.multiplayer.listRooms(this._model.boardID, {}, 50, 0, function(rooms:Array):void{
				//Trace out returned rooms
//				for( var a:int=0;a<rooms.length;a++){
//					roomContainer.addChild(new RoomEntry(rooms[a], joinRoom))	
//				}
				//Just dispatch the table array signal.
				signal_room_refreshed.dispatch(rooms);
//				base.reset();
			}, function(e:PlayerIOError):void{
				LOG.error("Unable to list rooms {0}", e);
			})
		}
		//roomID,peerID,roleIndex
		public function joinRoom(id:String,peerID:String="",roleIndex:int=0):void
		{
			this._client.multiplayer.joinRoom(
				id,									//Room id
				{},									//User join data.
				handleJoin,							//Join handler
				handleError					//Error handler	
			)
			//Keep room id reference.
			this.roomID = id;
			//Register role name,//Default as hoster/player1
			FlexGlobals.userModel.hosterPeerId = peerID;//Default role is hoster.
			FlexGlobals.userModel.hosterRoleIndex = roleIndex;
			FlexGlobals.userModel.registerRole(peerID,roleIndex,FlexGlobals.userModel.ROLE_NAME_LIST[roleIndex]);
		}
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	
		private function handleConnect(client:Client):void{
			LOG.info("Sucessfully connected to player.io");
			
			//Set developmentsever (Comment out to connect to your server online)
//			client.multiplayer.developmentServer = "localhost:8184";
			this._client = client;//Keep client reference for the next step.
			//Create pr join the room test
//			client.multiplayer.createJoinRoom(
//				"test",								//Room id. If set to null a random roomid is used
//				"MyCode",							//The game type started on the server
//				true,								//Should the room be visible in the lobby?
//				{},									//Room data. This data is returned to lobby list. Variabels can be modifed on the server
//				{},									//User join data
//				handleJoin,							//Function executed on successful joining of the room
//				handleError							//Function executed if we got a join error
//			);
			//Broad cast signal
			signal_hoster_joined.dispatch(client.connectUserId);
		}
		
		
		private function handleJoin(connection:Connection):void{
			LOG.info("Sucessfully connected to the multiplayer server");
			//Keef ref.
			this.connection = connection;
			//Add disconnect listener
			connection.addDisconnectHandler(handleDisconnect);
			//Add listener for messages of the type "init"
			connection.addMessageHandler("init", userInitMessageHandler);
			//Add listener for messages of the type "hello"
			connection.addMessageHandler("hello", function(m:Message):void{
				LOG.info("Recived a message with the type hello from the server");			 
			})
			//Add message listener for users leaving the room
			connection.addMessageHandler("UserLeft", playerLeftMessageHandler);
			connection.addMessageHandler("left", playerLeftMessageHandler);
			//Listen to all messages using a private function
			connection.addMessageHandler("*", handleMessages);
			//Add message listener for users joining the room
			connection.addMessageHandler("UserJoined", playerJoinMessageHandler);
			connection.addMessageHandler("join", playerJoinMessageHandler);
			//Listen to and handle messages of the type "move"
			connection.addMessageHandler("place", chessPiecePlacedMessageHandler);
			//
			connection.addMessageHandler("spectator", sepctatorJoinMessageHandler);
			//
//			connection.addMessageHandler("full", function(m:Message):void{
////				infoBox.Show("full");
//			});
			//
			connection.addMessageHandler("reset",gameResetMesageHandler);
			//	
			connection.addMessageHandler("win", playerWinMessageHandler);
			//
			connection.addMessageHandler("tie", gameTieMesageHandler);	
		}
		//--------------------------------------------------------------------------
		//
		//  Private message handlers
		//
		//--------------------------------------------------------------------------
		//
		private function handleMessages(m:Message):void{
			LOG.info("Recived the message {0}", m);
		}
		//
		private function handleDisconnect():void{
			LOG.info("Disconnected from server");
		}
		//
		private function handleError(error:PlayerIOError):void{
//		private function handleError(error:*):void{	
			LOG.info("Connection error:{0}",String(error.message));
		}
		//
		private function userInitMessageHandler(m:Message, iAm:int, name:String):void
		{
			LOG.info("Connection init,I am {0}, name is {1}",iAm,name);		
			FlexGlobals.userModel.hosterRoleIndex = iAm;
			FlexGlobals.userModel.hostRoleName = name;
			//Game turn flag init.(0,1,2...)
			GameConfig.turnFlag = !iAm?DefaultConstants.FLAG_RED:DefaultConstants.FLAG_GREEN;
			//Broad cast signal
			signal_user_joined.dispatch();
		}
		//
		private function playerJoinMessageHandler(m:Message, p1name:String, p2name:String):void
		{
			LOG.info("Player joined in as {0} and {1}", p1name,p2name);
			//User list insert.
			FlexGlobals.userModel.addUser(p1name);
			FlexGlobals.userModel.addUser(p2name);
			//Broad cast signal
			signal_user_joined.dispatch();
		}
		//
		private function playerLeftMessageHandler(m:Message, p1name:String, p2name:String):void
		{
			LOG.info("Player with the userid {0},{1}", p1name,p2name, ",just left the room");
			//User list delete
			FlexGlobals.userModel.removeUser(p1name);
			FlexGlobals.userModel.removeUser(p2name);
		}
		//
		private function sepctatorJoinMessageHandler(m:Message, p1name:String, p2name:String):void
		{
			LOG.info("Sepctator: Pl: {0},P2: {1}", p1name,p2name);
			FlexGlobals.userModel.hosterRoleIndex = -1;//TODO:sepectator flow here.
		}
		//
		private function chessPiecePlacedMessageHandler(m:Message, x:int, y:int, state:String, turn:int):void
		{
			LOG.info("Player: State {0},Moved to {1},{2},Turn to {3}", state,x,y,turn);
			//Broadcasting signal
			if(signal_piece_placed.numListeners)
			{
				signal_piece_placed.dispatch(m,x,y,state,turn);
				return;//The following flow is esp for the game of "TicTacToe"
			}
			//place the piece comes from other player's action broadcasting.
			var conductVO:ConductVO = new ConductVO();
			conductVO.nextPosition = new Point(x,y);
			//
			if(FlexGlobals.userModel.hosterRoleIndex != turn)
				//				if(state=="circle")//"cross","circle"
			{
				if(turn==DefaultConstants.FLAG_RED)//Default flag RED,Notice: the flag already has turnned
				{
					conductVO.target = PieceConfig.redPiecesBox.chessPieces.pop();
				}else
				{
					conductVO.target = PieceConfig.bluePiecesBox.chessPieces.pop();
				}
				//Save stage to user model.
				FlexGlobals.userModel.state = state;
				FlexGlobals.userModel.moves.push(conductVO.brevity);
				//Make chess piece move.
				GameConfig.chessPieceManager.applyMove(conductVO);
				//The opponent player can move piece again.
				IndicatorConfig.waiting = false;
			}else
			{
				IndicatorConfig.waiting = true;//Waiting for the player can move piece again.
			}
		}
		//
		private function gameResetMesageHandler(m:Message):void
		{
			LOG.info("Game reset!");
			//Broadcasting signal
			if(signal_game_reset.numListeners)
			{
				signal_game_reset.dispatch();
				return;
			}
			//The following flow is esp for the game of "TicTacToe"
		}
		//
		private function gameTieMesageHandler(m:Message):void
		{
			LOG.info("Game tie!");
			//Broadcasting signal
			if(signal_game_tie.numListeners)
			{
				signal_game_tie.dispatch();
				return;
			}
			//The following flow is esp for the game of "TicTacToe"
		}
		//
		private function playerWinMessageHandler(m:Message, winner:int, winnerName:String):void
		{
			LOG.info("Winner is: {0},{1}", winner,winnerName);
			//
			if(FlexGlobals.userModel.hosterRoleIndex != winner)
			{
				//Broadcasting signal
				if(signal_player_win.numListeners)
				{
					signal_player_win.dispatch(winner,winnerName);
					return;
				}
			}
			//The following flow is esp for the game of "TicTacToe"
		}
	}
	
}