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
package com.godpaper.as3.plugins.kongregate
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.core.FlexGlobals;
	import com.godpaper.as3.plugins.IPlug;
	import com.godpaper.as3.plugins.IPlugData;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.Security;
	
//	import mx.managers.SystemManager;
	
	
	/**
	 * KongregatePlugin API integration enables your game to report scores and statistics to our leaderboards, 
	 * share levels and other content, sell virtual items, and export custom avatars from your game. 
	 * API inclusion will also get your game a 10% payout bonus and qualify it to be included in our cash developer contests.  
	 * Kongregate offers both client and server APIs, allowing a wide range of flexible integration configurations.
	 * The Client API is very simple to access from your game, and integration can be achieved using several different programming languages. 
	 * The Server API allows your remote server to integrate with our back-end using simple web-service calls.All developers should become familiar with the Client API, 
	 * as it is required for all integrations. If you have your own game server, you should read the documentation for both the client and server APIs. 
	 * 
	 * @see:http://www.kongregate.com/developer_center/docs/as3-api 	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Apr 25, 2011 3:33:00 PM
	 */   	 
	public class KongregatePlugin implements IPlug
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		// Kongregate API reference
		private var kongregate:*;
		//@see: http://www.kongregate.com/developer_center/docs/chat-integration-api  
		//showTab(name:String,description:String,options:Object):void
		private var _model:KongregateModel;
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
		public function KongregatePlugin(gameID:String="", boardID:String="")
		{
			_model = new KongregateModel();
			_model.gameID = gameID;
			_model.boardID = boardID;
		}
		
		public function get data():IPlugData
		{
			return _model;
		}
		
		public function initialization():void
		{
			// Pull the API path from the FlashVars
//			var paramObj:Object = LoaderInfo(root.loaderInfo).parameters;
//			var paramObj:Object = SystemManager.getSWFRoot(FlexGlobals.topLevelApplication).loaderInfo.parameters;
			var paramObj:Object = FlexGlobals.topLevelApplication.loaderInfo.parameters;
			// The API path. The "shadow" API will load if testing locally.
			var apiPath:String = paramObj.kongregate_api_path ||
				"http://www.kongregate.com/flash/API_AS3_Local.swf";
			
			// Allow the API access to this SWF
			Security.allowDomain(apiPath);
			
			// Load the API
			var request:URLRequest = new URLRequest(apiPath);
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadCompleteHandler);
			loader.load(request);
			//			this.addChild(loader);
			FlexGlobals.topLevelApplication.pluginStage.addChild(loader);
		}
		
		public function showData():Boolean
		{
			//The isGuest function can be called to determine if the player is currently signed into Kongregate or not: 
			var isGuest:Boolean = kongregate.services.isGuest();
			//Getting the player's Kongregate username
			var username:String = kongregate.services.getUsername();
			//Getting the player's Kongregate user id
			var user_id:Number = kongregate.services.getUserId();
			//Getting the player's game authentication token
			var token:String = kongregate.services.getGameAuthToken();
			//
			
			//
			return true;
		}
		//Displaying the Kred Purchase Dialog
		//@see http://www.kongregate.com/developer_center/docs/microtransaction-client-api
		public function showStore():Boolean
		{
			// Display a dialog informing users how to earn free Kreds.
			kongregate.mtx.showKredPurchaseDialog("offers");//The purchase method to display. Should be "offers" or "mobile"
			return true;
		}
		
		//Creating your statistics
		//@see: http://www.kongregate.com/developer_center/docs/statistics-api 
		public function showLeaderboard(value:Object):Boolean
		{
			//TODO: implement function
			//Give each statistic a name, description, and choose it’s type. You can also select statistics you wish to show up in the leaderboards by checking the "Display in Leaderboards" option. 
			return false;
		}
		
		public function showLoginWidget():Boolean
		{
			//Showing the sign-in box
			if(kongregate.services.isGuest())
			{
				kongregate.services.showSignInBox();
			}
			//			If you want to show the user registration lightbox, you can call: 
			//			kongregate.services.showRegistrationBox();
			
			return true;
		}
		//@see:http://www.kongregate.com/developer_center/docs/shared-content-api
		public function saveData(value:Object):Boolean
		{
			//TODO: implement function
			return false;
		}
		/**
		 * Submit various statistics to the server
		 * @see http://www.kongregate.com/developer_center/docs/statistics-client-api 
		 */		
		public function submitData(value:Object):Boolean
		{
			for(var key:String in value)
			{
				kongregate.stats.submit(key,value[key]);
			}
			//			kongregate.stats.submit("Coins",1); // The user collected a coin
			//			kongregate.stats.submit("MonstersKilled",1); //The user killed a monster
			//			kongregate.stats.submit("HighScore",398); //The user got a score of 398
			//			kongregate.stats.submit("LapTime",60); //User finished a lap in 60 seconds
			return true;
			
			//submitAvatar(avatar:DisplayObject, callback:Function):void
			//@see: http://www.kongregate.com/developer_center/docs/avatar-api
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
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		private function loadCompleteHandler(event:Event):void
		{
			// Save Kongregate API reference
			kongregate = event.target.content;
			
			// Connect to the back-end
			kongregate.services.connect();
			
			// You can now access the API via:
			// kongregate.services
			// kongregate.user
			// kongregate.scores
			// kongregate.stats
			// etc...
			//The connect function should be used as soon as you have access 
			//to the Kongregate API object in order to initialize the connection to our servers:
			kongregate.services.connect();
		}
	}
	
}