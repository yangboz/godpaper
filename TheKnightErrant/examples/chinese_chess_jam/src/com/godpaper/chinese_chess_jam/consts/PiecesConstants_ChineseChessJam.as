package chinese_chess_jam.src.com.godpaper.chinese_chess_jam.consts
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.configs.BoardConfig;
	import com.godpaper.as3.utils.Enum;

	import de.polygonal.ds.Array2;


	/**
	 * <b>ChessPieces value/label global setting</b></p>
	 * 1.label for labeling chess pieces button;</p>
	 * 2.value for chess pieces' evaluation;</p>
	 * 3.strength for chess pieces' strength;</p>
	 * 4.important for chess pieces' important on board;</p>
	 * 5.convertImportant for the chess pieces' fuzzy import on board;</p>
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Feb 28, 2011 10:49:44 AM
	 */
	final public class PiecesConstants_ChineseChessJam extends Enum
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		//chessPieceType
		//blue(at top)
		public static const BLUE_PAWN:PiecesConstants_ChineseChessJam=new PiecesConstants_ChineseChessJam("p", 22, 30); //pawn-
		public static const BLUE_ROOK:PiecesConstants_ChineseChessJam=new PiecesConstants_ChineseChessJam("r", 20, 600); //castle-
		public static const BLUE_KNIGHT:PiecesConstants_ChineseChessJam=new PiecesConstants_ChineseChessJam("k", 19, 270); //knight-
		public static const BLUE_BISHOP:PiecesConstants_ChineseChessJam=new PiecesConstants_ChineseChessJam("b", 18, 120); //bishop-
		public static const BLUE_OFFICAL:PiecesConstants_ChineseChessJam=new PiecesConstants_ChineseChessJam("o", 16, 120); //offcial-
		public static const BLUE_MARSHAL:PiecesConstants_ChineseChessJam=new PiecesConstants_ChineseChessJam("m", 17, 6000); //marshal-
		public static const BLUE_CANNON:PiecesConstants_ChineseChessJam=new PiecesConstants_ChineseChessJam("c", 21, 285); //cannon-
		//red(at bottom)
		public static const RED_PAWN:PiecesConstants_ChineseChessJam=new PiecesConstants_ChineseChessJam("P", 14, 30); //pawn+
		public static const RED_ROOK:PiecesConstants_ChineseChessJam=new PiecesConstants_ChineseChessJam("R", 12, 600); //castle+
		public static const RED_KNIGHT:PiecesConstants_ChineseChessJam=new PiecesConstants_ChineseChessJam("K", 11, 270); //knight+
		public static const RED_BISHOP:PiecesConstants_ChineseChessJam=new PiecesConstants_ChineseChessJam("B", 10, 120); //bishop+
		public static const RED_OFFICAL:PiecesConstants_ChineseChessJam=new PiecesConstants_ChineseChessJam("O", 8, 120); //offcial+
		public static const RED_MARSHAL:PiecesConstants_ChineseChessJam=new PiecesConstants_ChineseChessJam("M", 9, 6000); //marshal+
		public static const RED_CANNON:PiecesConstants_ChineseChessJam=new PiecesConstants_ChineseChessJam("C", 13, 285); //cannon+
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
		public var label:String; //for labeling on chess pieces.
		public var value:int; //B. 8~14依次表示红方的帅、仕、相、马、车、炮和兵；
		//C. 16~22依次表示蓝方的将、士、象、马、车、炮和卒。
		public var strength:int; //Piece: King Assistant Elephant Rook Horse Cannon Pawn
		//Value: 6000 120 		120 	 600  270    285    30
		public var important:Array2; //precise value.
		//Worst: -4, much worse: -3, worse: -2, slightly worse: -1, even: 0, 
		//slightly better: 1, better:2, much better: 3, best: 4
		public var convertedImportant:Array2; //fuzzy value.

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function PiecesConstants_ChineseChessJam(label:String, value:int, strength:int=-1, important:Array2=null, convertedImportant:Array2=null)
		{
			//TODO: implement function
			this.label=label;
			this.value=value;
			this.strength=strength;
			this.important=new Array2(BoardConfig.xLines, BoardConfig.yLines);
			this.convertedImportant=new Array2(BoardConfig.xLines, BoardConfig.yLines);
			//TODO:manually set chess pieces' important,reference@2004ccc.pdf.
			switch (label)
			{
				case "R":
					//important
					this.important.setXs(0, [14, 14, 12, 18, 16, 18, 12, 14, 14]);
					this.important.setXs(1, [16, 20, 18, 24, 26, 24, 18, 20, 16]);
					this.important.setXs(2, [12, 12, 12, 18, 18, 18, 12, 12, 12]);
					this.important.setXs(3, [12, 18, 16, 22, 22, 22, 16, 18, 12]);
					this.important.setXs(4, [12, 14, 12, 18, 18, 18, 12, 14, 12]);
					this.important.setXs(5, [12, 16, 14, 20, 20, 20, 14, 16, 12]);
					this.important.setXs(6, [6, 10, 8, 14, 14, 14, 8, 10, 6]);
					this.important.setXs(7, [4, 8, 6, 14, 12, 14, 6, 8, 4]);
					this.important.setXs(8, [8, 4, 8, 16, 8, 16, 8, 4, 8]);
					this.important.setXs(9, [-2, 10, 6, 14, 12, 14, 6, 10, -2]);
					//convertedImportant
					this.convertedImportant.setXs(0, [3, 3, 2, 3, 3, 3, 2, 3, 3]);
					this.convertedImportant.setXs(1, [3, 4, 3, 4, 4, 4, 3, 4, 3]);
					this.convertedImportant.setXs(2, [2, 2, 2, 3, 3, 3, 2, 2, 2]);
					this.convertedImportant.setXs(3, [2, 3, 3, 4, 4, 4, 3, 3, 2]);
					this.convertedImportant.setXs(4, [2, 3, 2, 3, 3, 3, 2, 3, 2]);
					this.convertedImportant.setXs(5, [2, 3, 3, 4, 4, 4, 3, 3, 2]);
					this.convertedImportant.setXs(6, [2, 2, 2, 3, 3, 3, 2, 2, 2]);
					this.convertedImportant.setXs(7, [1, 2, 2, 3, 2, 3, 2, 2, 1]);
					this.convertedImportant.setXs(8, [2, 1, 2, 3, 2, 3, 2, 1, 2]);
					this.convertedImportant.setXs(9, [0, 2, 2, 3, 2, 3, 2, 2, 0]);
					break;
				case "r":
					//important
					this.important.setXs(9, [14, 14, 12, 18, 16, 18, 12, 14, 14]);
					this.important.setXs(8, [16, 20, 18, 24, 26, 24, 18, 20, 16]);
					this.important.setXs(7, [12, 12, 12, 18, 18, 18, 12, 12, 12]);
					this.important.setXs(6, [12, 18, 16, 22, 22, 22, 16, 18, 12]);
					this.important.setXs(5, [12, 14, 12, 18, 18, 18, 12, 14, 12]);
					this.important.setXs(4, [12, 16, 14, 20, 20, 20, 14, 16, 12]);
					this.important.setXs(3, [6, 10, 8, 14, 14, 14, 8, 10, 6]);
					this.important.setXs(2, [4, 8, 6, 14, 12, 14, 6, 8, 4]);
					this.important.setXs(1, [8, 4, 8, 16, 8, 16, 8, 4, 8]);
					this.important.setXs(0, [-2, 10, 6, 14, 12, 14, 6, 10, -2]);
					//convertedImportant
					this.convertedImportant.setXs(9, [3, 3, 2, 3, 3, 3, 2, 3, 3]);
					this.convertedImportant.setXs(8, [3, 4, 3, 4, 4, 4, 3, 4, 3]);
					this.convertedImportant.setXs(7, [2, 2, 2, 3, 3, 3, 2, 2, 2]);
					this.convertedImportant.setXs(6, [2, 3, 3, 4, 4, 4, 3, 3, 2]);
					this.convertedImportant.setXs(5, [2, 3, 2, 3, 3, 3, 2, 3, 2]);
					this.convertedImportant.setXs(4, [2, 3, 3, 4, 4, 4, 3, 3, 2]);
					this.convertedImportant.setXs(3, [2, 2, 2, 3, 3, 3, 2, 2, 2]);
					this.convertedImportant.setXs(2, [1, 2, 2, 3, 2, 3, 2, 2, 1]);
					this.convertedImportant.setXs(1, [2, 1, 2, 3, 2, 3, 2, 1, 2]);
					this.convertedImportant.setXs(0, [0, 2, 2, 3, 2, 3, 2, 2, 0]);
					break;
				case "K":
					//important
					this.important.setXs(0, [4, 8, 16, 12, 4, 12, 16, 8, 4]);
					this.important.setXs(1, [4, 10, 28, 16, 8, 16, 28, 10, 4]);
					this.important.setXs(2, [12, 14, 16, 20, 18, 20, 16, 14, 12]);
					this.important.setXs(3, [8, 24, 18, 24, 20, 24, 18, 24, 8]);
					this.important.setXs(4, [6, 16, 14, 18, 16, 18, 14, 16, 6]);
					this.important.setXs(5, [4, 12, 16, 14, 12, 14, 16, 12, 4]);
					this.important.setXs(6, [2, 6, 8, 6, 10, 6, 8, 6, 2]);
					this.important.setXs(7, [4, 2, 8, 8, 4, 8, 8, 2, 4]);
					this.important.setXs(8, [0, 2, 4, 4, -2, 4, 4, 2, 0]);
					this.important.setXs(9, [0, -4, 0, 0, 0, 0, 0, -4, 0]);
					//convertedImportant
					this.important.setXs(0, [1, 2, 3, 2, 1, 2, 3, 2, 1]);
					this.important.setXs(1, [1, 2, 4, 3, 2, 3, 4, 2, 1]);
					this.important.setXs(2, [2, 3, 3, 4, 3, 4, 3, 3, 2]);
					this.important.setXs(3, [2, 4, 3, 4, 4, 4, 3, 4, 2]);
					this.important.setXs(4, [2, 3, 3, 3, 3, 3, 3, 3, 2]);
					this.important.setXs(5, [1, 2, 3, 3, 2, 3, 3, 2, 1]);
					this.important.setXs(6, [1, 2, 2, 2, 2, 2, 2, 2, 1]);
					this.important.setXs(7, [1, 1, 2, 2, 1, 2, 2, 1, 1]);
					this.important.setXs(8, [1, 1, 1, 1, 0, 1, 1, 1, 1]);
					this.important.setXs(9, [1, 0, 1, 1, 1, 1, 1, 0, 1]);
					break;
				case "k":
					//important
					this.important.setXs(9, [4, 8, 16, 12, 4, 12, 16, 8, 4]);
					this.important.setXs(8, [4, 10, 28, 16, 8, 16, 28, 10, 4]);
					this.important.setXs(7, [12, 14, 16, 20, 18, 20, 16, 14, 12]);
					this.important.setXs(6, [8, 24, 18, 24, 20, 24, 18, 24, 8]);
					this.important.setXs(5, [6, 16, 14, 18, 16, 18, 14, 16, 6]);
					this.important.setXs(4, [4, 12, 16, 14, 12, 14, 16, 12, 4]);
					this.important.setXs(3, [2, 6, 8, 6, 10, 6, 8, 6, 2]);
					this.important.setXs(2, [4, 2, 8, 8, 4, 8, 8, 2, 4]);
					this.important.setXs(1, [0, 2, 4, 4, -2, 4, 4, 2, 0]);
					this.important.setXs(0, [0, -4, 0, 0, 0, 0, 0, -4, 0]);
					//convertedImportant
					this.important.setXs(9, [1, 2, 3, 2, 1, 2, 3, 2, 1]);
					this.important.setXs(8, [1, 2, 4, 3, 2, 3, 4, 2, 1]);
					this.important.setXs(7, [2, 3, 3, 4, 3, 4, 3, 3, 2]);
					this.important.setXs(6, [2, 4, 3, 4, 4, 4, 3, 4, 2]);
					this.important.setXs(5, [2, 3, 3, 3, 3, 3, 3, 3, 2]);
					this.important.setXs(4, [1, 2, 3, 3, 2, 3, 3, 2, 1]);
					this.important.setXs(3, [1, 2, 2, 2, 2, 2, 2, 2, 1]);
					this.important.setXs(2, [1, 1, 2, 2, 1, 2, 2, 1, 1]);
					this.important.setXs(1, [1, 1, 1, 1, 0, 1, 1, 1, 1]);
					this.important.setXs(0, [1, 0, 1, 1, 1, 1, 1, 0, 1]);
					break;
				case "C":
					//important
					this.important.setXs(0, [6, 4, 0, -10, -12, -10, 0, 4, 6]);
					this.important.setXs(1, [2, 2, 0, -4, -14, -4, 0, 2, 2]);
					this.important.setXs(2, [2, 2, 0, -10, -8, -10, 0, 2, 2]);
					this.important.setXs(3, [0, 0, -2, 4, 10, 4, -2, 0, 0]);
					this.important.setXs(4, [0, 0, 0, 2, 8, 2, 0, 0, 0]);
					this.important.setXs(5, [-2, 0, 4, 2, 6, 2, 4, 0, -2]);
					this.important.setXs(6, [0, 0, 0, 2, 4, 2, 0, 0, 0]);
					this.important.setXs(7, [4, 0, 8, 6, 10, 6, 8, 0, 4]);
					this.important.setXs(8, [0, 2, 4, 6, 6, 6, 4, 2, 0]);
					this.important.setXs(9, [0, 0, 2, 6, 6, 6, 2, 0, 0]);
					//convertedImportant
					this.convertedImportant.setXs(0, [4, 3, 2, 1, 1, 1, 2, 3, 4]);
					this.convertedImportant.setXs(1, [3, 3, 2, 2, 1, 2, 2, 3, 3]);
					this.convertedImportant.setXs(2, [3, 3, 2, 1, 1, 1, 2, 3, 3]);
					this.convertedImportant.setXs(3, [2, 2, 2, 3, 4, 3, 2, 2, 2]);
					this.convertedImportant.setXs(4, [2, 2, 2, 3, 4, 3, 2, 2, 2]);
					this.convertedImportant.setXs(5, [2, 2, 3, 3, 4, 3, 3, 2, 2]);
					this.convertedImportant.setXs(6, [2, 2, 2, 3, 3, 3, 2, 2, 2]);
					this.convertedImportant.setXs(7, [3, 2, 4, 4, 4, 4, 4, 2, 3]);
					this.convertedImportant.setXs(8, [2, 3, 3, 4, 4, 4, 3, 3, 2]);
					this.convertedImportant.setXs(9, [2, 2, 3, 4, 4, 4, 3, 2, 2]);
					break;
				case "c":
					//important
					this.important.setXs(9, [6, 4, 0, -10, -12, -10, 0, 4, 6]);
					this.important.setXs(8, [2, 2, 0, -4, -14, -4, 0, 2, 2]);
					this.important.setXs(7, [2, 2, 0, -10, -8, -10, 0, 2, 2]);
					this.important.setXs(6, [0, 0, -2, 4, 10, 4, -2, 0, 0]);
					this.important.setXs(5, [0, 0, 0, 2, 8, 2, 0, 0, 0]);
					this.important.setXs(4, [-2, 0, 4, 2, 6, 2, 4, 0, -2]);
					this.important.setXs(3, [0, 0, 0, 2, 4, 2, 0, 0, 0]);
					this.important.setXs(2, [4, 0, 8, 6, 10, 6, 8, 0, 4]);
					this.important.setXs(1, [0, 2, 4, 6, 6, 6, 4, 2, 0]);
					this.important.setXs(0, [0, 0, 2, 6, 6, 6, 2, 0, 0]);
					//convertedImportant
					this.convertedImportant.setXs(9, [4, 3, 2, 1, 1, 1, 2, 3, 4]);
					this.convertedImportant.setXs(8, [3, 3, 2, 2, 1, 2, 2, 3, 3]);
					this.convertedImportant.setXs(7, [3, 3, 2, 1, 1, 1, 2, 3, 3]);
					this.convertedImportant.setXs(6, [2, 2, 2, 3, 4, 3, 2, 2, 2]);
					this.convertedImportant.setXs(5, [2, 2, 2, 3, 4, 3, 2, 2, 2]);
					this.convertedImportant.setXs(4, [2, 2, 3, 3, 4, 3, 3, 2, 2]);
					this.convertedImportant.setXs(3, [2, 2, 2, 3, 3, 3, 2, 2, 2]);
					this.convertedImportant.setXs(2, [3, 2, 4, 4, 4, 4, 4, 2, 3]);
					this.convertedImportant.setXs(1, [2, 3, 3, 4, 4, 4, 3, 3, 2]);
					this.convertedImportant.setXs(0, [2, 2, 3, 4, 4, 4, 3, 2, 2]);
					break;
				case "P":
					//important
					this.important.setXs(0, [0, 3, 6, 9, 12, 9, 6, 3, 0]);
					this.important.setXs(1, [18, 36, 56, 80, 120, 80, 56, 36, 18]);
					this.important.setXs(2, [14, 26, 42, 60, 80, 60, 42, 26, 14]);
					this.important.setXs(3, [10, 20, 30, 34, 40, 34, 30, 20, 10]);
					this.important.setXs(4, [6, 12, 18, 18, 20, 18, 18, 12, 6]);
					this.important.setXs(5, [2, 0, 8, 0, 8, 0, 8, 0, 2]);
					this.important.setXs(6, [0, 0, -2, 0, 4, 0, -2, 0, 0]);
					this.important.setXs(7, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.important.setXs(8, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.important.setXs(9, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					//convertedImportant
					this.convertedImportant.setXs(0, [0, 0, 2, 2, 2, 2, 2, 0, 0]);
					this.convertedImportant.setXs(1, [3, 4, 4, 4, 4, 4, 4, 4, 3]);
					this.convertedImportant.setXs(2, [3, 4, 4, 4, 4, 4, 4, 4, 3]);
					this.convertedImportant.setXs(3, [2, 4, 4, 4, 4, 4, 4, 4, 2]);
					this.convertedImportant.setXs(4, [2, 2, 3, 3, 4, 3, 3, 2, 2]);
					this.convertedImportant.setXs(5, [0, 0, 2, 0, 2, 0, 2, 0, 0]);
					this.convertedImportant.setXs(6, [0, 0, -1, 0, 0, 0, -1, 0, 0]);
					this.convertedImportant.setXs(7, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.convertedImportant.setXs(8, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.convertedImportant.setXs(9, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					break;
				case "p":
					//important
					this.important.setXs(9, [0, 3, 6, 9, 12, 9, 6, 3, 0]);
					this.important.setXs(8, [18, 36, 56, 80, 120, 80, 56, 36, 18]);
					this.important.setXs(7, [14, 26, 42, 60, 80, 60, 42, 26, 14]);
					this.important.setXs(6, [10, 20, 30, 34, 40, 34, 30, 20, 10]);
					this.important.setXs(5, [6, 12, 18, 18, 20, 18, 18, 12, 6]);
					this.important.setXs(4, [2, 0, 8, 0, 8, 0, 8, 0, 2]);
					this.important.setXs(3, [0, 0, -2, 0, 4, 0, -2, 0, 0]);
					this.important.setXs(2, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.important.setXs(1, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.important.setXs(0, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					//convertedImportant
					this.convertedImportant.setXs(9, [0, 0, 2, 2, 2, 2, 2, 0, 0]);
					this.convertedImportant.setXs(8, [3, 4, 4, 4, 4, 4, 4, 4, 3]);
					this.convertedImportant.setXs(7, [3, 4, 4, 4, 4, 4, 4, 4, 3]);
					this.convertedImportant.setXs(6, [2, 4, 4, 4, 4, 4, 4, 4, 2]);
					this.convertedImportant.setXs(5, [2, 2, 3, 3, 4, 3, 3, 2, 2]);
					this.convertedImportant.setXs(4, [0, 0, 2, 0, 2, 0, 2, 0, 0]);
					this.convertedImportant.setXs(3, [0, 0, -1, 0, 0, 0, -1, 0, 0]);
					this.convertedImportant.setXs(2, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.convertedImportant.setXs(1, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.convertedImportant.setXs(0, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					break;
				case "B":
					//important
					this.important.setXs(0, [0, 3, 6, 9, 12, 9, 6, 3, 0]);
					this.important.setXs(1, [18, 36, 56, 80, 120, 80, 56, 36, 18]);
					this.important.setXs(2, [14, 26, 42, 60, 80, 60, 42, 26, 14]);
					this.important.setXs(3, [10, 20, 30, 34, 40, 34, 30, 20, 10]);
					this.important.setXs(4, [6, 12, 18, 18, 20, 18, 18, 12, 6]);
					this.important.setXs(5, [2, 0, 8, 0, 8, 0, 8, 0, 2]);
					this.important.setXs(6, [0, 0, -2, 0, 4, 0, -2, 0, 0]);
					this.important.setXs(7, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.important.setXs(8, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.important.setXs(9, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					//convertedImportant
					this.convertedImportant.setXs(0, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.convertedImportant.setXs(1, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.convertedImportant.setXs(2, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.convertedImportant.setXs(3, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.convertedImportant.setXs(4, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.convertedImportant.setXs(5, [0, 0, -1, 0, 0, 0, -1, 0, 0]);
					this.convertedImportant.setXs(6, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.convertedImportant.setXs(7, [-2, 0, 0, 0, 3, 0, 0, 0, -2]);
					this.convertedImportant.setXs(8, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.convertedImportant.setXs(9, [0, 0, 1, 0, 0, 0, 1, 0, 0]);
					break;
				case "b":
					//important
					this.important.setXs(9, [0, 3, 6, 9, 12, 9, 6, 3, 0]);
					this.important.setXs(8, [18, 36, 56, 80, 120, 80, 56, 36, 18]);
					this.important.setXs(7, [14, 26, 42, 60, 80, 60, 42, 26, 14]);
					this.important.setXs(6, [10, 20, 30, 34, 40, 34, 30, 20, 10]);
					this.important.setXs(5, [6, 12, 18, 18, 20, 18, 18, 12, 6]);
					this.important.setXs(4, [2, 0, 8, 0, 8, 0, 8, 0, 2]);
					this.important.setXs(3, [0, 0, -2, 0, 4, 0, -2, 0, 0]);
					this.important.setXs(2, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.important.setXs(1, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.important.setXs(0, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					//convertedImportant
					this.convertedImportant.setXs(9, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.convertedImportant.setXs(8, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.convertedImportant.setXs(7, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.convertedImportant.setXs(6, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.convertedImportant.setXs(5, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.convertedImportant.setXs(4, [0, 0, -1, 0, 0, 0, -1, 0, 0]);
					this.convertedImportant.setXs(3, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.convertedImportant.setXs(2, [-2, 0, 0, 0, 3, 0, 0, 0, -2]);
					this.convertedImportant.setXs(1, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.convertedImportant.setXs(0, [0, 0, 1, 0, 0, 0, 1, 0, 0]);
					break;
				case "O":
					//important
					this.important.setXs(0, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.important.setXs(1, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.important.setXs(2, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.important.setXs(3, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.important.setXs(4, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.important.setXs(5, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.important.setXs(6, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.important.setXs(7, [0, 0, 0, 2, 0, 2, 0, 0, 0]);
					this.important.setXs(8, [0, 0, 0, 0, 6, 0, 0, 0, 0]);
					this.important.setXs(9, [0, 0, 0, 4, 0, 4, 0, 0, 0]);
					//convertedImportant
					this.convertedImportant.setXs(0, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.convertedImportant.setXs(1, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.convertedImportant.setXs(2, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.convertedImportant.setXs(3, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.convertedImportant.setXs(4, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.convertedImportant.setXs(5, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.convertedImportant.setXs(6, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.convertedImportant.setXs(7, [0, 0, 0, 1, 0, 1, 0, 0, 0]);
					this.convertedImportant.setXs(8, [0, 0, 0, 0, 3, 0, 0, 0, 0]);
					this.convertedImportant.setXs(9, [0, 0, 0, 2, 0, 2, 0, 0, 0]);
					break;
				case "o":
					//important
					this.important.setXs(9, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.important.setXs(8, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.important.setXs(7, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.important.setXs(6, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.important.setXs(5, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.important.setXs(4, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.important.setXs(3, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.important.setXs(2, [0, 0, 0, 2, 0, 2, 0, 0, 0]);
					this.important.setXs(1, [0, 0, 0, 0, 6, 0, 0, 0, 0]);
					this.important.setXs(0, [0, 0, 0, 4, 0, 4, 0, 0, 0]);
					//convertedImportant
					this.convertedImportant.setXs(9, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.convertedImportant.setXs(8, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.convertedImportant.setXs(7, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.convertedImportant.setXs(6, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.convertedImportant.setXs(5, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.convertedImportant.setXs(4, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.convertedImportant.setXs(3, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.convertedImportant.setXs(2, [0, 0, 0, 1, 0, 1, 0, 0, 0]);
					this.convertedImportant.setXs(1, [0, 0, 0, 0, 3, 0, 0, 0, 0]);
					this.convertedImportant.setXs(0, [0, 0, 0, 2, 0, 2, 0, 0, 0]);
					break;
				case "m":
					//important
					this.important.setXs(0, [0, 0, 0, 4, 8, 4, 0, 0, 0]);
					this.important.setXs(1, [0, 0, 0, 3, 6, 3, 0, 0, 0]);
					this.important.setXs(2, [0, 0, 0, 1, 2, 1, 0, 0, 0]);
					this.important.setXs(3, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.important.setXs(4, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.important.setXs(5, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.important.setXs(6, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.important.setXs(7, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.important.setXs(8, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.important.setXs(9, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					//convertedImportant
					this.convertedImportant.setXs(0, [-2, -2, -2, 2, 2, 2, -2, -2, -2]);
					this.convertedImportant.setXs(1, [-2, -2, -2, 2, 2, 2, -2, -2, -2]);
					this.convertedImportant.setXs(2, [-2, -2, -2, 2, 2, 2, -2, -2, -2]);
					this.convertedImportant.setXs(3, [-2, -2, -2, -2, -2, -2, -2, -2, -2]);
					this.convertedImportant.setXs(4, [-2, -2, -2, -2, -2, -2, -2, -2, -2]);
					this.convertedImportant.setXs(5, [-2, -2, -2, -2, -2, -2, -2, -2, -2]);
					this.convertedImportant.setXs(6, [-2, -2, -2, -2, -2, -2, -2, -2, -2]);
					this.convertedImportant.setXs(7, [-2, -2, -2, -2, -2, -2, -2, -2, -2]);
					this.convertedImportant.setXs(8, [-2, -2, -2, -2, -2, -2, -2, -2, -2]);
					this.convertedImportant.setXs(9, [-2, -2, -2, -2, -2, -2, -2, -2, -2]);
					break;
				case "M":
					//important
					this.important.setXs(9, [0, 0, 0, 4, 8, 4, 0, 0, 0]);
					this.important.setXs(8, [0, 0, 0, 3, 6, 3, 0, 0, 0]);
					this.important.setXs(7, [0, 0, 0, 1, 2, 1, 0, 0, 0]);
					this.important.setXs(3, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.important.setXs(4, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.important.setXs(5, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.important.setXs(6, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.important.setXs(0, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.important.setXs(1, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					this.important.setXs(2, [0, 0, 0, 0, 0, 0, 0, 0, 0]);
					//convertedImportant
					this.convertedImportant.setXs(9, [-2, -2, -2, 2, 2, 2, -2, -2, -2]);
					this.convertedImportant.setXs(8, [-2, -2, -2, 2, 2, 2, -2, -2, -2]);
					this.convertedImportant.setXs(7, [-2, -2, -2, 2, 2, 2, -2, -2, -2]);
					this.convertedImportant.setXs(3, [-2, -2, -2, -2, -2, -2, -2, -2, -2]);
					this.convertedImportant.setXs(4, [-2, -2, -2, -2, -2, -2, -2, -2, -2]);
					this.convertedImportant.setXs(5, [-2, -2, -2, -2, -2, -2, -2, -2, -2]);
					this.convertedImportant.setXs(6, [-2, -2, -2, -2, -2, -2, -2, -2, -2]);
					this.convertedImportant.setXs(0, [-2, -2, -2, -2, -2, -2, -2, -2, -2]);
					this.convertedImportant.setXs(1, [-2, -2, -2, -2, -2, -2, -2, -2, -2]);
					this.convertedImportant.setXs(2, [-2, -2, -2, -2, -2, -2, -2, -2, -2]);
					break;
				default:
					break;
			}
		}
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

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
	}

}

