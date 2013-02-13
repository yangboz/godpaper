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
	import com.lookbackon.AI.FSM.IAgent;
	import com.lookbackon.AI.FSM.states.StateBase;
	import com.godpaper.as3.model.ChessBoardModel;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.core.FlexGlobals;
	
//	import mx.managers.CursorManager;
	import pl.mateuszmackowiak.visuals.CursorManager;


	/**
	 * AnotherHumanState.as class.The game statement of AnotherHuman with flag(green).
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Dec 10, 2010 11:12:44 AM
	 */   	 
	public class AnotherHumanState extends StateBase
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var chessPiecesModel:ChessPiecesModel = FlexGlobals.chessPiecesModel;
		private var chessBoardModel:ChessBoardModel = FlexGlobals.chessBoardModel;
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
		public function AnotherHumanState(agent:IAgent, resource:Object, description:String=null)
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
			GameConfig.turnFlag = DefaultConstants.FLAG_GREEN;
			//Logicly decide read out transition on this stage.(Opponent/Network transform wating).
			IndicatorConfig.readOut=false;
			//about view
			//Simplify loading mask,to wait the apponent's action.
			IndicatorConfig.waiting=true;
			
			//about data
		}

		override public function exit():void
		{
			//about view
//			CursorManager.removeBusyCursor();
			//increase the game step number.
			chessBoardModel.stepNumber++;
		}

		override public function update(time:Number=0):void
		{

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

