package com.godpaper.as3.model
{
	import com.godpaper.as3.consts.ZobristConstants;
	import com.godpaper.as3.errors.CcjErrors;
	import com.godpaper.as3.model.vos.ccjVO.BishopVO;
	import com.godpaper.as3.model.vos.ccjVO.CannonVO;
	import com.godpaper.as3.model.vos.ccjVO.KnightVO;
	import com.godpaper.as3.model.vos.ccjVO.MarshalVO;
	import com.godpaper.as3.model.vos.ccjVO.OfficalVO;
	import com.godpaper.as3.model.vos.ccjVO.PawnVO;
	import com.godpaper.as3.model.vos.ccjVO.RookVO;
	import com.godpaper.as3.utils.LogUtil;
	import com.lookbackon.ds.BitBoard;
	import com.lookbackon.ds.ZobristHashTable;
	
	import de.polygonal.ds.Array2;
	import de.polygonal.ds.HashTable;
	
	import mx.logging.ILogger;
	
	/**
	 * A singleton model hold chess board history table information.</br>
	 * 
	 * History heuristics are in some way an extension of killer moves. </br>
	 * With killer moves, the problem is that we forget them again immediately. </br>
	 * You can think of killer moves as some kind of short-term memory, 
	 * while history heuristics is long-term memory. </br>
	 * In history heuristics we keep track of all good moves. </br>
	 * For a game like chess or checkers, we take a double-indexed counter array, 
	 * history[][], which we index with the from and to squares of the move. </br>
	 * Every time we find a move from a-to-b to be good, we increment the value of history[a][b]. </br>
	 * When we generate the movelist, 
	 * we can then order it according to the values of the history array. </br>
	 * You might want to experiment with the history heuristic too, 
	 * e.g. you could decide only to increment the counter for moves which caused a fail-high 
	 * (after all, in all other nodes you will have to search all moves anyway, 
	 * so it doesn't matter as much in which order you search them). </br>
	 * 
	 * @see http://www.fierz.ch/strategy2.htm
	 * @author Knight.zhou
	 * 
	 */	
	public class HistoryTableModel
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//Singleton instance of HistoryTableModel;
		private static var instance:HistoryTableModel;
		private static const MAX_SIZE:int = 500;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(HistoryTableModel);
		//generation.
		//red
		private var _redRook:ZobristHashTable		= new ZobristHashTable(MAX_SIZE,ZobristConstants.RED_ROOK.key);
		private var _redKnight:ZobristHashTable		= new ZobristHashTable(MAX_SIZE,ZobristConstants.RED_KNIGHT.key);
		private var _redBishop:ZobristHashTable		= new ZobristHashTable(MAX_SIZE,ZobristConstants.RED_BISHOP.key);
		private var _redOffical:ZobristHashTable	= new ZobristHashTable(MAX_SIZE,ZobristConstants.RED_OFFICAL.key);
		private var _redMarshal:ZobristHashTable	= new ZobristHashTable(MAX_SIZE,ZobristConstants.RED_MARSHAL.key);
		private var _redCannon:ZobristHashTable		= new ZobristHashTable(MAX_SIZE,ZobristConstants.RED_CANNON.key);
		private var _redPawn:ZobristHashTable		= new ZobristHashTable(MAX_SIZE,ZobristConstants.RED_PAWN.key);
		//blue
		private var _blueRook:ZobristHashTable		= new ZobristHashTable(MAX_SIZE,ZobristConstants.BLUE_ROOK.key);
		private var _blueKnight:ZobristHashTable	= new ZobristHashTable(MAX_SIZE,ZobristConstants.BLUE_KNIGHT.key);
		private var _blueBishop:ZobristHashTable	= new ZobristHashTable(MAX_SIZE,ZobristConstants.BLUE_BISHOP.key);
		private var _blueOffical:ZobristHashTable	= new ZobristHashTable(MAX_SIZE,ZobristConstants.BLUE_OFFICAL.key);
		private var _blueMarshal:ZobristHashTable	= new ZobristHashTable(MAX_SIZE,ZobristConstants.BLUE_MARSHAL.key);
		private var _blueCannon:ZobristHashTable	= new ZobristHashTable(MAX_SIZE,ZobristConstants.BLUE_CANNON.key);
		private var _bluePawn:ZobristHashTable		= new ZobristHashTable(MAX_SIZE,ZobristConstants.BLUE_PAWN.key);
		//TODO.other structs.
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function HistoryTableModel(access:Private)
		{
			if (access != null) {
				if (instance == null) {
					instance=this;
				}
			} else {
				throw new CcjErrors(CcjErrors.INITIALIZE_SINGLETON_CLASS);
			}
		}
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  redRook
		//----------------------------------
		public function get redRook():ZobristHashTable
		{
			return _redRook;
		}
		public function set redRook(value:ZobristHashTable):void
		{
			_redRook = value;
			trace(value.dump());
		}
		//----------------------------------
		//  redKnight
		//----------------------------------
		public function get redKnight():ZobristHashTable
		{
			return _redKnight;
		}
		public function set redKnight(value:ZobristHashTable):void
		{
			_redKnight = value;
		}
		//----------------------------------
		//  redBishop
		//----------------------------------
		public function get redBishop():ZobristHashTable
		{
			return _redBishop;
		}
		public function set redBishop(value:ZobristHashTable):void
		{
			_redBishop = value;
		}
		//----------------------------------
		//  redOffical
		//----------------------------------
		public function get redOffical():ZobristHashTable
		{
			return _redOffical;
		}
		public function set redOffical(value:ZobristHashTable):void
		{
			_redOffical = value;
		}
		//----------------------------------
		//  redMarshal
		//----------------------------------
		public function get redMarshal():ZobristHashTable
		{
			return _redMarshal;
		}
		public function set redMarshal(value:ZobristHashTable):void
		{
			_redMarshal = value;
		}
		//----------------------------------
		//  redCannon
		//----------------------------------
		public function get redCannon():ZobristHashTable
		{
			return _redCannon;
		}
		public function set redCannon(value:ZobristHashTable):void
		{
			_redCannon = value;
		}
		//----------------------------------
		//  redPawn
		//----------------------------------
		public function get redPawn():ZobristHashTable
		{
			return _redPawn;
		}
		public function set redPawn(value:ZobristHashTable):void
		{
			_redPawn = value;
		}
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------	
		/**
		 *
		 * @return the singleton instance of HistoryTableModel
		 *
		 */
		public static function getInstance():HistoryTableModel 
		{
			if (instance == null) 
			{
				instance=new HistoryTableModel(new Private());
			}
			return instance;
		}
	}
}
/**
 *Inner class which restricts construtor access to Private
 */
internal class Private 
{
}