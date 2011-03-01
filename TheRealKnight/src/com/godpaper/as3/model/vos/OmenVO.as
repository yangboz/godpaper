package com.godpaper.as3.model.vos
{
	import com.godpaper.as3.configs.BoardConfig;

	import de.polygonal.ds.Array2;

	/**
	 * The evaluation of a position in Chinese chess has approximately five elements: </br>
	 * (1) the strength of the pieces in play, </br>
	 * (2) the important positions, </br>
	 * (3) the flexibility of the pieces, </br>
	 * (4) the threats between pieces and the protection of pieces from threats, </br>
	 * (5) a dynamic adjustment according to the situation (Hsu, 1990). </br>
	 * Details of those elements are discussed below.</br>
	 * @see 2004CCJ.pdf
	 * @author RoYan,Knight.zhou
	 */
	public class OmenVO
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
//		public var threat:int = 0;		//The number of pieces this piece can kill, now point;
//		public var threaten:int = 0;	//The number of pieces which can kill this piece, now point.

//		public var newThreat:int = 0;	//The number of pieces this piece can kill, new point;
//		public var newThreaten:int = 0;//The number of pieces which can kill this piece, new point;

//		public var killed:int = 0;		//The number of pieces was killed by this piece.
//		public var moved:int;			//The times of this piece was moved;

		//Calculating the strength of the pieces is the simplest method to measure the current board status. Since
		//different kinds of pieces have different attacking power and defensive power, their values are different. The
		//King is the most important piece. Its value is much larger than the total power of all other pieces. The values of
		//the other pieces are determined by heuristic rules. The power of one Rook is similar to one Horse plus one
		//Cannon. The power of one Horse is similar to two Elephants. Based on these heuristic rules, ELP gives the
		//following values to pieces (see Table 5).
		//Piece: King Assistant Elephant Rook Horse Cannon Pawn
		//Value: 6000 120 		120 	 600  270    285    30
		public var strength:int = 0;
		//Except of the summed values of the pieces, the position of each piece is very important. 
		//The place that can be occupied to threaten the enemy King is the best place. 
		//Since each kind of piece has a different way of movement, 
		//most programs are equipped with a table that stores the estimated importance of possible positions for each piece. 
		//The position value tables of the Rook, Horse, Cannon, and Pawn are given in the Figures 4 to 7.
		//14 14 12 18 16 18 12 14 14
		//16 20 18 24 26 24 18 20 16
		//12 12 12 18 18 18 12 12 12
		//12 18 16 22 22 22 16 18 12
		//12 14 12 18 18 18 12 14 12
		//12 16 14 20 20 20 14 16 12
		//6 10 8 14 14 14 8 10 6 2 6
		//4 8 6 14 12 14 6 8 4 4 2 8
		//8 4 8 16 8 16 8 4 8 0 2 4 
		//-2 10 6 14 12 14 6 10 -2 0 
		//Figure 4: Position values of a Rook.
		public var important:Array2;
		//If a piece could move freely, its attacking power is restricted. 
		//The possible positions of a piece except for the
		//Cannons give the attacking range. 
		//The more flexible the piece is, the more attacking power it has. 
		//But estimating the flexibility of all pieces costs too much, 
		//ELP only considers the flexibility of Horses.
		public var flexibility:int = 0;
		//The number and kind of protectors and threatening enemies determine the security of a piece.
		//A simple way to estimate the security is using a data structure 
		//to record the protecting and threatening relationships between pieces 
		//and following the killing principle to switch pieces. 
		//This method is fast, but prone to making wrong decisions. 
		//ELP uses quiescent search on terminal nodes until it reaches a static condition. 
		//This takes a great deal of computation time but leads to rather few wrong decisions.
		public var threat:int=0;
		//Dynamic adjustment uses the technique of pattern recognition
		//to adjust dynamically the current values of pieces and the position-power table. 
		//In Figure 8, the Cannon positions c0, c1,c2, e0, e1 and e2 
		//could threaten the enemy King or Horse indirectly such that these positions are adjusted 
		//as the optimal positions of the Cannon.
		//When the enemy moves the King or Horse, the status of these positions have to be re-adjusted.
		public var adjustment:int=0;
		//--------------------------------------------------------------------------
		//
		//  Construct
		//
		//--------------------------------------------------------------------------
		public function OmenVO(strength:int,important:Array2,flexibility:int,threat:int,adjustment:int)
		{
			important = new Array2(BoardConfig.xLines,BoardConfig.yLines);
			//
			this.strength = strength;
			this.important = important;
			this.flexibility = flexibility;
			this.threat = threat;
			this.adjustment = adjustment;
		}
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		/**
		 * Prints out all elements (for debug/demo purposes).
		 *
		 * @return A human-readable representation of the structure.
		 */
		public function dump():String
		{
			var s:String = "OmenVO";
			s += "\n{";
			s += "\n" + "\t";
			s += "strength:"+strength.toString()
				+","+"important:"+important.dump()
				+","+"flexibility:"+flexibility.toString()
				+","+"threat:"+threat.toString()
				+","+"adjustment:"+adjustment.toString();
			s += "\n}";
			return s;
		}

	}
}

