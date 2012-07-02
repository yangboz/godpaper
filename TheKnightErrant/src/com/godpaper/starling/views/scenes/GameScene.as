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
package com.godpaper.starling.views.scenes
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	import com.adobe.cairngorm.task.SequenceTask;
	import com.godpaper.as3.configs.BoardConfig;
	import com.godpaper.as3.core.IChessBoard;
	import com.godpaper.as3.model.FlexGlobals;
	import com.godpaper.as3.tasks.CreateChessBoardTask;
	import com.godpaper.as3.tasks.CreateChessGasketTask;
	import com.godpaper.as3.tasks.CreateChessPieceTask;
	import com.godpaper.as3.tasks.CreateChessVoTask;
	import com.godpaper.as3.tasks.CreatePiecesBoxTask;
	import com.godpaper.as3.tasks.CreatePluginButtonBarTask;
	import com.godpaper.as3.tasks.FillInPiecesBoxTask;
	import com.godpaper.as3.utils.LogUtil;
	import com.godpaper.starling.views.components.ChessBoard;
	import com.godpaper.starling.views.plugin.PluginButtonBar;
	import com.lookbackon.AI.steeringBehavior.SteeredVehicle;
	
	import mx.logging.ILogger;
	
	import org.spicefactory.lib.task.SequentialTaskGroup;
	
	import starling.display.DisplayObject;
	import starling.events.Event;

	/**
	 * GameScene accepts input from the user and instructs the model and a viewport to perform actions based on that input. 	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Apr 16, 2012 11:01:37 AM
	 */   	 
	public class GameScene extends SceneBase
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//Tasks
		public var cleanUpSequenceTask:SequentialTaskGroup;
		public var startUpSequenceTask:SequenceTask;
		//
		private var _vehicle:SteeredVehicle;
		private var _circles:Array;
		private var _numCircles:int = 10;
		//
		public var chessBoard:ChessBoard;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(GameScene);
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
		public function GameScene()
		{
			super();
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
		//
		override protected function addToStageHandler(event:Event):void
		{
			//Store reference to FlexGlobal.
			FlexGlobals.gameScene = this;
			//			CursorManager.setBusyCursor();
			// sound initialization takes a moment, so we prepare them here
			AssetEmbedsDefault.loadBitmapFonts();
			//Add visualElement to view.
			//create chess board.
			//create chess gaskets.
			//create chess piece
			//create chess pieces' chessVO;
			//create chess pieces' omenVO;
			//create plugin button bar.
			this.startUpSequenceTask = new SequenceTask();
			this.startUpSequenceTask.label = "startUpSequenceTask";//29.748M(debug)
			//Display chess board at first.
			this.startUpSequenceTask.addChild(new CreateChessBoardTask());//33.332M
			//Display the pieces box if neccessary
			if(BoardConfig.piecesBoxRequired)
			{
				this.startUpSequenceTask.addChild(new CreatePiecesBoxTask());
				this.startUpSequenceTask.addChild(new FillInPiecesBoxTask());
			}
			this.startUpSequenceTask.addChild(new CreateChessGasketTask());//33.316M
			if(!BoardConfig.piecesBoxRequired)
			{
				this.startUpSequenceTask.addChild(new CreateChessPieceTask());//34.090M
			}
			this.startUpSequenceTask.addChild(new CreateChessVoTask());//34.922M
			//create pices box
			//Plugin button bar view init
			this.startUpSequenceTask.addChild(new CreatePluginButtonBarTask());
			this.startUpSequenceTask.start();
			//TODO:top gap setting.
//			this.y = 50;
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}
	
}