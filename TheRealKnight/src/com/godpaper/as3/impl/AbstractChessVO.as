package com.godpaper.as3.impl
{
	import com.godpaper.as3.core.IChessPiece;
	import com.godpaper.as3.core.IChessVO;
	import com.godpaper.as3.errors.DefaultErrors;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.utils.LogUtil;
	import com.lookbackon.ds.BitBoard;
	
	import mx.logging.ILogger;

	/**
	 * This is our bitboard:</p>
	 * ---------</br>
	 * rkbomobkr</br>
	 * </br>
	 *  c     c</br>
	 * p p p p p</br>
	 * </br>
	 * </br>
	 * </br>
	 * P P P P P</br>
	 *  C     C</br>
	 * </br>
	 * RKBOMOBKR</br>
	 * ---------</br>
	 * </br>
	 * <strong>about X-ray attacks</strong></p>
	 * Here is another type of double attack in which the targets are threatened in one direction. </p>
	 * The attacking piece threatens two units, one behind the other, </p>
	 * on the same rank, file or diagonal. This double threat has lacked a good descriptive name. </p>
	 * We suggest ‘X-Ray’ attack.</p>
	 *
	 * The classical approach works ray-wise and uses pre-calculated ray-attacks </p>
	 * for each of the eight ray-directions and each of the 64 squares. </p>
	 * It has to distinguish between positive and negative directions, </p>
	 * because it has to bitscan the ray-attack intersection with the occupancy in different orders. </p>
	 * That usually don't cares for getting line- or piece attacks, </p>
	 * since one likely unrolls all directions needed for a particular line or piece - otherwise one may rely on a generalized bitscan.</p>
	 *
	 * @see http://chessprogramming.wikispaces.com/X-ray+Attacks
	 * @see http://chessprogramming.wikispaces.com/Classical+Approach
	 *
	 * @author Knight.zhou
	 *
	 */	
	public class AbstractChessVO extends BitBoard implements IChessVO
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var _occupies:BitBoard;
		private var _moves:BitBoard;
		private var _captures:BitBoard;
		private var _defends:BitBoard;
		//for Rook/Cannon condition filter.
		protected var blocker:BitBoard;
		//chess flag value(red or blue).
		protected var flag:int;
		//chess vo identifier.
		protected var identifier:String;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(AbstractChessVO);
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		/**
		 *
		 * @param the width value of bitboard;
		 * @param the height value of bitboard;
		 * @param the rowIndex of destination point;
		 * @param the colIndex of destination point;
		 * @param the flag you wanna set(red is 0,blue is 1).
		 * @param the identifier of ChessVO.
		 */		
		public function AbstractChessVO(width:int, height:int, rowIndex:int, colIndex:int,flag:int=0,identifier:String="")
		{
			//call super.
			super(width, height);
			//store the proteced variables.
			this.flag = flag;
			this.identifier = identifier;
			//init.
			this._occupies = new BitBoard(width,height);
			this._moves = new BitBoard(width,height);
			this._captures = new BitBoard(width,height);
			this._defends = new BitBoard(width,height);
			this.initialization(rowIndex,colIndex,flag,identifier);
		}
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  occupies(implements)
		//----------------------------------
		public function get occupies():BitBoard
		{
			return _occupies;
		}
		/**
		 *
		 * @param value occupied by red/blue pieces.
		 *
		 */		
		public function set occupies(value:BitBoard):void
		{
			_occupies = value;
//			LOG.info("anew occupies:{0}",value.dump());
		}
		//----------------------------------
		//  moves(implements)
		//----------------------------------
		public function get moves():BitBoard
		{
			return _moves;
		}
		/**
		 *
		 * @param value legal moves by red/blue pieces.
		 *
		 */		
		public function set moves(value:BitBoard):void
		{
			_moves = value;
//			LOG.info("anew moves:{0}",value.dump());
		}
		//----------------------------------
		//  captures(implements)
		//----------------------------------
		public function get captures():BitBoard
		{
			return _captures;
		}
		/**
		 *
		 * @param value attacked by red/blue pieces.
		 *
		 */		
		public function set captures(value:BitBoard):void
		{
			_captures = value;
//			LOG.info("anew captures:{0}",value.dump());
		}
		//----------------------------------
		//  defends(implements)
		//----------------------------------
		public function get defends():BitBoard
		{
			return _defends;
		}
		/**
		 *
		 * @param value "marshal" defends by blue pieces.
		 *
		 */		
		public function set defends(value:BitBoard):void
		{
			_defends = value;
		}
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  initialization
		//----------------------------------
		/**
		 *
		 * @param the rowIndex you wanna set bit flag.
		 * @param the colIndex you wanna set big flag.
		 * @param the flag you wanna set(red is 0,blue is 1).
		 * @param the identifier of ChessVO.
		 * @see mx.utils.BitFlagUtil#update
		 */
		virtual public function initialization( rowIndex:int, colIndex:int,flag:int=0,identifier:String=""):void
		{
			//TODO: override function.
			throw new DefaultErrors(DefaultErrors.INITIALIZE_VIRTUAL_FUNCTION);
		}

		//----------------------------------
		//  X-ray attacks
		//----------------------------------
		//west
		/**
		 *
		 * @param rowIndex current piece's row index.
		 * @param colIndex current piece's column index.
		 * @return legal moves prototype is bit board under west direction.
		 *
		 */	
		virtual public function getWest(rowIndex:int, colIndex:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			return bb;
		}
		/**
		 *
		 * @param rowIndex current piece's row index.
		 * @param colIndex current piece's column index.
		 * @return legal moves prototype is bit board under north direction.
		 *
		 */	
		//north
		virtual public function getNorth(rowIndex:int, colIndex:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			return bb;
		}
		/**
		 *
		 * @param rowIndex current piece's row index.
		 * @param colIndex current piece's column index.
		 * @return legal moves prototype is bit board under east direction.
		 *
		 */	
		//east
		virtual public function getEast(rowIndex:int, colIndex:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			return bb;
		}
		/**
		 *
		 * @param rowIndex current piece's row index.
		 * @param colIndex current piece's column index.
		 * @return legal moves prototype is bit board under south direction.
		 *
		 */	
		//south
		virtual public function getSouth(rowIndex:int, colIndex:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			return bb;
		}
	}
}

