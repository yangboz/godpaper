package com.lookbackon.AI.searching
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.model.vos.PositionVO;
	
	
	/**
	 * NegaSout.as class.  
	 * <b>NegaScout</b> is an Alpha-Beta enhancement and improvement of Judea Pearl's  Scout-algorithm [1],
	 * introduced by Alexander Reinefeld in 1983 [2][3]. </br>
	 * The improvements rely on a Negamax framework and some fail-soft issues concerning the two last plies, 
	 * which did not require any re-searches. </br>
	 * @see http://chessprogramming.wikispaces.com/NegaScout
	 * @author Knight.zhou
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jul 13, 2010 4:18:16 PM
	 */   	 
	public class NegaScout extends SearchingBase
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		
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
		public function NegaScout(gamePosition:PositionVO,alpha:int,beta:int)
		{
			//
			this.alpha = alpha;
			this.beta = beta;
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
			negaScout(gamePosition,alpha,beta);
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
		//int NegaScout ( position p; int alpha, beta )
		//{                     /* compute minimax value of position p */
		//	int b, t, i;
		//	if ( d == maxdepth )
		//		return quiesce(p, alpha, beta);           /* leaf node */
		//	determine successors p_1,...,p_w of p;
		//	b = beta;
		//	for ( i = 1; i <= w; i++ ) {
		//		t = -NegaScout ( p_i, -b, -alpha );
		//		if ( (t > a) && (t < beta) && (i > 1) )
		//			t = -NegaScout ( p_i, -beta, -alpha ); /* re-search */
		//		alpha = max( alpha, t );
		//		if ( alpha >= beta )
		//			return alpha;                            /* cut-off */
		//		b = alpha + 1;                  /* set new null window */
		//	}
		//	return alpha;
		//}
		private function negaScout(gamePosition:PositionVO,alpha:int,beta:int):int
		{
			//TODO:
			return -1;
		}
	}
	
}