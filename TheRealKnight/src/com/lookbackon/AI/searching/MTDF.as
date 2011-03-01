package com.lookbackon.AI.searching
{
	import de.polygonal.ds.Array2;

	public class MTDF
	{
		/**
		 * MTD(f) is another clever trick which uses AlphaBeta's property of returning boundaries on the true MiniMax value.</br>
		 * MTD(f) makes a few calls to AlphaBeta with changing windows to get the true value of the position. </br>
		 * Each time it gets either a lower or an upper bound on the current position's value. </br>
		 * These bounds converge toward the true MiniMax value.</br>
		 * MTD(f) gets a 'firstguess' value from the last iterative deepening stage. </br>
		 * By zooming in on the true MiniMax value with its minimal window calls, </br>
		 * it arrives at the same result as a normal AlphaBeta search, </br>
		 * but generally uses less nodes to find this value. </br>
		 * I read that for MTD to work, you have to store both upper and lower bounds in your hashtable 
		 * instead of just one value and bound type. </br>
		 * The idea is that MTD will often re-search a position with a different alpha-beta window, </br>
		 * and it would be a shame to forget results of earlier searches - which would happen 
		 * if you were to overwrite the stored information that a position has a upper bound of 100 
		 * with the information that it also has a lower bound of 90. </br>
		 * @param position
		 * @param firstGuess
		 * @param depth
		 * @see http://www.fierz.ch/strategy.htm
		 */		
		public function MTDF(position:Array2,firstGuess:int,depth:int)
		{
			/*
			int mtdf(struct position p, int firstguess,int depth)
			{
			int g,lowerbound, upperbound,beta;
			g=firstguess;
			upperbound=INFINITY;
			lowerbound=-INFINITY;
			while(lowerbound<upperbound)
				{
				if(g==lowerbound)
					beta=g+1;
				else beta=g;
				g=alphabeta(p,depth,beta-1,beta);
				if(g<beta)
					upperbound=g;
				else
					lowerbound=g;
				}
			return g;
			}*/
		
		}
	}
}