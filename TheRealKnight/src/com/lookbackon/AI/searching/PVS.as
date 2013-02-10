package com.lookbackon.AI.searching
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.model.vos.PositionVO;
	import com.godpaper.as3.utils.LogUtil;
	
	import mx.logging.ILogger;
	
	/**
	 * PVS.as class. 
	 * <b>Principal variation searching</b></br> 
	 * Windowing is simple and it is quite good. </br> 
	 * However, windowing is restricted to the root node. </br> 
	 * PVS tries to go a bit further by making assumptions on the alpha-beta window at every node. </br> 
	 * Here's the basic idea: Since we have gone to a lot of trouble with our move ordering schemes above,
	 * we can be pretty confident that we will find the best move early on. </br> 
	 * Therefore, our localalpha will be at its maximal value after the first few moves.</br> 
	 * PVS tries to exploit this by calling the next recursion of AlphaBeta 
	 * with different parameters than standard-AlphaBeta. </br> 
	 * AlphaBeta would use alpha and beta. In PVS however, 
	 * we already guess that our current localalpha will be better than 
	 * what we will get with the remaining moves. </br> 
	 * Therefore we set alpha to localalpha and beta to localalpha+1, 
	 * that is, we use a call value=-alphabeta(p,d-1,-(localalpha+1),-localalpha);</br> 
	 * We expect this call to fail low, because we believe that we have already found the best move. </br> 
	 * If this call does not fail low, 
	 * we need to revise our assumption and call AlphaBeta again with the normal alpha and beta bounds.</br> 
	 * PVS is also often called NegaScout. </br> 
	 * It gets its name from the scout search which a minimal window,
	 * which sort of probes the territory to see whether a real search is necessary. </br> 
	 * @see http://www.fierz.ch/strategy.htm
	 * 
	 * @author Knight.zhou
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jul 13, 2010 9:52:23 AM
	 */   	 
	public class PVS extends SearchingBase
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var bSearchPvs:Boolean = true;
		private var score:int;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(PVS);
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
		public function PVS(gamePosition:PositionVO,alpha:int=int.MIN_VALUE,beta:int=int.MAX_VALUE,depth:int=2)
		{
			//
			this.alpha = alpha;
			this.beta = beta;
			this.depth = depth;
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
			//TODO:
			pvSearch(alpha,beta,depth);
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
		//pseudo-code.
		/*
		int pvSearch( int alpha, int beta, int depth ) {
		if( depth == 0 ) return quiesce( alpha, beta );
		bool bSearchPv = true;
		for ( all moves)  {
		make
		if ( bSearchPv ) {
		score = -pvSearch(-beta, -alpha, depth - 1);
		} else {
		score = -pvSearch(-alpha-1, -alpha, depth - 1);
		if ( score > alpha ) // in fail-soft ... && score < beta ) is common
		score = -pvSearch(-beta, -alpha, depth - 1); // re-search
		}
		unmake
		if( score >= beta )
		return beta;   // fail-hard beta cutoff
		if( score > alpha ) {
		alpha = score; // alpha acts like max in MiniMax
		bSearchPv = false;  // *1)
		}
		}
		return alpha; // fail-hard
		}*/
		private function pvSearch(alpha:int,beta:int,depth:int):int
		{
			if(0==depth)
			{
				return quiesence(alpha,beta);
			}
			for(var i:int=0;i<orderingMoves.length;i++)
			{
				makeMove(tempMove);
				if(bSearchPvs)
				{
					score = -pvSearch(-beta,-alpha,depth-1);
				}else
				{
					score = -pvSearch(-alpha-1,-alpha,depth-1);
				}
				if(score>alpha)//in fail-soft.
				{
					score = -pvSearch(-beta,-alpha,depth-1);//re-search.
				}
				unmakeMove(tempMove);
				if(score>=beta)
				{
					//
					bestMove = tempMove;
					LOG.debug("beta:{0},bestMove:{1}",beta.toString(),bestMove.dump());
					return beta;//fail-hard beta cutoff.
				}
				if(score>alpha)
				{
					alpha = score;//alpha acts like max in MiniMax.
					bSearchPvs = false;
				}
			}
			//
			bestMove = tempMove;
			LOG.debug("alpha:{0},bestMove:{1}",alpha.toString(),bestMove.dump());
			return alpha;//fail-hard.
		}
		
		private function quiesence(alpha:int, beta:int):int
		{
			//standPat:@see http://chessprogramming.wikispaces.com/Quiescence+Search
			var standPat:int = doEvaluation(tempMove,gamePosition);
			if(standPat>=beta)
			{
				return beta;
			}
			if(alpha<standPat)
			{
				alpha = standPat;
			}
			//MakeCapture;
			for(var i:int=0;i<captures.length;i++)
			{
				tempCapture = captures[i];
				//
				makeMove(tempCapture);
				var score:int = -quiesence(-beta,-alpha);
				unmakeMove(tempCapture);
				if(score>=beta)
				{
					bestMove = tempCapture;
					LOG.debug("quiescene beta:{0},bestMove:{1}",beta.toString(),bestMove.dump());
					return beta;
				}
				if(score>alpha)
				{
					alpha = score;
				}
			}
			bestMove = tempCapture;
			LOG.debug("quiescene alpha:{0},bestMove:{1}",alpha.toString(),bestMove.dump());
			return alpha;
		}
		
	}
	
}