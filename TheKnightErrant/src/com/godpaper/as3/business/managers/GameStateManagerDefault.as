package com.godpaper.as3.business.managers
{
	import com.adobe.cairngorm.task.SequenceTask;
	import com.godpaper.as3.business.fsm.GameAgent;
	import com.godpaper.as3.configs.GameConfig;
	import com.godpaper.as3.configs.IndicatorConfig;
	import com.godpaper.as3.configs.PieceConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.core.FlexGlobals;
	import com.godpaper.as3.core.IGameStateManager;
	import com.godpaper.as3.model.ChessBoardModel;
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
	
	import mx.logging.ILogger;
	import mx.utils.BitFlagUtil;

	/**
	 * A player manager class to maintain turn-based game.
	 * Include sort of properties and methods for identifying game status.
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
		//Model refs
		private var chessPieceModel:ChessPiecesModel=FlexGlobals.chessPiecesModel;
		private var chessBoardModel:ChessBoardModel=FlexGlobals.chessBoardModel;
		//
		private var _isRunning:Boolean;
		//
		private var _level:int=0;
		//
		public var agent:GameAgent;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private const LOG:ILogger=LogUtil.getLogger(GameStateManagerDefault);
		//game phase
		//Masks for bits inside the 'flags' var
		//which store the state of Boolean game phase properties.
		public static const PHASE_OPENING:uint=1 << 0;
		public static const PHASE_MIDDLE:uint=1 << 1;
		public static const PHASE_ENDING:uint=1 << 2;
		//turn now flag.
		public static const TURN_NOW_COMPUTER:uint = 1<<0;
		public static const TURN_NOW_HUMAN:uint = 1<<1;
		public static const TURN_NOW_ANOTHER_HUMAN:uint = 1<<2;
		// A value to indicate the current players role.
		protected var _roles:uint = 0; 
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
			if ( chessBoardModel.status.board.celled <= chessBoardModel.status.board.size/2
				&& chessBoardModel.status.board.celled >= chessBoardModel.status.board.size/3 )
			{
				gamePhase=PHASE_MIDDLE;
			}
			if (chessBoardModel.status.board.celled < chessBoardModel.status.board.size/3 
				&& chessBoardModel.status.board.celled >= 1)
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
		//----------------------------------
		//  isBlueSide
		//----------------------------------
		public function get isBlueSide():Boolean
		{
			return GameConfig.gameStateManager.getRolePlaying(GameStateManagerDefault.TURN_NOW_COMPUTER);
		}
		//----------------------------------
		//  isRedSide
		//----------------------------------
		public function get isRedSide():Boolean
		{
			return GameConfig.gameStateManager.getRolePlaying(GameStateManagerDefault.TURN_NOW_HUMAN);
		}
		//----------------------------------
		//  isGreenSide
		//----------------------------------
		public function get isGreenSide():Boolean
		{
			return GameConfig.gameStateManager.getRolePlaying(GameStateManagerDefault.TURN_NOW_ANOTHER_HUMAN);
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
//			agent=new GameAgent("CCJGameAgent", FlexGlobals.topLevelApplication as IVisualElement);
			agent=new GameAgent("CCJGameAgent", null);
			//logic condition who's turn now at first.
			if (GameConfig.turnFlag == DefaultConstants.FLAG_BLUE)
			{
				isComputerTurnNow();
			}
			else if (GameConfig.turnFlag == DefaultConstants.FLAG_RED)
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
			//reset game step number.
			chessBoardModel.stepNumber=0;
			//clear board,chess pieces
			FlexGlobals.gameScreen.cleanUpSequenceTask.addTask(new CleanUpChessPieceTask());
			FlexGlobals.gameScreen.cleanUpSequenceTask.addTask(new CleanUpPiecesBitboardTask());
			FlexGlobals.gameScreen.cleanUpSequenceTask.start();
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
			//set turn now flag at frist.
			_roles = TURN_NOW_COMPUTER;
			//delegate fsm transition to computer state.
			agent.fsm.changeState(agent.computerState);
		}

		//----------------------------------
		//  isHumanTurnNow
		//----------------------------------
		public function isHumanTurnNow():void
		{
			//set turn now flag at frist.
			_roles = TURN_NOW_HUMAN;
			//delegate fsm transition to computer state.
			agent.fsm.changeState(agent.humanState);
		}

		//----------------------------------
		//  isAnotherHumanTurnNow
		//----------------------------------
		public function isAnotherHumanTurnNow():void
		{
			//set turn now flag at frist.
			_roles = TURN_NOW_ANOTHER_HUMAN;
			//delegate fsm transition to another human state.
			agent.fsm.changeState(agent.anotherHumanState);
		}
		
		//----------------------------------
		//  getRolePlaying
		//----------------------------------
		public function getRolePlaying(flagMask:uint):Boolean
		{
			return BitFlagUtil.isSet(_roles,flagMask);
		}
		
		
	}
}

