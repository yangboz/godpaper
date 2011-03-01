package com.lookbackon.AI.searching
{
	public class SE
	{
		/**
		 * Singular extensions 
		 * Singular extensions (SE) got their 15 minutes of fame when they were used by the Deep Blue team 
		 * which won it's chess match against world champion Garry Kasparov.
		 * Since then, SE seems to have been abandoned by most. The idea of singular extensions is appealing, 
		 * and what makes it so appealing is that it is game-independent: 
		 * Many ideas on how to improve tree search depend heavily on the game, and therefore lack generality. 
		 * Singular extensions in theory work for all games. 
		 * As the name says, SE is about extensions. Up to now, I have avoided this topic, 
		 * but it is important: The AlphaBeta function I have shown searches a game tree to a fixed depth. 
		 * However, many lines of play are just stupid, while others are more interesting. 
		 * The aim of SE is to catch some of the more interesting lines, 
		 * and to search them deeper than the rest. It relies on detecting forced moves for one side, 
		 * and on extending the search depth in the case of forced moves. 
		 * Humans play chess like this, and can solve long variations which are forced easily. 
		 * SE tries to emulate this behavior.
		 * @see http://www.fierz.ch/strategy.htm
		 *  
		 * */		
		public function SE(){}
	}
}