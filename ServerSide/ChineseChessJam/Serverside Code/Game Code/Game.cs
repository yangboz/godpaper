using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;
using PlayerIO.GameLibrary;
using System.Drawing;

namespace ChineseChessJam {
	//Player class. each player that join the game will have these attributes.
	public class Player : BasePlayer {
		public Boolean IsReady = true;
	}

    [RoomType("ChineseChessJam")]
	public class GameCode : Game<Player> {
		private Player player1;
		private Player player2;
		private Player hasTurn;
		
		// This method is called when an instance of your the game is created
		public override void GameStarted() {
			// anything you write to the Console will show up in the 
			// output window of the development server
			Console.WriteLine("Game is started");
		}

		// This method is called when the last player leaves the room, and it's closed down.
		public override void GameClosed() {
			Console.WriteLine("RoomId: " + RoomId);
		}

		// This method is called whenever a player joins the game
		public override void UserJoined(Player player) {

			joinGame(player);


			//Send info about all already connected users to the newly joined users chat
			Message m = Message.Create("ChatInit");
			m.Add(player.Id);

			foreach(Player p in Players) {
				m.Add(p.Id, p.ConnectUserId);
			}

			player.Send(m);

			//Informs other users chats that a new user just joined.
			Broadcast("ChatJoin", player.Id, player.ConnectUserId);

		}

		// This method is called when a player leaves the game
		public override void UserLeft(Player player) {
			//Tell the chat that the player left.
			Broadcast("ChatLeft", player.Id);
			
		//	Console.WriteLine("User left the chat " + player.Id);
			
			if(player == player1) {
				player1 = null;
			} else if(player == player2) {
				player2 = null;
			} else
				return;

			Broadcast("left", player1 != null ? player1.ConnectUserId : "", player2 != null ? player2.ConnectUserId : "");

		}

		// This method is called when a player sends a message into the server code
		public override void GotMessage(Player player, Message message) {
			switch(message.Type) {
				case "move": {
						int start = message.GetInt(1);
						int end = message.GetInt(2);
                        String type = message.GetString(0);
                        hasTurn = hasTurn == player1 ? player2 : player1;
                        Broadcast("place", start, end, type, player1 == hasTurn ? 0 : 1);
						break;
					}
				case "reset": {
						if(player1 != null && player2 != null) {
							player.IsReady = true;
							if(player1.IsReady && player2.IsReady) {
								resetGame(null);
							}
						}
						break;
					}
				case "join": {
						joinGame(player);
						break;
					}

				case "ChatMessage": {
						Broadcast("ChatMessage", player.Id, message.GetString(0));
						break;
					}
			}
		}

		private void joinGame(Player user) {
			if(player1 == null) {
				user.Send("init", 0, user.ConnectUserId);
				player1 = user;
				hasTurn = user;
			} else if(player2 == null) {
				user.Send("init", 1, user.ConnectUserId);
				player2 = user;
				hasTurn = user;
			} else {
				//Send current game state to spectators
				user.Send("spectator", player1.ConnectUserId, player2.ConnectUserId,null);
				return;
			}
			if(player1 != null && player2 != null) {
				Broadcast("join", player1.ConnectUserId, player2.ConnectUserId);
				user.Send("join", player1.ConnectUserId, player2.ConnectUserId);
				resetGame(user);
			}
		}

		private void resetGame(Player user) {

			player1.IsReady = false;
			player2.IsReady = false;
			if(user != null)
				user.Send("reset", player1 == hasTurn ? 0 : 1);
			Broadcast("reset", player1 == hasTurn ? 0 : 1);
		}
	}
}