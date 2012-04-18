package com.godpaper.as3.business.fsm.states.chess
{
	import com.lookbackon.AI.FSM.states.StateBase;
	import com.godpaper.as3.business.fsm.ChessAgent;
	import com.godpaper.starling.views.components.ChessPiece;
	
	/**
	 * Defense state try to keep "marshal" safty.</br>
	 * - Fortify Position </br>
	 * - Defend Friendly Unit By Attacking Threatening Unit</br>
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class DefenseState extends StateBase
	{
		private var _carrier:ChessPiece;
		//
		public function DefenseState(agent:ChessAgent,resource:Object,description:String=null)
		{
			super(agent,resource,description);
		}
		
		override public function enter():void
		{
			//TODO: implement function
			_carrier = this.resource as ChessPiece;
			//
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