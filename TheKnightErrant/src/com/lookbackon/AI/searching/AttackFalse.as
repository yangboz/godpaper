package com.lookbackon.AI.searching
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.configs.GameConfig;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.model.vos.PositionVO;
	import com.godpaper.as3.utils.FilterUtil;
	
	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;
	/**
	 * AttackFalse.as class.(假进攻)
	 * @author Knight.zhou
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jul 14, 2010 10:29:00 AM
	 */   	 
	public class AttackFalse extends SearchingBase
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:Logger = LogContext.getLogger(AttackFalse);
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
		public function AttackFalse(gamePosition:PositionVO)
		{
			//TODO: implement function
			super(gamePosition);
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		override public function run():void
		{
			if(orderingMoves.length<=0)
			{
				//pluge to death.
				GameConfig.gameStateManager.humanWin();
			}else
			{
				var pValue:int=-1;
				var attackMoves:Vector.<ConductVO>;
				var evaluatedValue:int=int.MIN_VALUE;
				if(captures.length>0)
				{
					attackMoves = captures.filter(FilterUtil.onEatOff);
				}else
				{
					attackMoves = orderingMoves;
				}
				bestMove = tempMove;//set default bestMove.
				for(var i:int=0;i<attackMoves.length;i++)
				{
					positionEvaluated = doEvaluation(attackMoves[i],gamePosition);
					if(positionEvaluated>pValue)
					{
						LOG.debug("selected attackMoves:{0}",attackMoves[i].dump());
						bestMove = attackMoves[i];
						pValue = positionEvaluated;
					}else
					{
						if(positionEvaluated>evaluatedValue)
						{
							evaluatedValue = positionEvaluated;
							bestMove = attackMoves[i];
							pValue = positionEvaluated;
						}
					}
				}
				LOG.debug("bestMove:{0}",bestMove.dump());
				LOG.debug("max position value:{0}",pValue);
				//
				this.processDone = true;
			}
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

