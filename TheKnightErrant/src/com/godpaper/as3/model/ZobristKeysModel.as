package com.godpaper.as3.model
{
	import com.godpaper.as3.consts.ZobristConstants;
	import com.godpaper.as3.errors.DefaultErrors;
	import com.godpaper.as3.model.vos.ZobristKeyVO;
	import com.godpaper.as3.utils.LogUtil;
	import com.lookbackon.ds.ZobristHashTable;
	
	import de.polygonal.ds.Array3;
	import de.polygonal.ds.HashTable;
	import de.polygonal.math.PM_PRNG;
	
	import mx.logging.ILogger;
	
	/**
	 * A singleton model hold all Chess Board's tag info for Chess HistoryTable/OpeningBook.
	 * 
	 * @see http://chessprogramming.wikispaces.com/Zobrist+Hashing
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class ZobristKeysModel
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//Singleton instance of ZobristKeysModel;
		private static var instance:ZobristKeysModel;
		//reds
		/*private var _redRook:ZobristKeyVO 		= new ZobristKeyVO();
		private var _redKnight:ZobristKeyVO 	= new ZobristKeyVO();
		private var _redBishop:ZobristKeyVO 	= new ZobristKeyVO();
		private var _redOffical:ZobristKeyVO 	= new ZobristKeyVO();
		private var _redMarshal:ZobristKeyVO 	= new ZobristKeyVO();
		private var _redCannon:ZobristKeyVO 	= new ZobristKeyVO();
		private var _redPawn:ZobristKeyVO 		= new ZobristKeyVO();
		private var _reds:ZobristKeyVO 			= new ZobristKeyVO();*/
		//blues
		/*private var _blueRook:ZobristKeyVO 		= new ZobristKeyVO();
		private var _blueKnight:ZobristKeyVO 	= new ZobristKeyVO();
		private var _blueBishop:ZobristKeyVO 	= new ZobristKeyVO();
		private var _blueOffical:ZobristKeyVO 	= new ZobristKeyVO();
		private var _blueMarshal:ZobristKeyVO 	= new ZobristKeyVO();
		private var _blueCannon:ZobristKeyVO 	= new ZobristKeyVO();
		private var _bluePawn:ZobristKeyVO 		= new ZobristKeyVO();
		private var _blues:ZobristKeyVO			= new ZobristKeyVO();*/
		private var _board:ZobristKeyVO			= new ZobristKeyVO();
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(ZobristKeysModel);
		//generation.
		//TODO.other structs.
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function ZobristKeysModel(access:Private)
		{
			if (access != null) {
				if (instance == null) {
					instance=this;
				}
			} else {
				throw new DefaultErrors(DefaultErrors.INITIALIZE_SINGLETON_CLASS);
			}
			//static constructor block
			//ref:http://mediocrechess.blogspot.com/2007/01/guide-zobrist-keys.html
			var pm_pgn:PM_PRNG = new PM_PRNG();
			//board(reds and blues).
			_board.position.setXs(0,[pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt()]);
			_board.position.setXs(1,[pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt()]);
			_board.position.setXs(2,[pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt()]);
			_board.position.setXs(3,[pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt()]);
			_board.position.setXs(4,[pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt()]);
			_board.position.setXs(5,[pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt()]);
			_board.position.setXs(6,[pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt()]);
			_board.position.setXs(7,[pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt()]);
			_board.position.setXs(8,[pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt()]);
			_board.position.setXs(9,[pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt(),pm_pgn.nextInt()]);
		}
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		/*
		//----------------------------------
		//  bluePawn
		//----------------------------------
		public function get bluePawn():ZobristKeyVO
		{
			return _bluePawn;
		}
		public function set bluePawn(value:ZobristKeyVO):void
		{
			_bluePawn = value;
		}
		//----------------------------------
		//  blueCannon
		//----------------------------------
		public function get blueCannon():ZobristKeyVO
		{
			return _blueCannon;
		}
		public function set blueCannon(value:ZobristKeyVO):void
		{
			_blueCannon = value;
		}
		//----------------------------------
		//  blueMarshal
		//----------------------------------
		public function get blueMarshal():ZobristKeyVO
		{
			return _blueMarshal;
		}
		public function set blueMarshal(value:ZobristKeyVO):void
		{
			_blueMarshal = value;
		}
		//----------------------------------
		//  blueOffical
		//----------------------------------
		public function get blueOffical():ZobristKeyVO
		{
			return _blueOffical;
		}
		public function set blueOffical(value:ZobristKeyVO):void
		{
			_blueOffical = value;
		}
		//----------------------------------
		//  blueBishop
		//----------------------------------
		public function get blueBishop():ZobristKeyVO
		{
			return _blueBishop;
		}
		public function set blueBishop(value:ZobristKeyVO):void
		{
			_blueBishop = value;
		}
		//----------------------------------
		//  blueKnight
		//----------------------------------
		public function get blueKnight():ZobristKeyVO
		{
			return _blueKnight;
		}
		public function set blueKnight(value:ZobristKeyVO):void
		{
			_blueKnight = value;
		}
		//----------------------------------
		//  blueRook
		//----------------------------------
		public function get blueRook():ZobristKeyVO
		{
			return _blueRook;
		}
		public function set blueRook(value:ZobristKeyVO):void
		{
			_blueRook = value;
		}
		//----------------------------------
		//  redPawn
		//----------------------------------
		public function get redPawn():ZobristKeyVO
		{
			return _redPawn;
		}
		public function set redPawn(value:ZobristKeyVO):void
		{
			_redPawn = value;
		}
		//----------------------------------
		//  redCannon
		//----------------------------------
		public function get redCannon():ZobristKeyVO
		{
			return _redCannon;
		}
		public function set redCannon(value:ZobristKeyVO):void
		{
			_redCannon = value;
		}
		//----------------------------------
		//  redMarshal
		//----------------------------------
		public function get redMarshal():ZobristKeyVO
		{
			return _redMarshal;
		}
		public function set redMarshal(value:ZobristKeyVO):void
		{
			_redMarshal = value;
		}
		//----------------------------------
		//  redOffical
		//----------------------------------
		public function get redOffical():ZobristKeyVO
		{
			return _redOffical;
		}
		public function set redOffical(value:ZobristKeyVO):void
		{
			_redOffical = value;
		}
		//----------------------------------
		//  redBishop
		//----------------------------------
		public function get redBishop():ZobristKeyVO
		{
			return _redBishop;
		}
		public function set redBishop(value:ZobristKeyVO):void
		{
			_redBishop = value;
		}
		//----------------------------------
		//  redKnight
		//----------------------------------
		public function get redKnight():ZobristKeyVO
		{
			return _redKnight;
		}
		public function set redKnight(value:ZobristKeyVO):void
		{
			_redKnight = value;
		}
		//----------------------------------
		//  redRook
		//----------------------------------
		public function get redRook():ZobristKeyVO
		{
			return _redRook;
		}
		public function set redRook(value:ZobristKeyVO):void
		{
			_redRook = value;
			HistoryTableModel.getInstance().redRook.insert(ZobristConstants.RED_ROOK.key,value);
		}
		//----------------------------------
		//  reds
		//----------------------------------
		public function get reds():ZobristKeyVO
		{
			return _reds;
		}
		public function set reds(value:ZobristKeyVO):void
		{
			_reds = value;
			//TODO:
//			HistoryTableModel.getInstance().reds.insert(ZobristConstants.RED_ROOK.key,value);
		}
		//----------------------------------
		//  blues
		//----------------------------------
		public function get blues():ZobristKeyVO
		{
			return _blues;
		}
		public function set blues(value:ZobristKeyVO):void
		{
			_blues = value;
			//TODO:
//			HistoryTableModel.getInstance().blues.insert(ZobristConstants.RED_ROOK.key,value);
		}
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------	

		/**
		 *
		 * @return the singleton instance of ZobristKeysModel
		 *
		 */
		public static function getInstance():ZobristKeysModel 
		{
			if (instance == null) 
			{
				instance=new ZobristKeysModel(new Private());
			}
			return instance;
		}
		
		public function getZobristKey(type:String="board"):ZobristKeyVO
		{
			//TODO:every key type such as (Knight/Marshall..) should with his zobristKeyVO.
			//but now we just renturn all board zobristkey vo.
			return _board;
		}
	}
}
/**
 *Inner class which restricts construtor access to Private
 */
internal class Private 
{
}
