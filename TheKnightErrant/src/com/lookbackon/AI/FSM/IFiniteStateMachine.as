package com.lookbackon.AI.FSM
{
	import com.lookbackon.AI.FSM.states.IState;
	
	/**
	 * Our FiniteStateMachine must implment this interface.
	 * 
	 * @author Knight.zhou
	 * 
	 * </time> 01/04/2011 agent with message handler,for multi-agent communication.
	 */    
	public interface IFiniteStateMachine
	{
		function set globalState(s:IState):void;
		function get globalState():IState;
		
		function set currentState(s:IState):void;
		function get currentState():IState;
		
		function set previousState(s:IState):void;
		function get previousState():IState;
		
		function set nextState(s:IState):void;
		function get nextState():IState;
		
		function onMessage(message:Message):void;
	}
}