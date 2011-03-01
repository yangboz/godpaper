package com.lookbackon.AI.searching
{
	public class DR
	{
		/**
		 * Depth reductions 
		 * Pruning in general is a way of deciding to reduce the search depth of the current line. 
		 * There are many ways in which you can do this, and some of them are game specific (see below). 
		 * Others are of a more general nature. The whole idea comes from the fact that most of the lines your program is looking at are absolutely ridiculous. 
		 * Now, if we could only get rid of these ridiculous lines and look at the important ones instead... 
		 * One very general pruning technique that is nearly guaranteed to work in most games is Michael Buro's ProbCut algorithm (and variants thereof): 
		 * In ProbCut, you decide to search less deeply at some fixed remaining depth, 
		 * e.g. when there are 8 ply remaining. Instead, you decide to search only 4 ply. 
		 * Now, if this search returns a value far outside of your alpha-beta window you decide to believe the shallow search and return the result. 
		 * If it's not too far outside of the alpha-beta window, or even inside it, you have to re-search to the full depth. 
		 * There are a lot of constants you can tune in this algorithm, and you will have to experiment with it to get it up to full strength. 
		 * It was used by Buro himself in his world-class Othello program Logistello, and I once implemented a version of Multi-ProbCut in my checkers program Cake. 
		 * It worked much better than plain alphabeta, but not as well as my game-specific pruning algorithm. 
		 * Nevertheless, ProbCut is highly interesting since it doesn't depend on the game you are playing. 
		 * To me it's no surprise that it is outperformed by reduction algorithms which know something about the game - after all, 
		 * these have some knowledge advantage! 
		 * @see http://www.fierz.ch/strategy.htm
		 */		
		public function DR(){}
	}
}