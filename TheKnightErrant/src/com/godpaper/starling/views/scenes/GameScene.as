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
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.model.FlexGlobals;
	import com.godpaper.as3.tasks.CreateChessGasketTask;
	import com.godpaper.as3.tasks.CreateChessPieceTask;
	import com.godpaper.as3.tasks.CreateChessVoTask;
	import com.godpaper.as3.utils.LogUtil;
	import com.godpaper.starling.views.components.ChessBoard;
	import com.godpaper.starling.views.plugin.PluginButtonBar;
	import com.lookbackon.AI.steeringBehavior.SteeredVehicle;
	
	import mx.logging.ILogger;
	
	import org.josht.starling.foxhole.controls.TabBar;
	import org.josht.starling.foxhole.themes.IFoxholeTheme;
	import org.spicefactory.lib.task.SequentialTaskGroup;
	
	import starling.display.Image;
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
		private var _tabBar:TabBar;
		private var _theme:IFoxholeTheme;
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
//		override protected function onEnter(data:Array):void
		{
			//
			//			CursorManager.setBusyCursor();
			// sound initialization takes a moment, so we prepare them here
			AssetEmbedsDefault.loadBitmapFonts();
			//Add visualElement to view.
			
			//Pieces box
			
			//Plugin bar
			
			//Other views testing
			
			//Display chess board at first.
			var chessBoardBackground:Image = new Image(AssetEmbedsDefault.getTexture(DefaultConstants.IMG_BACK_GROUND));
			//			this.chessBoard = new ChessBoard(chessBoardBackground);
			var chessBoard:ChessBoard = new ChessBoard(null);
			FlexGlobals.gameStage.addChild(starling.display.DisplayObject(chessBoard));
			// plugin view init
			//			this.pluginUIComponent = new PluginUIComponent();
			//			this.addChild(starling.display.DisplayObject(this.pluginUIComponent));
			//Plugin button bar
			var pluginButtonBar:PluginButtonBar = new PluginButtonBar();
			pluginButtonBar.height = 50;
			FlexGlobals.gameStage.addChild(pluginButtonBar);
			//			//create chess gaskets.
			//			//create chess piece
			//			//create chess pieces' chessVO;
			//			//create chess pieces' omenVO;
			this.startUpSequenceTask = new SequenceTask();
			this.startUpSequenceTask.label = "startUpSequenceTask";//33.6M(debug)
			this.startUpSequenceTask.addChild(new CreateChessGasketTask());//34.1M
			this.startUpSequenceTask.addChild(new CreateChessPieceTask());//34.8M
			this.startUpSequenceTask.addChild(new CreateChessVoTask());//35.5M
			this.startUpSequenceTask.start();
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		private function layout(w:Number, h:Number):void
		{
			this._tabBar.width = w;
			this._tabBar.x = (w - this._tabBar.width) / 2;
			this._tabBar.y = h - this._tabBar.height;
		}
	}
	
}