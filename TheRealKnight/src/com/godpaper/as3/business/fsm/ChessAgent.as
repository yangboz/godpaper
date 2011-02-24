package com.godpaper.as3.business.fsm
{
	import com.lookbackon.AI.FSM.Agent;
	import com.godpaper.as3.consts.CcjConstants;
	import com.godpaper.as3.utils.LogUtil;
	
	import com.godpaper.as3.business.fsm.states.chess.AttackState;
	import com.godpaper.as3.business.fsm.states.chess.DefenseState;
	import com.godpaper.as3.business.fsm.states.chess.NascenceState;
	import com.godpaper.as3.business.fsm.states.chess.RenascenceState;
	
	import mx.core.IVisualElement;
	import mx.logging.ILogger;
	
	/**
	 * ChessAgent to agently maintain all of chess state.
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class ChessAgent extends Agent
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		public var attackState:AttackState;
		public var defenseState:DefenseState;
		public var nascenceState:NascenceState;
		public var renascenceState:RenascenceState;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(ChessAgent);
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		/**
		 *  Constructor.
		 */
		public function ChessAgent(name:String, carrier:IVisualElement, traceTarget:IVisualElement=null)
		{
			//TODO: implement function
			super(name, carrier, traceTarget);
//			LOG.info("{0} say:Hello!",name);
			this.attackState=new AttackState(this, null, CcjConstants.STATE_ATTACK);
			this.defenseState=new DefenseState(this, null, CcjConstants.STATE_DEFENCE);
			this.nascenceState=new NascenceState(this, null, CcjConstants.STATE_NASCENCE);
			this.renascenceState=new RenascenceState(this, null, CcjConstants.STATE_RENASCENCE);
		}
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		//--------------------------------------------------------------------------
		//
		//  Methods:
		//
		//--------------------------------------------------------------------------
	}
}