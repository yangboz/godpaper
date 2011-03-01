package com.godpaper.as3.business.fsm.states.chess
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.business.fsm.ChessAgent;
	import com.lookbackon.AI.FSM.states.StateBase;
	
	
	/**
	 * RenascenceState.as class. Chess piece rebirth state by unmake move.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Dec 9, 2010 11:00:50 AM
	 */   	 
	public class RenascenceState extends StateBase
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
		public function RenascenceState(agent:ChessAgent, resource:Object, description:String=null)
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