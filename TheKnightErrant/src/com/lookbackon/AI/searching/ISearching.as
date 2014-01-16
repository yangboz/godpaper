package com.lookbackon.AI.searching
{
	import com.lookbackon.AI.evaluation.IEvaluation;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.model.vos.PositionVO;
	import com.godpaper.as3.views.components.ChessPiece;
	
	/**
	 * The basic chess game AI behaviors to be implemented.
	 * @author Knight.zhou
	 * </time> before 2010-7-12 generateMoves/makeMove/unmakeMove/applyMove
	 * </time> 2010-7-12 noneMove/willNoneMove.
	 * </time> 2010-7-13 moves/captures/orderingMoves.
	 * </time> 2010-7-14 evaluation.
	 */	
	public interface ISearching
	{
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		function get moves():Vector.<ConductVO>;
		function get captures():Vector.<ConductVO>;
		
		function set orderingMoves(value:Vector.<ConductVO>):void;
		function get orderingMoves():Vector.<ConductVO>;
		
		function set evaluation(value:IEvaluation):void;
		function get evaluation():IEvaluation;
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		function generateMoves(blues:Vector.<ChessPiece>):Vector.<ConductVO>;
		function makeMove(conductVO:ConductVO):void;
		function unmakeMove(conductVO:ConductVO):void;
		function applyMove(conductVO:ConductVO):void;
		//
		function noneMove():int;
		function willNoneMove(gamePosition:PositionVO):Boolean;
	}
}