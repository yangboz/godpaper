package com.godpaper.as3.consts
{
	import com.godpaper.as3.utils.Enum;
	
	import de.polygonal.math.PM_PRNG;

	/**
	 * <b>Summary description for ZC(ZobristConstants).</b></p>
	 * In breakthrough, </p>
	 * the transposition table proven to be very effective for detecting duplicate positions 
	 * and as well for Iterative Deepening (re-search is almost done instantaneously).</p>
	 * Zobrist hashing was used in the algorithm in order to create the transposition table. </p>
	 * According to original research, the better are the random generated numbers, 
	 * the better would be the actual distribution and the collisions could be avoided.  </p>
	 * Since the engine was build in C# which offers a way to generate pseudo-random numbers.  </p>
	 * Pseudo-random numbers are chosen with equal probability from a finite set of numbers. </p>
	 * The chosen numbers are not completely random because a definite mathematical algorithm 
	 * is used to select them, but they are sufficiently random for practical purposes.</p>
	 * However, to ensure better quality of random numbers distribution, 
	 * the Zobrist hashing was enhanced with the Mersenne Twister pseudo-random number generator, 
	 * developed in 1997 by Makoto Matsumoto and Takuji Nishimura that 
	 * is based on a matrix linear recurrence over a finite binary field. </p>
	 * It provides for fast generation of very high-quality pseudorandom numbers, 
	 * having been designed specifically to rectify many of the flaws found in older algorithms. </p>
	 * It is designed with consideration on the flaws of various existing generators.  </p>
	 * 
	 * @author knight.zhou
	 * 
	 */	
	final public class ZobristConstants extends Enum
	{
		{initEnum(ZobristConstants);}//static construct.
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		//blue(at top)
		public static const BLUE_PAWN:ZobristConstants 		= new ZobristConstants();//pawn-
		public static const BLUE_ROOK:ZobristConstants 		= new ZobristConstants();//castle-
		public static const BLUE_KNIGHT:ZobristConstants	= new ZobristConstants();//knight-
		public static const BLUE_BISHOP:ZobristConstants	= new ZobristConstants();//bishop-
		public static const BLUE_OFFICAL:ZobristConstants 	= new ZobristConstants();//offcial-
		public static const BLUE_MARSHAL:ZobristConstants	= new ZobristConstants();//marshal-
		public static const BLUE_CANNON:ZobristConstants	= new ZobristConstants();//cannon-
		//red(at bottom)
		public static const RED_PAWN:ZobristConstants 		= new ZobristConstants();//pawn+
		public static const RED_ROOK:ZobristConstants 		= new ZobristConstants();//castle+
		public static const RED_KNIGHT:ZobristConstants		= new ZobristConstants();//knight+
		public static const RED_BISHOP:ZobristConstants		= new ZobristConstants();//bishop+
		public static const RED_OFFICAL:ZobristConstants 	= new ZobristConstants();//offcial+
		public static const RED_MARSHAL:ZobristConstants	= new ZobristConstants();//marshal+
		public static const RED_CANNON:ZobristConstants		= new ZobristConstants();//cannon+
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public var color:int;//chess colour
		public var type:int;//chess type.
		public var position:int;//chess position.
		public var key:int;//zobrist hash table key.
		public function ZobristConstants()
		{
			//TODO: implement function 
			var pmPRNG:PM_PRNG = new PM_PRNG();
			this.key = pmPRNG.nextInt();
			this.type = pmPRNG.nextInt();
			this.color = pmPRNG.nextInt();
			this.position = pmPRNG.nextInt();
		}
		
	}
}