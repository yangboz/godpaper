package com.lookbackon.AI.FSM.states
{
	/**
	 * Each state implements the IState interface. 
	 * Each state implements enter and exit metheod
	 * for one-off action that the agent takes
	 * when entering and leaving the state,
	 * in addition to the update method 
	 * which is run repeatedly while in the state.
	 * The time parameter in the update method 
	 * is the duration of the frame we're excuting.
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public interface IState
	{
		//a description for this action.
		function set description(value:String):void;
		function get description():String;
		
		function enter():void;//called on entering the state
		function exit():void;//called on leaving the state
		function update(time:Number=0):void;//called every frame while in the state
	}
}