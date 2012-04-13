package com.lookbackon.AI.HFSM.states
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.lookbackon.AI.FSM.IAgent;
	import com.lookbackon.AI.FSM.states.IState;
	import com.lookbackon.AI.FSM.states.StateBase;
	/**
	 * HStateBase.as class. The base class of HFSM state.  	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jan 4, 2011 1:25:11 PM
	 */   	 
	public class HStateBase extends StateBase implements IHState
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
		public function HStateBase(agent:IAgent, resource:Object, description:String=null)
		{
			//TODO: implement function
			super(agent, resource, description);
		}
		/**
		 * Note that derivesFrom() is a template function in a class template and to use it, 
		 * each sub-state should override this function.
		 */		
		virtual public function derivesFrom(state:IState):Boolean
		{
			//TODO: implement function
			return false;
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
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