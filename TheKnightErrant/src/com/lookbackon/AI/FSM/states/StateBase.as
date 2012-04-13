package com.lookbackon.AI.FSM.states
{
	import com.lookbackon.AI.FSM.IAgent;

	/**
	 * The base class of FSM state.
	 * @author Knight.zhou
	 * 
	 */	
	public class StateBase implements IState
	{
		protected var agent:IAgent;
		protected var resource:Object;//the current state's resource(effect,movie,etc...)
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function StateBase(agent:IAgent,resource:Object,description:String=null)
		{
			this.agent = agent;
			this.resource = resource;
			this.description = description;
		}
		//--------------------------------------------------------------------------
		//
		//  Properties(implement)
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  position
		//----------------------------------
		private var _description:String;
		public function set description(value:String):void
		{
			_description = value;
		}
		public function get description():String
		{
			//TODO: implement function
			return _description;
		}
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		//enter
		virtual public function enter():void
		{
			//TODO: implement function
		}
		//exit
		virtual public function exit():void
		{
			//TODO: implement function
		}
		//update
		virtual public function update(time:Number=0):void
		{
			//TODO: implement function
		}
	}
}