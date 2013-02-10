package com.godpaper.as3.core
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.model.ChessPiecesMemento;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.model.vos.PositionVO;
	import com.godpaper.as3.views.components.ChessPiece;
	import com.lookbackon.ds.BitBoard;
	
	import flash.geom.Point;

	/**
	 * The interface of chess piece manager,which one delegate all kinds of chess piece command execution.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Feb 14, 2011 11:42:29 AM
	 * @history 05/11/2011 split the indicateGaskets to indicateGasketsMove and indicateGasketsCapture functions;
	 */
	public interface IChessPieceManager
	{
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		//----------------------------------
		//  memento
		//----------------------------------
		/**
		 * @return ChessPiecesMemento.
		 */
		function get memento():ChessPiecesMemento;
		/**
		 * Using memento design pattern to implment make/unmake functions.
		 * @param value
		 */
		function set memento(value:ChessPiecesMemento):void
		//----------------------------------
		//  previousMementos
		//----------------------------------
		/**
		 * @return chess pieces' move history.
		 */
		function get previousMementos():Array;
		//----------------------------------
		//  eatOffs
		//----------------------------------
		/**
		 * @return the eaten chess pieces.
		 */
		function get eatOffs():Vector.<ChessPiece>;
		/**
		 * @param value
		 */
		function set eatOffs(value:Vector.<ChessPiece>):void;
		//----------------------------------
		//  isChecking
		//----------------------------------
		/**
		 * @param value the checking status.
		 */
		function set isChecking(value:Boolean):void;
		/**
		 * @return the checking status.
		 */
		function get isChecking():Boolean;
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//-------------------------------------------------------------------------- 

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		/**
		 * @param conductVO the conduct value object of moving chess piece.
		 * @return current chess piece's move validation result.
		 */
		function doMoveValidation(conductVO:ConductVO):Boolean;
		/**
		 * <b>Make Move</b> is a function inside a chess program to update the internal chess position
		 * and its Board representation as well as associated </br>
		 * or dependent state variables and data by a move made on the internal board,
		 * such as zobrist keys to index the transposition table. </br>
		 * That usually happens inside the Search algorithm, </br>
		 * where the move acts like an edge connecting two nodes of a search tree,
		 * a parent and a child node. </br>
		 * Dependent on the design of the data structures
		 * and the used search algorithms there are different approaches
		 * with respect to randomly accessing aspects of nodes
		 * and restoring the position while unmaking the move.
		 *
		 * @see http://chessprogramming.wikispaces.com/Make+Move
		 * @param conductVO the conduct value object of moving chess piece.
		 *
		 */
		function makeMove(conductVO:ConductVO):void;
		/**
		 *
		 * <b>Unmake Move</b> is a function inside a chess program to update the internal chess position
		 * and its Board representation as well as associated or dependent state variables
		 * and data by a move unmade on the internal board. </br>
		 * In unmake move, reversible aspects of a position can be incrementally updated by the inverse
		 * or own inverse operation of Make Move. </br>
		 * Irreversible aspects of a position, such as ep state,
		 * castling rights and the halfmove clock are either restored from a stack (LIFO), </br>
		 * or simply kept in arrays indexed by current search or game ply. </br>
		 * Alternatively, one may capacitate the move with all the necessary information
		 * to recover those irreversible aspects of a position as well.
		 *
		 * @see http://chessprogramming.wikispaces.com/Unmake+Move
		 *
		 * @param conductVO the conduct value object of moving chess piece.
		 *
		 */
		function unmakeMove(conductVO:ConductVO):void;
		//make move data and piece entity change behavior.
		/**
		 * @param conductVO
		 */
		function applyMove(conductVO:ConductVO):void;
		//pluge to death.	
		/**
		 * @return none move status code.
		 */
		function noneMove():int;
		/**
		 * @param gamePosition
		 * @return will none move status flag.
		 */
		function willNoneMove(gamePosition:PositionVO):Boolean;
		//
		function calculatePieceIndex(chessPiece:ChessPiece):int;
		//
		/**
		 * @see Main.application1_creationCompleteHandler.createGasket().
		 * @param legalMoves current chess piece's legal moves.
		 *
		 */
//		function indicateGaskets(legalMoves:BitBoard):void;
		function indicateGasketsMove(legalMoves:BitBoard):void;
		function indicateGasketsCapture(legalCaptures:BitBoard):void;
		/**
		 *
		 * @param pieces execute check mate's chess pieces.
		 * @param marshal blues'/reds' marshal bitboard.
		 * @return the result of check pattern,if neccessary.
		 *
		 */
		function indicateCheck(pieces:Vector.<ChessPiece>, marshal:BitBoard):Boolean;	
	}
}


