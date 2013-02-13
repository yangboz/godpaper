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
package com.godpaper.as3.views.screens
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	import com.adobe.cairngorm.task.SequenceTask;
	import com.adobe.cairngorm.task.TaskEvent;
	import com.godpaper.as3.configs.BoardConfig;
	import com.godpaper.as3.configs.GameConfig;
	import com.godpaper.as3.configs.IndicatorConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.core.FlexGlobals;
	import com.godpaper.as3.core.IChessBoard;
	import com.godpaper.as3.plugins.playerIO.PlayerIoPlugin;
	import com.godpaper.as3.tasks.CreateChessBoardTask;
	import com.godpaper.as3.tasks.CreateChessGasketTask;
	import com.godpaper.as3.tasks.CreateChessPieceTask;
	import com.godpaper.as3.tasks.CreateChessVoTask;
	import com.godpaper.as3.tasks.CreatePiecesBoxTask;
	import com.godpaper.as3.tasks.CreatePluginButtonBarTask;
	import com.godpaper.as3.tasks.FillInPiecesBoxTask;
	import com.godpaper.as3.utils.LogUtil;
	import com.godpaper.as3.views.components.ChessBoard;
	import com.godpaper.as3.views.plugin.PluginButtonBar;
	import com.godpaper.as3.views.popups.ExitComfirmIndicatory;
	import com.lookbackon.AI.steeringBehavior.SteeredVehicle;
	
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Screen;
	import feathers.controls.TabBar;
	import feathers.core.PopUpManager;
	import feathers.data.ListCollection;
	import feathers.layout.AnchorLayoutData;
	
	import mx.logging.ILogger;
	
	import org.spicefactory.lib.task.SequentialTaskGroup;
	
	import starling.display.DisplayObject;
	import starling.events.Event;

	/**
	 * GameScreen accepts input from the user and instructs the model and a viewport to perform actions based on that input. 	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Apr 16, 2012 11:01:37 AM
	 */   	 
	public class GameScreen extends ScreenBase
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
		//Header view
		private var _header:Header;
		//
		private var _button_back:Button;
		private var _tabBar:TabBar;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(GameScreen);
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
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
		public function GameScreen()
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
		override protected function initialize():void
		{
			//Store reference to FlexGlobal.
			FlexGlobals.gameScreen = this;
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
			//create pices box
			if(!BoardConfig.piecesBoxRequired)
			{
				this.startUpSequenceTask.addChild(new CreateChessPieceTask());//34.090M
			}
			this.startUpSequenceTask.addChild(new CreateChessVoTask());//34.922M
			//Plugin button bar view init
			this.startUpSequenceTask.addChild(new CreatePluginButtonBarTask());
			//task complete
			this.startUpSequenceTask.addEventListener(TaskEvent.TASK_COMPLETE,startUpTaskCompleteHandler);
			//task start
			this.startUpSequenceTask.start();
			//Header view here.
			//
			this._button_back = new Button();
			//			this._button_back.label = "BACK";
			this._button_back.label = this.resourceManager.getString(this.bundleName,"BTN_BACK");
			//			this._button_back.onRelease.add(backButton_onRelease);
			this._button_back.addEventListener(starling.events.Event.TRIGGERED,backButton_onRelease);
			//
			this._tabBar = new TabBar();
			this._tabBar.isEnabled = false;
			this._tabBar.dataProvider = new ListCollection(
				[
					{ label: FlexGlobals.userModel.ROLE_NAME_LIST[0] },
					{ label: FlexGlobals.userModel.ROLE_NAME_LIST[1] },
					{ label: FlexGlobals.userModel.ROLE_NAME_LIST[2] },
				]);
//			this._tabBar.addEventListener(Event.CHANGE, tabBar_changeHandler);
//			this._tabBar.layoutData = new AnchorLayoutData(NaN, 0, 0, 0);
			//which tab bar item should selected?
			this._tabBar.selectedIndex = FlexGlobals.userModel.hosterRoleIndex;
			this.addChild(this._tabBar);
			//
			this._header = new Header();
			this._header.title = playerIoPlugin.roomID;
//			this._header.title = this.resourceManager.getString(this.bundleName,"HEADER_SETTINGS");
			this.addChild(this._header);
			this._header.rightItems = new <DisplayObject>
				[
					this._tabBar
				];	
			this._header.leftItems = new <DisplayObject>
				[
					this._button_back
				];
			//Waiting indicatory as default under multiplay mode
			if(GameConfig.playMode==GameConfig.HUMAN_VS_HUMAN)
			{
//				if(!FlexGlobals.userModel.hosterRoleIndex)//Hoster shoulde be waiting.
//				{	
					IndicatorConfig.waiting = true;
//				}
				if(this.playerIoPlugin)
				{
					this.playerIoPlugin.signal_user_joined.addOnce(onOpponentJoined);
				}
			}else
			{
				//Transparent the header view for overlay display
				this._header.alpha = 0.5;
			}
		}
		//
		override protected function draw():void
		{
			this._header.width = this.actualWidth;
			this._header.validate();
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		private function startUpTaskCompleteHandler(event:TaskEvent):void
		{
			this.startUpSequenceTask.removeEventListener(TaskEvent.TASK_COMPLETE,startUpTaskCompleteHandler);
			//
			GameConfig.gameStateManager.start();
		}
		//
		private function backButton_onRelease(event:Event):void
		{
			//Pop up an quit game prompt at first,if neccessary.
			var exitConfirmIndicatory:ExitComfirmIndicatory = new ExitComfirmIndicatory();
			//
			PopUpManager.addPopUp(exitConfirmIndicatory,true,true);
			PopUpManager.centerPopUp(exitConfirmIndicatory);
		}
		//
		private function onOpponentJoined():void
		{
			if(!FlexGlobals.userModel.hosterRoleIndex)//Hoster can move chess piece now.
			{	
				IndicatorConfig.waiting = false;
			}
		}
	}
	
}