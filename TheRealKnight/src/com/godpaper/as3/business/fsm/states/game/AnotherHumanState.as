package com.godpaper.as3.business.fsm.states.game
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.configs.GameConfig;
	import com.godpaper.as3.configs.IndicatorConfig;
	import com.godpaper.as3.consts.CcjConstants;
	import com.lookbackon.AI.FSM.IAgent;
	import com.lookbackon.AI.FSM.states.StateBase;

	import mx.managers.CursorManager;


	/**
	 * AnotherHumanState.as class.This state internal hold on another human state,such as board,chess pice,game info,etc..
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
			//hold turn flag
			GameConfig.turnFlag = CcjConstants.FLAG_GREEN;
			//TODO:logicly decide read out transition on this stage.(Opponent/Network transform wating).
			IndicatorConfig.readOut=false;
			//about view
			CursorManager.setBusyCursor();
			//about data

		}

		override public function exit():void
		{
			//about view
			CursorManager.removeBusyCursor();
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

