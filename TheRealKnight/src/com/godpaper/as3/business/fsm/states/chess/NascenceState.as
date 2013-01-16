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
	 * NascenceState.as class. Chess piece nacency state after created from chess factory;  	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Dec 9, 2010 11:02:11 AM
	 */   	 
	public class NascenceState extends StateBase
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
		public function NascenceState(agent:ChessAgent, resource:Object, description:String=null)
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