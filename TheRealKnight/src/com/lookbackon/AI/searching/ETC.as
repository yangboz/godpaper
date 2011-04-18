package com.lookbackon.AI.searching
{
	public class ETC
	{
		/**
		 * Enhanced transposition cutoffs
		 * ETC is a cute idea: in a normal AlphaBeta search with a hashtable, 
		 * you will be searching through all possible moves, and for every move you make, 
		 * you do a hashtable lookup to see if you can return immediately. 
		 * ETC takes this idea one step further: Before doing your recursive AlphaBeta call, 
		 * you look up all possible successor positions of the current position. 
		 * If you get a hashtable hit on one of these calls which gives you a return value > beta, 
		 * you can immediately return without a search. 
		 * The reason ETC helps is that in the normal AlphaBeta case, 
		 * you generate a movelist, and let's assume that move number 5 would lead to a hashtable hit leading to a cutoff. 
		 * Nevertheless, in the normal AlphaBeta framework, 
		 * you will have to search through moves number 1 - 4, 
		 * and only then do you find that move number 5 gives you a cutoff. 
		 * This search is made unnecessary with the ETC lookup. 
		 * @see http://www.fierz.ch/strategy.htm
		 */		
		public function ETC(){}
	}
}