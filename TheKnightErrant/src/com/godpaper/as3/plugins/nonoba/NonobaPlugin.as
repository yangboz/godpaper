/**
 *  GODPAPER Confidential,Copyright 2012. All rights reserved.
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
package com.godpaper.as3.plugins.nonoba
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.model.FlexGlobals;
	import com.godpaper.as3.plugins.IPlug;
	import com.godpaper.as3.plugins.IPlugData;
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	
	import Nonoba.api.Connection;
	import Nonoba.api.ConnectionEvent;
	import Nonoba.api.MessageEvent;
	import Nonoba.api.NonobaAPI;
	
	/**
	 * NonobaPlugin.as class.
	 * @see:http://www.nonoba.com/developers/documentation/actionscript3
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Apr 25, 2011 3:32:13 PM
	 */
	public class NonobaPlugin implements IPlug
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var _model:NonobaModel;
		
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		
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
		public function NonobaPlugin(gameID:String="", boardID:String="")
		{
			//Note that it does not matter if you define the objects as a var, 
			//a const or an implicit getter function. The objects these properties hold will all 
			//be added to the IOC container.
			//Of course intialization is again just a one liner:
			_model=new NonobaModel();
			//
			_model.gameID=gameID; //47de4a85dd3e213a
			_model.boardID=boardID; //3a460211409897f4
		}
		
		public function get data():IPlugData
		{
			return _model;
		}
		
		public function initialization():void
		{
			//Initialize the multiplayer API (You can only do this once)
			var connection:Connection = NonobaAPI.MakeMultiplayer(iPluginStage);
			connection.addEventListener(MessageEvent.MESSAGE,onMessage);  
			connection.addEventListener(ConnectionEvent.DISCONNECT,function(event:ConnectionEvent):void{
				trace("disconnect",event.Description);
			}); 
			connection.Send("hello");
		}
		
		public function showData():Boolean
		{
			//Gets the Nonoba username.
			NonobaAPI.GetUsername(iPluginStage, function(response:String, username:String):void
			{
				switch (response)
				{
					case NonobaAPI.SUCCESS:
					{
						trace("username: " + username)
						break;
					}
					case NonobaAPI.NOT_LOGGED_IN:
					{
						trace("The user is not logged in")
						break;
					}
					case NonobaAPI.ERROR:
					{
						trace("An error occurred.")
						break;
					}
				}
			});
			//
			//Loads data from the server using the key "somedata"
			NonobaAPI.GetUserData(iPluginStage, "somedata", function(response:String, data:String):void
			{
				switch (response)
				{
					case NonobaAPI.SUCCESS:
					{
						trace("Data sucessfully loaded from the server")
						trace("Value: " + data)
						break;
					}
					case NonobaAPI.NOT_LOGGED_IN:
					{
						trace("The user is not logged in")
						break;
					}
					case NonobaAPI.ERROR:
					{
						trace("An error occurred.")
						break;
					}
				}
			});
			return false;
		}
		
		public function showStore():Boolean
		{
			//Shows the shop for the item noba		
			NonobaAPI.ShowShop(iPluginStage, "noba", function(response:String, success:Boolean):void
			{
				switch (response)
				{
					case NonobaAPI.SUCCESS:
					{
						trace("Nonoba,Shop was shown, did we buy the item?", success);
						break;
					}
					case NonobaAPI.ERROR:
					{
						trace("Nonoba,An error occurred.");
						break;
					}
				}
			})
			return true;
		}
		
		public function showLeaderboard(value:Object):Boolean
		{
			//Awards the achievement with the key "monsterkill"
			NonobaAPI.AwardAchievement(iPluginStage, "monsterkill", function(response:String, count:Number):void
			{
				switch (response)
				{
					case NonobaAPI.SUCCESS:
					{
						trace("The achievement was successfully awarded.")
						trace("It has been awarded " + count + " times.")
						break;
					}
					case NonobaAPI.NOT_LOGGED_IN:
					{
						trace("The user is not logged in.")
						break;
					}
					case NonobaAPI.ERROR:
					{
						trace("An error occurred.")
						break;
					}
				}
			})
			return true;
		}
		
		public function showLoginWidget():Boolean
		{
			NonobaAPI.Login(iPluginStage, loginHandler);
			return true;
		}
		
		public function saveData(value:Object):Boolean
		{
			//Saves the string "Some data we want to store" using the key "somedata"
			NonobaAPI.SetUserData(iPluginStage, "somedata", "Some data we want to store", function(response:String):void
			{
				switch (response)
				{
					case NonobaAPI.SUCCESS:
					{
						trace("Data successfully stored on the server.")
						break;
					}
					case NonobaAPI.NOT_LOGGED_IN:
					{
						trace("The user is not logged in.")
						break;
					}
					case NonobaAPI.ERROR:
					{
						trace("An error occurred.")
						break;
					}
				}
			})
			
			return true;
		}
		
		public function submitData(value:Object):Boolean
		{
			//Submits Number(value) to the high score list with the key identifier "kills"
			NonobaAPI.SubmitScore(iPluginStage, "kills", Number(value), function(response:String):void
			{
				switch (response)
				{
					case NonobaAPI.SUCCESS:
					{
						trace("The score was submitted successfully")
						break;
					}
					case NonobaAPI.NOT_LOGGED_IN:
					{
						trace("The user is not logged in")
						break;
					}
					case NonobaAPI.ERROR:
					{
						trace("An error occurred.")
						break;
					}
				}
			})
			//
			return true;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		protected function get iPluginStage():Stage
		{
			return MovieClip(FlexGlobals.topLevelApplication.pluginStage).stage;
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		//Authenticating is done asynchronously, so a callback method is used to get the result 
		private function loginHandler(response:String):void
		{
			switch (response)
			{
				case NonobaAPI.SUCCESS:
				{
					trace("Nonoba,Logged in!");
					break;
				}
				case NonobaAPI.NOT_LOGGED_IN:
				{
					trace("Nonoba,The user is not logged in");
					break;
				}
				case NonobaAPI.ERROR:
				{
					trace("Nonoba,An error occurred.");
					break;
				}
			}
		}
		//
		private function onMessage(e:Object):void{
			var message:Object = e.message;
			switch(message.Type){
				case "hi":{
					trace("Got response from server on hello message");
					break;
				}
				case "welcometogame":{
					trace("Got welcome! - There are " + message.GetInt(0) + " other users in the game")
					break;
				}
				case "tick":{
					trace("Got Tick!")
					break;
				}
				case "delayedhello":{
					trace("Got Delayed Hello")
					break;
				}
				default:{
					trace("Got unhandled message > " + message)
				}
			}
		}
	}
	
}