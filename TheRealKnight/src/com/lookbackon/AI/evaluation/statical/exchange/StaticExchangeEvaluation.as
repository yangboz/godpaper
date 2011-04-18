package com.lookbackon.AI.evaluation.statical.exchange
{
	import com.lookbackon.AI.evaluation.IEvaluation;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.model.vos.PositionVO;

	/*
	Static exchange evaluation is a very powerful tool for evaluating a capture without actually playing out the moves.
	
	It is mainly used for sorting quiescent (and ordinary) moves which produces far better results than the MVV/LVA scheme.
	
	The implementation is very code specific, meaning there are not many general rules that apply, we simply have to find a fast way of determining if a capture gains or loses material once all the moves in the sequence has been played out.
	
	To fully understand how it is done in Mediocre you might want to take a look at the source code in See.java which is not very long but heavily commented, I will try to give the general idea here though.
	
	General outline
	
	The see() method takes a move we want to check. This move is done by the initial attacker. For example Qxb6 in the diagram. It then returns a value for what this move is worth. If B6 contains an undefended pawn the value would be +100. However if the pawn is defended one time and there are no more attackers (like here) the value would be -800 (-900 for the queen +100 for the pawn).
	
	I will use this queen and pawn capture sequence as an example when explaining other things below.
	
	What we want to do is simply find all attackers, let them capture alternately on the square starting with the lowest valued piece, keep track of what pieces capture and finally find the best possible results of the capture sequence.
	
	I have divided it into a few steps.
	
	Step 1: Finding the obvious attackers
	
	We start with finding the 'obvious' attackers to the square. Meaning pieces that directly attack it. If there are two rooks on the same file for example only the first rook is directly attacking the square, the second is indirectly attacking it and this will be handled later.
	
	The initial attacker is not added here but handled separately.
	
	We do this in the fastest possible way, for example we do not loop over all the pawns for each side, we simply check squares where a possible pawn could attack from, and if it contains a pawn of the right color we add it.
	
	This is the general approach throughout the code. Instead of taking a piece and see if it can attack the square, we take the square and see if a delta runs in to a piece of the right type.
	
	In the diagram you can see how we check for attacking pieces in the different deltas, red for straight, green for diagonal and orange for knight. Since the queen is the initial attacker it will not be added but handled separately as already mentioned, however the black pawn will.
	
	When this is done we have two arrays, w_attackers and b_attackers, filled with all the obvious attackers of the two sides.
	
	Step 2: Simulate the inital capture
	
	We now simulate the inital capture. This is done like this:
	
	score = piece_values[Move.capture(move)+7];
	attacked_piece_value = piece_values[(Move.pieceMoving(move))+7];
	sideToMove = board.toMove*-1;
	The piece_values array simply contains the piece values (with an offset of 7 since black pieces have negative indexes).
	
	So what was done was setting 'score' to the piece that was initally standing on the square (a pawn in the example, so score would now be 1), setting attacked_piece_value to 9 (for the queen) and 'switching' the side to move.
	
	Keep in mind that we do not actually carry out this on the board, we simply simulate it. 'sideToMove' is just an internal integer that keeps track of what side to simulate next.
	
	The attacked_piece_value keeps track of what piece is currently 'standing' on the square. In this case it is 9 since the white queen 'moved' there by capturing.
	
	Finally we update the first index in the scores-array (not same as the score integer) with the score. After the capture sequence this array will be filled with alternating white and black piece values.
	
	Step 3: Adding hidden pieces
	
	Now that the queen was 'moved', we need to check for any pieces that might have been 'hiding' behind it, and hence attacking the square indirectly.
	
	We do this by using the delta the queen moved with (that is by rook delta), and starting from the square the queen stood at we move away from the attacked square.
	
	If we run into to a rook or queen while moving in this direction (since those are the two that can use the delta) we can add it to the attackers. If we run into any other piece, or move off the board, no attackers were hiding behind the queen.
	
	You can see how this is done in the diagram.
	
	The same is done for the other pieces, except for kings and knights. No piece can be hiding behind a knight (think about it), and pieces hiding behind kings are futile since if it is a piece of opposite color it would just catch the king and win the game, and if it is a piece of the same color it will never be able to reach the square since that would mean some other piece captured the king first in the sequence.
	
	Step 4: Playing out the sequence
	
	Now we simulate captures on the square, alternating between white and black, always capturing with the least valuable piece first. And updating the scores-array as we go along like this:
	
	scores[scoresIndex] =
	attacked_piece_value - scores[scoresIndex - 1];
	scoresIndex++;
	After every capture we attempt to add a hidden attacker.
	
	Once we run out of attackers of either side the sequence is done and we stop.
	
	So in our example we start out with the scores[0]=1 from the captured pawn, and on the next pass we add 8 (=9-1) to scores[1], and then we stop since white ran out of attackers.
	
	Step 5: Evaluating the sequence
	
	Now the scores-array is filled with piece values so we can extract the value of the sequence.
	
	It is done like this:
	
	while(scoresIndex > 1)
	{
	scoresIndex--;
	if(scores[scoresIndex-1] > -scores[scoresIndex])
	{
	scores[scoresIndex-1] = -scores[scoresIndex];
	}
	}
	return scores[0]*100;
	In our example the scores-array would look like this {1,8}.
	
	So scoresIndex would start at 2.
	
	We decrement it to 1 and if scores[1-1] > -scores[1] (in our example 1>-8) we put the lower value in front.
	
	Since we only had two captures in our example we are done here. And can return the centipawn value of -800. Since the queen captured a pawn and then was captured itself.
	
	In conclusion
	
	As you can see the example would sort under 'losing captures'. Winning captures would get a positive score and equal captures would get '0'.
	
	It is hard to write a guide about something this code specific. But atleast I made an honest attempt. :) Hope it helped.
	
	On to explaining LMR.
	
	Edit: Added a few more images for better illustration 
	*/
	/**
	 * @see  http://mediocrechess.varten.org/guides/see.html
	 * @author Knight.zhou
	 * 
	 */	
	public class StaticExchangeEvaluation implements IEvaluation
	{
		public function StaticExchangeEvaluation()
		{
		}
		//implements
		public function doEvaluation(conductVO:ConductVO,gamePosition:PositionVO):int
		{
			//TODO.
			return -1;
		}
	}
}