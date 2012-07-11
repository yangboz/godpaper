package com.godpaper.as3.core
{
	import com.godpaper.as3.core.IChessGasket;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.views.components.ChessPiece;
	
	import flash.geom.Rectangle;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * You can put chess pieces on/inside the box constrainted by the fixed area.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jul 8, 2011 11:55:25 AM
	 */
	public interface IPiecesBox extends IChessGasket,IType
	{
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		//Each pieces box contains(receline) more than one chess pieces.
		function set childrenArea(value:Rectangle):void;
		function get childrenArea():Rectangle;
		//
		function set chessPieces(value:Vector.<ChessPiece>):void;
		function get chessPieces():Vector.<ChessPiece>;
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
	}
}