package com.godpaper.as3.business.fsm.states.chess
{
	import com.godpaper.as3.business.fsm.ChessAgent;
	import com.lookbackon.AI.FSM.states.StateBase;

	/**
	 * - Attack Nearest Enemy Unit</br>
	 * - Attack Weakest Enemy Unit</br>
	 * - Attack Strongest Enemy Unit</br>
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class AttackState extends StateBase
	{
		public function AttackState(agent:ChessAgent,resource:Object,description:String=null)
		{
			super(agent,resource,description);
		}
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
	}
}