package com.lookbackon.AI.FSM
{
//	import mx.core.IVisualElement;
	import com.godpaper.as3.core.IVisualElement;

	/**
	 * The agent uses an instance of the FiniteStateMachine class the handle its AI.</br>
	 * The agent class is a lot more manageable without the FSM implementation
	 * and all the states inside it. </br>
	 * and must have a single FSM class
	 * that can be used by all agents(who)can even share states across agents too.</br>
	 *
	 * @author Knight.zhou
	 *
	 */
	public class Agent implements IAgent
	{
		/**
		 *
		 * @param the name of agent;
		 * @param the carrier of agent;
		 * @param the agen's traceTarget;
		 *
		 */
		public function Agent(name:String, carrier:IVisualElement, traceTarget:IVisualElement=null)
		{
			this._fsm=new FiniteStateMachine(this);
			this._name=name;
			this._carrier=carrier;
			this._traceTarget=traceTarget;
		}
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		private var _fsm:FiniteStateMachine;
		/**
		 *
		 * @return agent's FiniteStateMachine
		 *
		 */
		public function get fsm():FiniteStateMachine
		{
			return _fsm;
		}

		private var _name:String="unnamed";
		/**
		 *
		 * @return agent's name.
		 *
		 */
		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name=value;
		}

		private var _carrier:IVisualElement;
		/**
		 *
		 * @return agent's carrier.
		 *
		 */
		public function get carrier():IVisualElement
		{
			return _carrier;
		}

		public function set carrier(value:IVisualElement):void
		{
			_carrier=value;
		}

		private var _traceTarget:IVisualElement;
		/**
		 *
		 * @return agent's trace target if neccessary.
		 *
		 */	
		public function get traceTarget():IVisualElement
		{
			return _traceTarget;
		}

		public function set traceTarget(value:IVisualElement):void
		{
			_traceTarget=value;
		}

		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		/**
		 * delegate fsm to update;
		 */
		public function update():void
		{
			fsm.update();
		}
		/**
		 * delegate fsm to message handle;
		 * @param message from other agent.
		 * 
		 */		
		public function onMessage(message:Message):void
		{
			fsm.onMessage(message);
		}

	}
}