package com.lookbackon.AI.searching
{
	public class Windowing
	{
		/**
		 * Windowing is the simplest of the following techniques.
		 * In an iterative deepening framework, we always have a value of the previous iteration.
		 * Therefore, we try to reduce the search effort by using a smaller alpha-beta window. 
		 * Instead of using -INFINITY...+INFINITY we can use an interval lastvalue-WINDOW...lastvalue+WINDOW. 
		 * If the true MiniMax value at this iteration is really inside this window, 
		 * we will just need to search fewer nodes than with the larger window. 
		 * On the other hand, 
		 * our guess that the true value is inside this window might also be wrong. 
		 * In this case, we will get a fail-high or a fail-low. In this case, 
		 * we will have to do a re-search with a larger window. '
		 * @see http://www.fierz.ch/strategy.htm
		 */		
		public function Windowing(){}
	}
}