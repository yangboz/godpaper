package com.godpaper.as3.core
{
	import com.lookbackon.ds.BitBoard;
	/**
	 * The interface of chess pieces,about occupy,moves,captures.
	 * @see http://chess.dubmun.com/bitboard.html
	 * @author Knight.zhou
	 * @history 01/07/2011 ADDED:defends bitboard property.
	 * @history 08/18/2011 ADDED:identifier property for ChessVO.
	 */	
	public interface IChessVO
	{
		//for initialization.
		function initialization(rowIndex:int, colIndex:int,flag:int=0,identifier:String=""):void;
		//spaces occupied by red/blue pieces:
		function set occupies(value:BitBoard):void;
		function get occupies():BitBoard;
		//legal moves for these chess types.
		function set moves(value:BitBoard):void;
		function get moves():BitBoard;
		//red/blue piece positions to compute captures.
		function set captures(value:BitBoard):void;
		function get captures():BitBoard;
		//legal moves for these chess types that can keep "marshal" safty.
		function set defends(value:BitBoard):void;
		function get defends():BitBoard;
	}
}