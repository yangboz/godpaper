package com.lookbackon.AI.searching
{
	import com.godpaper.as3.configs.GameConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.model.vos.PositionVO;
	import com.godpaper.as3.utils.LogUtil;

	import mx.logging.ILogger;

	/**
	 * The normal MiniMax code is a bit clumsy, </br>
	 * since one side is trying to maximize the value and the other
	 * is trying to minimize - therefore, </br>
	 * with MiniMax we always have to check if we are the side
	 * trying to maximize or the side trying to minimize. </br>
	 * A neat way to get rid of this and to have a simpler function is NegaMax.</br>
	 * With the NegaMax algorithm both sides try to maximize all the time.</br>
	 * NegaMax is identical to MiniMax, it's just a nicer formulation.</br>
	 *
	 * You can see that the NegaMax algorithm is shorter and simpler than the MiniMax algorithm.</br>
	 * At first sight, NegaMax is a bit harder to understand than MiniMax, but it's in fact much easier to use. </br>
	 * The side to move is always trying to maximize the value. </br>
	 * NegaMax is no better or worse than MiniMax - it's identical. </br>
	 * It's just a better framework to use. </br>
	 *
	 * @param postion the piece's postion in board.</br>
	 * @param depth the piece's depth in this game tree.</br>
	 *
	 * @see http://www.fierz.ch/strategy.htm
	 * @author Knight.zhou
	 */
	public class NegaMax extends SearchingBase
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger=LogUtil.getLogger(NegaMax);

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
		public function NegaMax(gamePosition:PositionVO, depth:int)
		{
			super(gamePosition);
			//
		}

		//
		override public function run():void
		{
			//
			negaMax(gamePosition, depth);
		}

		//
		private function negaMax(gamePosition:PositionVO, depth:int):int
		{
			/*
			int negamax(POSITION *p, int depth)
			{
			MOVE list[MAXMOVES];
			int i,n,value,bestvalue=-INFINITY;

			if(checkwin(p))
			return -INFINITY;

			if(depth == 0)
			return evaluation(p);
			n = makemovelist(p,list);
			if(n == 0)
			return handlenomove(p);

			for(i=0; i<n; i++)
			{
			domove(&list[i],p);
			value = -negamax(p,depth-1);
			undomove(&list[i],p);
			bestvalue = max(value,bestvalue);
			}
			return bestvalue;
			}*/
			LOG.debug("depth:{0}", depth.toString());
			//
			bestValue=int.MIN_VALUE;
			//
			if (willNoneMove(gamePosition))
			{
				return int.MIN_VALUE;
			}
			//
			if (0 == depth)
			{
				return doEvaluation(tempMove, gamePosition);
			}
			//
			if (0 == orderingMoves.length)
			{
				return noneMove();
			}
			//
			var len:int=orderingMoves.length;
			LOG.debug("orderingMoves.length:{0}", len);
			//
			for (var i:int=0; i < len / 2; i++)
			{
				LOG.debug("current orderingMoves.step:{0}", i.toString());
				makeMove(tempMove);
				tempValue=-negaMax(gamePosition, depth - 1);
				unmakeMove(tempMove);
				bestValue=Math.max(tempValue, bestValue);
				//
				if (tempValue >= bestValue)
				{
					bestMove=tempMove;
				}
			}
			LOG.debug("bestValue:{0}", bestValue.toString());
			//
			this.processDone=true;
			//
			return bestValue;
		}

		/**
		 * The point is that the call value = -negamax(p,d-1); </br>
		 * takes care of the signs - or nearly. </br>
		 * There is one further modification we must make for this code to work:</br>
		 * The evaluation function must be sensitive to the side to move
		 * - for a position with red to move it must return its normal evaluation,
		 * for a position with blue to move it must return -evaluation.  </br>
		 *
		 * @param conductVO
		 * @param gamePosition
		 * @return evaluation result
		 *
		 */
		override public function doEvaluation(conductVO:ConductVO, gamePosition:PositionVO):int
		{
			if (GameConfig.turnFlag == DefaultConstants.FLAG_BLUE)
			{
				positionEvaluated=super.doEvaluation(conductVO, gamePosition);
			}
			else
			{
				positionEvaluated=-super.doEvaluation(conductVO, gamePosition);
			}
			return positionEvaluated;
		}
	}
}

