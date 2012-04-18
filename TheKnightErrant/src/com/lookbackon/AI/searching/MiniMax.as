package com.lookbackon.AI.searching
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.configs.GameConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.model.ChessBoardModel;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.model.vos.PositionVO;
	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;

	/**
	 * <b>MiniMax.as class.</b></br>
	 *
	 * The idea here is that both players will try all possible moves in their position and then choose, respectively,
	 * the one which makes the value of the position as high as possible (the white side) or as low as possible (black).</br>
	 * I have called one color 'WHITE', this is the side which tries to maximize the value,
	 * and the other side tries to minimize the value. </br>
	 * You can see that player 'WHITE' starts with a value of -INFINITY,
	 * and then goes on to try every move,
	 * and always maximizes the best value so far with the value of the current move.</br>
	 * The other player, BLACK, will start out with +INFINITY and try to reduce this value. </br>
	 * Note how I use a function checkwin(p)  to detect a winning position <b>during</b> the tree search. </br>
	 * If you only check winning conditions at the end of your variation,
	 * you can generate variations where both sides have won,
	 *  for instance in connect 4 you could generate a variation where first one side connects four,
	 * and later the other side does. </br>
	 * Also, note the use of handlenomove(p)  - that's what you need to do when you have no legal move left.
	 * In checkers you will lose, in chess it's a draw.</br>
	 * If the (average) number of possible moves at each node is N,
	 * you see that you have to search N^D positions to search to depth D. N is called the branching factor. </br>
	 * Typical branching factors are 40 for chess, 7 for connect 4, 10 for checkers and 300 for go. </br>
	 * The larger the branching factor is, the less far you will be able to search with this technique. </br>
	 * This is the main reason that a game like connect 4 has been solved,
	 * that checkers programs are better than humans,
	 * chess programs are very strong already,
	 * but go programs are still playing very poorly - always when compared to humans.  </br>
	 * @see http://www.fierz.ch/strategy1.htm
	 * @author Knight.zhou
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jul 9, 2010 4:12:01 PM
	 */   	 
	public class MiniMax extends SearchingBase
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:Logger = LogContext.getLogger(MiniMax);
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
		public function MiniMax(gamePosition:PositionVO,depth:int=5)
		{
			//
			this.depth = depth;
			//
			super(gamePosition);
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		override public function run():void
		{
			//
//			miniMax(gamePosition,depth);
			//
			maxi(depth);
		}
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		private function maxi(depth:int):int
		{
			if(this.processDone) return int.MIN_VALUE;
			//
			if(depth==0)
			{
				//
				var result:int = doEvaluation(bestMove,gamePosition);
				trace("maxi do evaluation result:",result);
				//
				this.processDone = true;
				//
				return result; 
			}
			var max:int = int.MIN_VALUE;
			//
			orderingMoves = generateMoves(ChessPiecesModel.getInstance().blues);
			var len:int = orderingMoves.length;
			//
			if(orderingMoves.length<=0)
			{
				//pluge to death.
				GameConfig.gameStateManager.humanWin();
			}else
			{
				//
				for(var i:int=0;i<len;i++)
				{
					var score:int = mini(depth-1);
					if(score>max)
					{
						max = score;
						//
						this.bestMove = this.orderingMoves[i];
					}
				}
			}
			//
			trace("maxi result:",result);
			return max;
		}

		private function mini(depth:int):int
		{
			if(this.processDone) return int.MIN_VALUE;
			//
			if(depth==0)
			{
				var result:int = -doEvaluation(bestMove,gamePosition);
				trace("mini do evaluation result:",result);
				//
				this.processDone = true;
				//
				return result;  
			}
			var min:int = int.MAX_VALUE;
			//
			orderingMoves = generateMoves(ChessPiecesModel.getInstance().blues);
			var len:int = orderingMoves.length;
			//
			if(orderingMoves.length<=0)
			{
				//pluge to death.
				GameConfig.gameStateManager.humanWin();
			}else
			{
				for(var i:int=0;i<len;i++)
				{
					var score:int = maxi(depth-1);
					if(score<min)
					{
						min = score;
						//
						this.bestMove = this.orderingMoves[i];
					}
				}
			}
			//
			trace("mini result:",result);
			return min;
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		private function miniMax(gamePosition:PositionVO,depth:int):int
		{
			LOG.debug("depth:{0}",depth.toString());
			if(willNoneMove(gamePosition))
			{
				if(gamePosition.color==DefaultConstants.FLAG_RED)
				{
					//
					this.processDone = true;
					//
					return int.MIN_VALUE;
				}else
				{
					//
					this.processDone = true;
					//
					return int.MAX_VALUE;
				}
			}
			if(depth==0)
			{
				//
				this.processDone = true;
				//
				return doEvaluation(bestMove,gamePosition);
			}
			if(gamePosition.color==DefaultConstants.FLAG_RED)
			{
				bestValue = int.MIN_VALUE;
			}else
			{
				bestValue = int.MAX_VALUE;
			}
			if(gamePosition.color==DefaultConstants.FLAG_RED)
			{
				orderingMoves = generateMoves(ChessPiecesModel.getInstance().reds);
				//pluge to death.
				if(0==orderingMoves.length)
				{
					GameConfig.gameStateManager.computerWin();
				}
			}else
			{
				orderingMoves = generateMoves(ChessPiecesModel.getInstance().blues);
				//pluge to death.
				if(0==orderingMoves.length)
				{
					GameConfig.gameStateManager.humanWin();
				}
			}
			LOG.debug("orderingMoves.length:{0}",orderingMoves.length);
			//Notice:exceed 60s limit,just 35 steps.
			for(var i:int=0;i<orderingMoves.length/2;i++)
			{
				//
				LOG.debug("current orderingMoves.step:{0}",i.toString());
				tempMove = orderingMoves[i];
				//
				makeMove(tempMove);
				tempValue = miniMax(ChessBoardModel.getInstance().status,depth-1);
				unmakeMove(tempMove);
				//
				if(gamePosition.color==DefaultConstants.FLAG_RED)
				{
					bestValue = Math.max(tempValue,bestValue);
					//
					if(tempValue>=bestValue)
					{
						bestMove = tempMove; 
					}
					LOG.debug("RED,worstMove:{0}",bestMove.dump());
				}else
				{
					bestValue = Math.min(tempValue,bestValue);
					//
					if(bestValue>=tempValue)
					{
						bestMove = tempMove; 
					}
					LOG.debug("BLUE,bestMove:{0}",bestMove.dump());
				}
			}
			//
			this.processDone = true;
			//
			return bestValue;
		}
	}

}

