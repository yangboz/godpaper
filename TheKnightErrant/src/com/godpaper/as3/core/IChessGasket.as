package com.godpaper.as3.core
{
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.core.IVisualElement;

	/**
	 * The interface of ChessGasket.Abstarct the chess gasket foundation and properties.
	 *
	 * @author Knight.zhou
	 * @history 2011-2-18 current conductVO property added.
	 * @history 2012-5-11 added the global configure variables.
	 */	
	public interface IChessGasket extends IVisualElement,IPosition
	{
		//TODO:Each chess gasket contains more than one chess pieces.
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
	}
}

