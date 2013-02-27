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
package com.godpaper.as3.core
{
	import com.adobe.cairngorm.task.SequenceTask;
	import com.godpaper.as3.configs.ServiceConfig;
	import com.godpaper.as3.model.ChessBoardModel;
	import com.godpaper.as3.model.ChessGasketsModel;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.model.UserModel;
	import com.godpaper.as3.plugins.playerIO.PlayerIoService;
	import com.godpaper.as3.services.ConductService;
	import com.godpaper.as3.services.IConductService;
	import com.godpaper.as3.utils.SingletonFactory;
	import com.godpaper.as3.views.components.PiecesBox;
	import com.godpaper.as3.views.screens.GameScreen;
	import com.lookbackon.AI.FSM.Message;
	
	import feathers.controls.Screen;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.popups.IPopUpContentManager;
	
	import org.osflash.signals.Signal;
	import org.spicefactory.lib.task.SequentialTaskGroup;
	
	import starling.display.Stage;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * A marshalling class which list the global variables and referecnes without access limitation.
	 * Just like the "FlexGloabls.as" which located at FLEX4 framework.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Apr 19, 2012 10:41:05 AM
	 */   	 
	public class FlexGlobals
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
		//Views.
		public static var topLevelApplication:ApplicationBase;
//		public static var gameScene:GameScene;//The scene of game.
		public static var gameScreen:GameScreen;//The screen of game.
		public static var gameStage:Stage;//The stage of game.
		public static var bluePiecesBox:PiecesBox;//The pieces box(blue).
		public static var redPiecesBox:PiecesBox;//The pieces box(red).
		////pop-up views manager
		public static var popupContentManager:IPopUpContentManager;
		//Models.
		public static var chessPiecesModel:ChessPiecesModel = SingletonFactory.produce(ChessPiecesModel);
		public static var chessGasketsModel:ChessGasketsModel = SingletonFactory.produce(ChessGasketsModel);
		public static var chessBoardModel:ChessBoardModel = SingletonFactory.produce(ChessBoardModel);
		public static var userModel:UserModel = SingletonFactory.produce(UserModel);
		//Signals.
		public static var levelUpSignal:Signal = new Signal(int);//user level up signal.
		public static var checkSignal:Signal = new Signal(Message);//chess check signal.
		//Screen navigator
		public static var screenNavigator:ScreenNavigator;
		//Services
//		public static var conductService:ConductService = SingletonFactory.produce(ConductService);
		public static var conductService:IConductService = SingletonFactory.produce(ServiceConfig.wrapper);
		//Task references
		public static var cleanUpSequenceTask:SequentialTaskGroup;
		public static var startUpSequenceTask:SequenceTask;
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
	}
	
}