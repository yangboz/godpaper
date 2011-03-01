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


	/**
	 * HumanState.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Dec 10, 2010 11:12:15 AM
	 */   	 
	public class HumanState extends StateBase
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
		public function HumanState(agent:IAgent, resource:Object, description:String=null)
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
			GameConfig.turnFlag = DefaultConstants.FLAG_RED;
			//
			IndicatorConfig.readOut=false;
			//about data
		}

		override public function exit():void
		{
			//TODO: implement function
		}

		override public function update(time:Number=0):void
		{
			//TODO: implement function
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

