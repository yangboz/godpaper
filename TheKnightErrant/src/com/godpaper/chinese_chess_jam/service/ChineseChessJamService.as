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
package com.godpaper.chinese_chess_jam.service
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.core.FlexGlobals;
	import com.godpaper.as3.plugins.playerIO.PlayerIoPlugin;
	import com.godpaper.as3.services.IConductService;
	
	import playerio.Message;
	/**
	 * ChineseChessJamService.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Feb 14, 2013 11:57:57 AM
	 */   	 
	public class ChineseChessJamService implements IConductService
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		public function get connected():Boolean
		{
			//TODO: implement function
			return false;
		}
		//
		public function get playerIoPlugin():PlayerIoPlugin
		{
			//Refresh game room with tables.
			var playerIoPlugin:PlayerIoPlugin = (FlexGlobals.topLevelApplication.pluginProvider as PlayerIoPlugin);
			return playerIoPlugin;
		}
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
		public function ChineseChessJamService()
		{
			//TODO: implement function
		}
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		//
		public function initialization(...arg):void
		{
			//TODO: implement function
		}
		//
		public function transforBrevity(value:String):String
		{
			//Create a message and send
			//@example: "c7747"
			var chessPieceType:String = value.charAt(0);
			var startPosition:int = int(value.charAt(1).concat(value.charAt(2)));
			var endPosition:int = int(value.charAt(3).concat(value.charAt(4)));
			var message:Message = playerIoPlugin.connection.createMessage("move", chessPieceType, startPosition, endPosition);
			playerIoPlugin.connection.sendMessage(message);
			//
			return null;
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
	}
	
}