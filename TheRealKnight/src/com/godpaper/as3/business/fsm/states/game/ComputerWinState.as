package com.godpaper.as3.business.fsm.states.game
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.configs.GameConfig;
	import com.lookbackon.AI.FSM.IAgent;
	import com.lookbackon.AI.FSM.states.StateBase;

	import mx.controls.Alert;


	/**
	 * ComputerWinState.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Dec 23, 2010 2:23:17 PM
	 */   	 
	public class ComputerWinState extends StateBase
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
		public function ComputerWinState(agent:IAgent, resource:Object, description:String=null)
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
			GameConfig.gameStateManager.isRunning = false;
			//
			Alert.show("You play like a monkey,@-@","Computer Win!");
		}

		override public function update(time:Number=0):void
		{

		}

		override public function exit():void
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

