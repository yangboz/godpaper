package com.lookbackon.AI.FSM
{
	import com.lookbackon.AI.FSM.states.IState;
	
	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;
	
	/**
	 * The FiniteStateMachine is responsible for
	 * managing the current state.
	 * 
	 * Add a number of features to the FSM class to 
	 * all chaining of states and returning to previous states.
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class FiniteStateMachine implements IFiniteStateMachine
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private static const LOG:Logger = LogContext.getLogger(FiniteStateMachine);
		//
		private var _globalState:IState;//For globally track monster's state.
		private var _currentState:IState;
		private var _previousState:IState;
		private var _nextState:IState;
		protected var owner:Agent;
		//--------------------------------------------------------------------------
		//
		//  Contructor
		//
		//--------------------------------------------------------------------------
		public function FiniteStateMachine( owner:Agent,
											currentState:IState=null,
											previousState:IState=null,
											nextState:IState=null
		)
		{
			this.owner = owner;
			this.currentState = currentState;
			this.previousState = previousState;
			this.nextState = nextState;
		}
		/**
		 * Prepare a global state for globally tracking current state.
		 *  
		 * @param s is anew state;
		 * 
		 */     
		public function set globalState( s:IState ):void
		{
			_globalState = s ;
		}
		public function get globalState():IState
		{
			return _globalState;
		}
		/**
		 * Prepare a state for using the current state.
		 *  
		 * @param s is anew state;
		 * 
		 */     
		public function set currentState( s:IState ):void
		{
			_currentState = s ;
		}
		public function get currentState():IState
		{
			return _currentState;
		}
		/**
		 * Prepare a state for use after the current state.
		 *  
		 * @param s is anew state;
		 * 
		 */		
		public function set nextState( s:IState ):void
		{
			_nextState = s ;
		}
		public function get nextState():IState
		{
			return _nextState;
		}
		/**
		 * Prepare a state for use before the current state.
		 *  
		 * @param s is anew state;
		 * 
		 */     
		public function set previousState( s:IState ):void
		{
			_previousState = s ;
		}
		public function get previousState():IState
		{
			return _previousState;
		}
		/**
		 * Update the fsm state with time interval.
		 */		
		public function update(time:int=0):void
		{
			if(currentState)
			{
				currentState.update(time);
			}
		}
		/**
		 * Change to another state.
		 *  
		 * @param s is anew state.
		 * 
		 */		
		public function changeState( s:IState ):void
		{
			//			LOG.debug("exited:{0}",currentState==null?currentState:currentState.description);
			if(currentState!=null)
			{
				currentState.exit();
			}
			previousState = currentState;
			globalState = s;
			currentState = s;
			LOG.debug("previousState:{0}||globalState:{1}||currentState:{2}",
				previousState==null?previousState:previousState.description,
				globalState==null?globalState:globalState.description,
				currentState==null?currentState:currentState.description);
			currentState.enter();
			//			LOG.debug("entered:{0}",currentState==null?currentState:currentState.description);
		}
		/**
		 * Go to the previous state. 
		 */		
		public function goToPreviousState():void
		{
			changeState( previousState );
		}
		/**
		 * Go to the next state. 
		 */		
		public function goToNextState():void
		{
			changeState( nextState );
		}
		/**
		 * 
		 * @param message 
		 * 
		 */		
		public function onMessage(message:Message):void
		{
			//TODO: implement function
		} 
		
	}
}