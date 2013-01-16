package com.lookbackon.AI.searching
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.model.vos.PositionVO;
	import com.godpaper.as3.utils.LogUtil;
	
	import de.polygonal.ds.Array2;
	
	import mx.logging.ILogger;

	public class Quiescence extends SearchingBase
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(Quiescence);
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
		 * <b>Quiescence search</b></br> 
		 * As I just said above, the basic search algorithm I presented always goes to a fixed depth.</br>  
		 * However, it may often not be a good idea to evaluate a position if it is too chaotic. </br> 
		 * Exactly what too chaotic might mean depends on the game. </br> 
		 * A simple example in chess is a position where white to move is a rook down but can promote a pawn to a queen, </br> 
		 * winning the game. If we were to call our static evaluation function in this position, </br> 
		 * it would (unless it was smart, which evaluation functions usually aren't) conclude that white is dead lost, </br> 
		 * a rook down. Therefore, a technique called quiescence search is often used: Once you want to call your evaluation function, </br> 
		 * you take a look at very few select moves that need to be checked further. </br> 
		 * You have to make sure that you are very restrictive in your quiescence search, 
		 * otherwise your search tree will explode completely. </br> 
		 * 
		 * 
		 * <b>静态搜索</b></br>
		 *　  在国际象棋或其他棋类中，有吃子和不吃子的着法(西洋跳棋、围棋、Fanorano等)，如果有吃子的情况，那么每次吃子时评价都会改变。
		 *  “静态搜索”(Quiescence Search)的思想是，到达主搜索的水平线后，用一个图灵型的搜索只展开吃子(有时是吃子加将军)的着法。
		 *  其他棋类不同于国际象棋，可能只包括一些会很大程度上改变评价的着法。静态搜索还必须包括放弃的着法，来决定停止吃子。
		 *  因此，主Alpha-Beta搜索中每个调用评价函数的地方，都会被一个类似Alpha-Beta的但只搜索吃子着法的函数代替，
		 *  如果当前结点的评价函数足以高出边界，那么就让搜索停下来。
		 *　有人还把将军加入到静态搜索中，但是你要当心，由于没有深度参数，静态搜索会有巨大的结点数。
		 *  吃子通常是有限的(在棋子全部吃完以前你只能有16次子)，而将军可以一直进行下去并导致无限制递归。
		 * 【对于是否展开将军着法的问题，可以尝试一种做法，如果局面被将军，就展开全部着法，即做应将处理，而不对当前局面作评价，参阅“静态搜索”一文。】 
		 * 
		 * @see http://www.fierz.ch/strategy.htm
		 * @see http://chessprogramming.wikispaces.com/Quiescence+Search
		 * @author Knight.zhou
		 * */			
		public function Quiescence(gamePosition:PositionVO,alpha:int=int.MIN_VALUE,beta:int=int.MAX_VALUE)
		{
			//init.
			this.alpha = alpha;
			this.beta = beta;
			//
			super(gamePosition);
			//
			this.tempCapture = this.captures[0];
		}
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		override public function run():void
		{
			quiesence(alpha,beta);
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
		//pesudo-code here.
		/*int Quiesce( int alpha, int beta ) {
		int stand_pat = Evaluate();
		if( stand_pat >= beta )
		return beta;
		if( alpha < stand_pat )
		alpha = stand_pat;
		
		until( every_capture_has_been_examined )  {
		MakeCapture();
		score = -Quiesce( -beta, -alpha );
		TakeBackMove();
		
		if( score >= beta )
		return beta;
		if( score > alpha )
		alpha = score;
		}
		return alpha;
		}*/
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
					LOG.debug("beta:{0},bestMove:{1}",beta.toString(),bestMove.dump());
					return beta;
				}
				if(score>alpha)
				{
					alpha = score;
				}
			}
			bestMove = tempCapture;
			LOG.debug("alpha:{0},bestMove:{1}",alpha.toString(),bestMove.dump());
			return alpha;
		}
	}
}