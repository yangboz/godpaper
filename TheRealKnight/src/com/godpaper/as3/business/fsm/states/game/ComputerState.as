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
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.utils.LogUtil;
	import com.lookbackon.AI.FSM.IAgent;
	import com.lookbackon.AI.FSM.states.StateBase;
	import com.lookbackon.AI.searching.AttackFalse;
	import com.lookbackon.AI.searching.ISearching;
	import com.lookbackon.AI.searching.MiniMax;
	import com.lookbackon.AI.searching.RandomWalk;
	import com.lookbackon.AI.searching.ShortSighted;
	
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import mx.core.FlexGlobals;
	import mx.logging.ILogger;
	import mx.managers.CursorManager;
	
	import org.generalrelativity.thread.GreenThread;
	import org.generalrelativity.thread.IRunnable;

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
			//TODO: implement function
			super(agent, resource, description);
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		override public function enter():void
		{
			//TODO: implement function
			//hold turn flag
			GameConfig.turnFlag=DefaultConstants.FLAG_BLUE;
			//about view
			CursorManager.setBusyCursor();
			//
			IndicatorConfig.readOut=true;
			//default update current state.
			update(GameConfig.gameStateManager.level - 1);
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
			//TODO:switch any searching class to test.
			//			gameAI = new RandomWalk(ChessPiecesModel.getInstance().gamePosition);
			//			searching = new MinMax(ChessPiecesModel.getInstance().gamePosition);
			//			searching = new MiniMax(ChessPiecesModel.getInstance().gamePosition,5);
			//			gameAI = new NegaMax(ChessPiecesModel.getInstance().gamePosition,1);
			//			gameAI = new AlphaBeta(ChessPiecesModel.getInstance().gamePosition);
			//			gameAI = new Quiescence(ChessPiecesModel.getInstance().gamePosition);
			//			gameAI = new PVS(ChessPiecesModel.getInstance().gamePosition);
			//			gameAI = new ShortSighted(ChessPiecesModel.getInstance().gamePosition);
			//			searching = new AttackFalse(ChessPiecesModel.getInstance().gamePosition);
			//
			var className:String=getQualifiedClassName(GameConfig.tollgates[time]);
			var implementation:Object=getDefinitionByName(className);
			searching=new implementation(ChessBoardModel.getInstance().status);
			//
			LOG.info("current toll gate is:{0}", getQualifiedClassName(implementation));
			//using this flash green thread algorithm to avoid script time limition only 15s.
			processes=new Vector.<IRunnable>();
			processes.push(searching);
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

