package com.godpaper.as3.business.fsm.states.game
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.configs.GameConfig;
	import com.godpaper.as3.configs.IndicatorConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.model.ChessBoardModel;
	import com.godpaper.as3.core.FlexGlobals;
	import com.godpaper.as3.utils.LogUtil;
	import com.lookbackon.AI.FSM.IAgent;
	import com.lookbackon.AI.FSM.states.StateBase;
	import com.lookbackon.AI.evaluation.IEvaluation;
	import com.lookbackon.AI.searching.ISearching;
	
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import mx.logging.ILogger;
	
	import org.generalrelativity.thread.GreenThread;
	import org.generalrelativity.thread.IRunnable;
	
	import pl.mateuszmackowiak.visuals.CursorManager;
	
	import com.godpaper.as3.model.ChessBoardModel;
	import com.godpaper.as3.model.ChessGasketsModel;
	import com.godpaper.as3.model.ChessPiecesModel;
	/**
	 * ComputerState.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Dec 10, 2010 11:11:56 AM
	 */
	public class ComputerState extends StateBase
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//The agent obtains searching.
		public var searching:ISearching;
		//
		private var processes:Vector.<IRunnable>;
		private var greenThread:GreenThread;
		//Models
		protected var chessPiecesModel:ChessPiecesModel = FlexGlobals.chessPiecesModel;
		protected var chessGasketsModel:ChessGasketsModel = FlexGlobals.chessGasketsModel;
		protected var chessBoardModel:ChessBoardModel = FlexGlobals.chessBoardModel;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger=LogUtil.getLogger(ComputerState);
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
		public function ComputerState(agent:IAgent, resource:Object, description:String=null)
		{
			super(agent, resource, description);
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		override public function enter():void
		{
			//hold turn flag
			GameConfig.turnFlag=DefaultConstants.FLAG_BLUE;
			//about view
			CursorManager.setBusyCursor();
			//
			IndicatorConfig.readOut=true;
			//default update current state.
			update(GameConfig.gameStateManager.level);
		}

		override public function exit():void
		{
			//about view
			CursorManager.removeBusyCursor();
			//
			IndicatorConfig.readOut=false;
		}

		override public function update(time:Number=0):void
		{
			//switch any searching class to test.
			//just like:
			//			gameAI = new RandomWalk(ChessPiecesModel.getInstance().gamePosition);
			//			searching = new MinMax(ChessPiecesModel.getInstance().gamePosition);
			//			searching = new MiniMax(ChessPiecesModel.getInstance().gamePosition,5);
			//			gameAI = new NegaMax(ChessPiecesModel.getInstance().gamePosition,1);
			//			gameAI = new AlphaBeta(ChessPiecesModel.getInstance().gamePosition);
			//			gameAI = new Quiescence(ChessPiecesModel.getInstance().gamePosition);
			//			gameAI = new PVS(ChessPiecesModel.getInstance().gamePosition);
			//			gameAI = new ShortSighted(ChessPiecesModel.getInstance().gamePosition);
			//			searching = new AttackFalse(ChessPiecesModel.getInstance().gamePosition);
			//Using the class reflection architure to dynamic instance the configed class,
			//@see the DefaultTollgatesConstant.as
			//process the searching class reflection.
//			var className:String=getQualifiedClassName(GameConfig.tollgates[time].searching);
//			var implementation:Object=getDefinitionByName(className);
//			searching=new implementation(FlexGlobals.chessBoardModel.status);
			searching=new GameConfig.tollgates[time].searching(FlexGlobals.chessBoardModel.status);
			//process the evaluation class reflection.
			var evaluationClassName:String = getQualifiedClassName(GameConfig.tollgates[time].evaluation);
			var evaluationClass:Object = getDefinitionByName(evaluationClassName);
			searching.evaluation = new evaluationClass();
			//
			LOG.info("current toll gate is:{0}", getQualifiedClassName(GameConfig.tollgates[time].searching));
			//using this flash green thread algorithm to avoid script time limition only 15s.
			processes=new Vector.<IRunnable>();
			processes.push(searching);
//			greenThread=new GreenThread(processes, 60);
			LOG.debug("GreenThread hertz:{0}",FlexGlobals.topLevelApplication.stage.frameRate);
			greenThread=new GreenThread(processes, FlexGlobals.topLevelApplication.stage.frameRate);
			//
			//			greenThread.addEventListener(GreenThreadEvent.PROCESS_TIMEOUT, function(event:GreenThreadEvent):void
			//			{
			//				LOG.error(event.toString());
			//			});
			//			greenThread.addEventListener(GreenThread.CYCLE, function(event:Event):void
			//			{
			//				LOG.debug(event.toString());
			//			});
			//			greenThread.addEventListener(GreenThreadEvent.PROCESS_COMPLETE, function(event:GreenThreadEvent):void
			//			{
			//				LOG.info(event.toString());
			//			});
			//			greenThread.addEventListener(Event.COMPLETE, function(event:Event):void
			//			{
			//				LOG.info(event.toString());
			//			});
			//
			greenThread.open();
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

