package com.lookbackon.AI.evaluation.factors
{
	/*
	This is a rather minor tweak to the draw evaluation of a position. It is used to avoid easy draws.
	
	It simply subtracts a certain constant from the draw evaluation, so instead of returning 0 if a position is repeated it could return -50, this way the engine avoids taking the draw unless it is down with more than 50 points.
	
	In Mediocre I added a check at the beginning of the search deciding what phase of the game we are in (opening, middle game or ending). Like this:
	
	int gamePhase = Evaluation.getGamePhase(board);
	
	if(gamePhase == PHASE_OPENING)
	contemptFactor = CONTEMPT_OPENING;
	else if(gamePhase == PHASE_ENDING)
	contemptFactor = CONTEMPT_ENDING;
	else
	contemptFactor = CONTEMPT_MIDDLE;
	The game phase is decided by how many pieces both sides have left.
	
	For now I have set the different contempt values to 50 for opening, 25 for middle game and 0 for ending. And when a draw is found I simply add the contempt factor to the draw value like this:
	
	return -(DRAW_VALUE + contemptFactor);
	This way the draw value will be worse depending on what phase we are in.
	
	This does not affect the playing strength of the program (if done right), but avoids some useless draws. 
	*/
	/**
	 * @see http://mediocrechess.varten.org/guides/see.html
	 * @author Knight.zhou
	 */	
	public class ContemptFactor
	{
		public static const CONTEMPT_OPENING:int	= 50;
		public static const CONTEMPT_MIDDLE:int 	= 25;
		public static const CONTEMPT_ENDING:int 	= 0;
	}
}