package com.lookbackon.AI.HFSM.states
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.lookbackon.AI.FSM.states.IState;
	/**
	 * IHState.as class. Each state needs to only define events that it responds to.
	 * Note, state classes do not have to be nested inside here, 
	 * but i just thought it more clearly shows affiliation:it's a state of our object.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jan 4, 2011 11:54:36 AM
	 */ 
	//State hierarhy.
	//		
	//		IState_base<Aggregator>
	//		|
	//		State          <<-app-specific, prototypes every event handled by the system
	//		/   | \
	//	   /    |   \
	//	  /     |     \
	//	state1 state2 state3 <<each state implements functions for events that it cares about
	//					|
	//				  state4
	//					|
	//				  state5
	public interface IHState
	{
		//
		function derivesFrom(state:IState):Boolean;
	}
}