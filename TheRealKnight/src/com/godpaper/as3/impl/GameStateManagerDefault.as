package com.godpaper.as3.impl
{
	import com.adobe.cairngorm.task.SequenceTask;
	import com.godpaper.as3.business.fsm.GameAgent;
	import com.godpaper.as3.configs.GameConfig;
	import com.godpaper.as3.configs.IndicatorConfig;
	import com.godpaper.as3.configs.PieceConfig;
	import com.godpaper.as3.consts.CcjConstants;
	import com.godpaper.as3.core.IGameStateManager;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.model.vos.PositionVO;
	import com.godpaper.as3.tasks.CleanUpChessPieceTask;
	import com.godpaper.as3.tasks.CleanUpPiecesBitboardTask;
	import com.godpaper.as3.tasks.CreateChessPieceTask;
	import com.godpaper.as3.tasks.CreateChessVoTask;
	import com.godpaper.as3.utils.LogUtil;
	import com.lookbackon.AI.searching.AttackFalse;
	import com.lookbackon.AI.searching.MiniMax;
	import com.lookbackon.AI.searching.RandomWalk;
	import com.lookbackon.AI.searching.ShortSighted;

	import mx.core.FlexGlobals;
	import mx.core.IVisualElement;
	import mx.logging.ILogger;

	/**
	 * A player manager class to maintain turn-based game.
	 *
	 * @author Knight.zhou
	 *
	 */
	public class GameStateManagerDefault implements IGameStateManager
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//
		private var chessPieceModel:ChessPiecesModel=ChessPiecesModel.getInstance();
		//
		private var _isRunning:Boolean;
		//
		private var _level:int=1;
		//
		public var agent:GameAgent;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private const LOG:ILogger=LogUtil.getLogger(GameStateManagerDefault);
		//game phase
		//Masks for bits inside the 'flags' var
		//which store the state of Boolean game phase properties.
		public const PHASE_OPENING:uint=1 << 0;
		public const PHASE_MIDDLE:uint=1 << 1;
		public const PHASE_ENDING:uint=1 << 2;

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  get Game Phase
		//----------------------------------
		/**
		 * The game phase is decided by how many pieces both sides have left.
		 * @param gamePosition the current game position information.
		 * @return the current game position's game phase.
		 */
		public function get phase():uint
		{
			var gamePhase:uint=PHASE_OPENING;
			if (chessPieceModel.gamePosition.board.celled <= 14 && chessPieceModel.gamePosition.board.celled >= 6)
			{
				gamePhase=PHASE_MIDDLE;
			}
			if (chessPieceModel.gamePosition.board.celled < 6 && chessPieceModel.gamePosition.board.celled >= 1)
			{
				gamePhase=PHASE_ENDING;
			}
			return gamePhase;
		}
		//
		public function get level():int
		{
			return _level;
		}

		public function set level(value:int):void
		{
			_level = value;
		}
		//
		public function get isRunning():Boolean
		{
			return _isRunning;
		}

		public function set isRunning(value:Boolean):void
		{
			_isRunning = value;
		}
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  startGame
		//----------------------------------
		public function start():void
		{
			//TODO:
			//agent initialization.
			agent=new GameAgent("CCJGameAgent", FlexGlobals.topLevelApplication as IVisualElement);
			//logic condition who's turn now at first.
			if (GameConfig.turnFlag == CcjConstants.FLAG_BLUE)
			{
				isComputerTurnNow();
			}
			else if (GameConfig.turnFlag == CcjConstants.FLAG_RED)
			{
				isHumanTurnNow();
			}
			else
			{
				//TODO,another human turn now.
				isAnotherHumanTurnNow();
			}
			//flag game is running.
			isRunning=true;
		}

		//----------------------------------
		//  restartGame
		//----------------------------------
		public function restart():void
		{
			//TODO:re-start game
			//clean up indicators.
			IndicatorConfig.check=false;
			IndicatorConfig.submitScore=false;
			//clear board,chess pieces
			FlexGlobals.topLevelApplication.cleanUpSequenceTask.addTask(new CleanUpChessPieceTask());
			FlexGlobals.topLevelApplication.cleanUpSequenceTask.addTask(new CleanUpPiecesBitboardTask());
			FlexGlobals.topLevelApplication.cleanUpSequenceTask.start();
			//dump the end of game messages.
			FlexGlobals.topLevelApplication.dumpFootSprint();
			//
			//put down chess pieces again
			//no more create chess gasket again.
			//no more using start up task at Main.mxml.
			var startUpTask:SequenceTask=new SequenceTask();
			startUpTask.addChild(new CreateChessPieceTask(PieceConfig.factory));
			startUpTask.addChild(new CreateChessVoTask(PieceConfig.factory));
			startUpTask.start();
			//
			FlexGlobals.topLevelApplication.dumpFootSprint();
			//
			start();
		}

		//----------------------------------
		//  computerWin
		//----------------------------------
		public function computerWin():void
		{
			//TODO:
			agent.fsm.changeState(agent.computerWinState);
		}

		//----------------------------------
		//  humanWin
		//----------------------------------
		public function humanWin():void
		{
			//TODO:
			agent.fsm.changeState(agent.humanWinState);
		}

		//----------------------------------
		//  anotherHumanWin
		//----------------------------------
		public function anotherHumanWin():void
		{
			//TODO:
			agent.fsm.changeState(agent.anotherHumanWinState);
		}

		//----------------------------------
		//  isComputerTurnNow
		//----------------------------------
		public function isComputerTurnNow():void
		{
			//delegate fsm transition to computer state.
			agent.fsm.changeState(agent.computerState);
		}

		//----------------------------------
		//  isHumanTurnNow
		//----------------------------------
		public function isHumanTurnNow():void
		{
			//delegate fsm transition to computer state.
			agent.fsm.changeState(agent.humanState);
		}

		//----------------------------------
		//  isAnotherHumanTurnNow
		//----------------------------------
		public function isAnotherHumanTurnNow():void
		{
			//delegate fsm transition to another human state.
			agent.fsm.changeState(agent.anotherHumanState);
		}
	}
}

