package com.godpaper.as3.core
{
	import com.godpaper.as3.core.IDragdropable;
	import com.godpaper.as3.core.IVisualElement;
	import com.godpaper.as3.model.vos.ConductVO;
	
	import starling.display.Image;

	/**
	 * The interface of ChessGasket.Abstarct the chess gasket foundation and properties.
	 *
	 * @author Knight.zhou
	 * </time> 2011-2-18 current conductVO property added.
	 * </time> 2012-5-11 added the global configure variables.
	 */	
	public interface IChessGasket extends IVisualElement,IPosition,IDragdropable
	{
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//--------------------------------------------------------------------------
		//Each chess gasket contains only one chess piece.
		function get chessPiece():IChessPiece;
		function set chessPiece(value:IChessPiece):void;
		//
		function get conductVO():ConductVO;
		//global configure variables;
		function get tipsVisible():Boolean
		function set tipsVisible(value:Boolean):void;
		//
		function get borderAlpha():Number;
		function set borderAlpha(value:Number):void;
		//
		function get contentBackgroundAlpha():Number;
		function set contentBackgroundAlpha(value:Number):void;
		//
		function get backgroundAlpha():Number;
		function set backgroundAlpha(value:Number):void;
		//
		function get borderVisible():Boolean;
		function set borderVisible(value:Boolean):void;
		//
		function set background(value:Image):void;
		function get background():Image;
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
	}
}

