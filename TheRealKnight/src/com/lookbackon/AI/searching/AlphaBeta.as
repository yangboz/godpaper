package com.lookbackon.AI.searching
{
	import com.godpaper.as3.model.vos.PositionVO;
	import com.godpaper.as3.utils.LogUtil;
	
	import de.polygonal.ds.Array2;
	
	import mx.logging.ILogger;
	
	/**
	 * <b>Search enhancements</b></br>
	 * All techniques above aimed at reducing the number of nodes to search by better move ordering. </br>
	 * There is another class of enhancements with the same goal, but with different means. </br>
	 * These enhancements try to exploit the nature of the AlphaBeta algorithm, 
	 * which has to search fewer nodes when the alpha-beta window is smaller. </br>
	 * 
	 * <b>Note</b> how AlphaBeta receives the parameters alpha and beta which tell it what range 
	 * the value of the current position should lie. </br>
	 * Once a move has returned with a higher value than alpha, 
	 * this best value is saved in the variable localalpha and used for the next recursive call of AlphaBeta. </br>
	 * If the best value is larger than beta, 
	 * the search terminates immediately - we have found a move which refutes the notion that this position 
	 * has a value in the range from alpha to beta, 
	 * and do not need to look for another one. </br>
	 * 
	 * <b>Note</b> how my AlphaBeta function is returning the highest value it found, 
	 * this can be higher than beta. </br>
	 * Some people prefer to return beta instead of the best value on a fail high, 
	 * that formulation of AlphaBeta is known as fail-hard. </br>
	 * My formulation above is called fail-soft. </br>
	 * The names come from the fact that in fail hard, 
	 * the bounds alpha and beta are "hard", 
	 * the return value cannot be outside the alpha-beta window. </br>
	 * It would seem that fail-soft is much more sensible, as it might lead to more cutoffs: </br>
	 * If you can return a higher value than beta (or a lower value than alpha), 
	 * then perhaps you might get a cutoff in a previous instance of AlphBeta 
	 * at a lower level in the search tree that you wouldn't get otherwise. </br>
	 * 
	 * <b>However,</b> the fail-hard camp says they get less search instabilities 
	 * when using advanced techniques such as pruning. </br>
	 * 
	 * @see http://www.fierz.ch/strategy1.htm
	 * @author Knight.zhou
	 */    
	public class AlphaBeta extends SearchingBase
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//
		private var localAlpha:int;
		private var hashValue:int;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(AlphaBeta);
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
		/**
		 * 
		 * The major improvement over MiniMax/NegaMax is the AlphaBeta algorithm: </br>
		 * Here you realize that you don't have to go through the whole search tree. </br>
		 * If you find one winning continuation, you don't have to look at any others. </br>
		 * Similarly, if you have found one continuation which will give you 
		 * the value V you can stop your search along another continuation 
		 * if you find only one possibility for your opponent 
		 * which gives you a lower score than V. </br>
		 * You don't have to look at all the other possibilities your opponent
		 *  might have - one refutation is enough! </br>
		 * Here is the code for AlphaBeta, extending the earlier NegaMax code: </br>
		 * It receives two extra parameters, alpha and beta. </br>
		 * They define an interval within which the evaluation has to be. </br>
		 * If it isn't, the function will return. </br>
		 * Your first call to AlphaBeta will be with an interval -INFINITY...INFINITY; </br>
		 * subsequent recursive calls to the function will make the window smaller. </br>
		 * 
		 * @param position the piece's postion in board.
		 * @param depth the piece's depth in this game tree.
		 * @param alpha INFINITY.
		 * @param beta -INFINITY.
		 * @see http://www.fierz.ch/strategy.htm
		 * 
		 */		
		public function AlphaBeta(gamePosition:PositionVO,depth:int=1,alpha:int=int.MIN_VALUE,beta:int=int.MAX_VALUE)
		{
			//
			this.depth = depth;
			this.alpha = alpha;
			this.beta = beta;
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
			alphaBeta(gamePosition,depth,alpha,beta);
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
		//pseudo-code here.
		/*int alphabeta(POSITION *p, int depth, int alpha, int beta)
		{
		MOVE list[MAXMOVES];
		int i,n,value,localalpha=alpha,bestvalue=-INFINITY;
		
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
		value = -alphabeta(p,d-1,-beta,-localalpha);
		undomove(&list[i],p);
		bestvalue = max(value,bestvalue);
		if(bestvalue>=beta) 
		break;
		if(bestvalue>localalpha) 
		localalpha=bestvalue;
		}
		return bestvalue;
		}*/
		private function alphaBeta(gamePosition:PositionVO,depth:int,alpha:int,beta:int):int
		{
			LOG.debug("depth:{0}",depth.toString());
			//
			bestValue = int.MIN_VALUE;
			localAlpha = alpha;
			//
			if(lookup(gamePosition,depth,alpha,beta,hashValue))
			{
				return hashValue;
			}
			//
			if(willNoneMove(gamePosition))
			{
				return int.MIN_VALUE;
			}
			//
			if(0==depth)
			{
				return doEvaluation(tempMove,gamePosition);
			}
			//
			if(0==orderingMoves.length)
			{
				return noneMove();
			}
			//
			var len:int = orderingMoves.length;
			LOG.debug("orderingMoves.length:{0}",len);
			//
			for(var i:int=0;i<len;i++)
			{
				LOG.debug("current orderingMoves.step:{0}",i.toString());
				makeMove(tempMove);
				tempValue = -alphaBeta(gamePosition,depth-1,-beta,-localAlpha);
				unmakeMove(tempMove);
				bestValue = Math.max(tempValue,bestValue);
				//
				if(bestValue>beta)
				{
					break;
				}
				if(bestValue>localAlpha)
				{
					localAlpha = bestValue;
				}
			}
			//
			store(gamePosition,depth,bestValue,alpha,beta);
			//
			LOG.debug("bestValue:{0}",bestValue.toString());
			return bestValue;
		}
		//
		/**
		 * The lookup function returns true if it finds the position in the hash table 
		 * and the value in the hash table can be returned immediately. </br>
		 * Lookup() might also encounter a lower value in the hashtable that is larger than alpha.</br> 
		 * In this case, the current alpha can immediately be set to the hashvalue. </br>
		 * For this reason, I pass alpha and beta by reference to lookup(), 
		 * so lookup() can modify their values.  </br>
		 * 
		 * @param gamePosition the full board game position info.
		 * @param depth the searching node depth value.
		 * @param alpha the reference of alpha value.
		 * @param beta the reference of beta value.
		 * @param hashValue the reference of hashValue.
		 * 
		 * @return a nonzero value, we have some information available on the position.
		 * 
		 */		
		private function lookup(gamePosition:PositionVO,depth:int,alpha:int,beta:int,hashValue:int):int
		{
			//TODO:
			return 0;
		}
		//
		private function store(gamePosition:PositionVO,depth:int,bestValue:int,alpha:int,beta:int):void
		{
			//TODO:
		}
	}
}