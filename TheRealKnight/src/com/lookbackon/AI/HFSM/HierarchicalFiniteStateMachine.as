package com.lookbackon.AI.HFSM
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.lookbackon.AI.FSM.Agent;
	import com.lookbackon.AI.FSM.FiniteStateMachine;
	import com.lookbackon.AI.FSM.states.IState;
	import com.godpaper.as3.utils.LogUtil;

	import mx.logging.ILogger;
	import com.lookbackon.AI.FSM.Message;

	import com.lookbackon.AI.HFSM.states.IHState;
	/**
	 * HierarchicalFiniteStateMachine.as class.
	 * In a hierarchical finite state machine,any state can be  a substate of some large state.
	 * @see http://www.drdobbs.com/184402040;jsessionid=PYAOQHC2ZEFFFQE1GHPCKHWATMY32JVN?pgno=3
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Dec 27, 2010 5:56:15 PM
	 */
	public class HierarchicalFiniteStateMachine extends FiniteStateMachine implements IHierarchicalFiniteStateMachine
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger=LogUtil.getLogger(HierarchicalFiniteStateMachine);

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
		public function HierarchicalFiniteStateMachine(owner:Agent, currentState:IState=null, previousState:IState=null, nextState:IState=null)
		{
			//TODO: implement function
			super(owner, currentState, previousState, nextState);
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		/**
		 * Change to another sub-state.
		 *
		 * @param s is anew state.actually is IHState.
		 *
		 */
		override public function changeState(s:IState):void
		{
			if (s && IHState(s).derivesFrom(currentState))
			{
				return;
			}
			//			LOG.debug("exited:{0}",currentState==null?currentState:currentState.description);
			if (currentState != null)
			{
				currentState.exit();
			}
			previousState=currentState;
			globalState=s;
			currentState=s;
			LOG.debug("previousState:{0}||globalState:{1}||currentState:{2}", previousState == null ? previousState : previousState.description, globalState == null ? globalState : globalState.description, currentState == null ? currentState : currentState.description);
			//
			if (previousState && IHState(previousState).derivesFrom(currentState))
			{
				return;
			}
			//
			currentState.enter();
			//			LOG.debug("entered:{0}",currentState==null?currentState:currentState.description);
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

