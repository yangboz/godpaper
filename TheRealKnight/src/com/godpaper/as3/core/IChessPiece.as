package com.godpaper.as3.core
{
	import com.godpaper.as3.business.fsm.ChessAgent;
	import com.godpaper.as3.model.vos.OmenVO;
	
	import mx.core.IVisualElement;

	/**
	 * The interface of ChessPiece.
	 * @author Knight.zhou
	 * @history 2010-06-25 add type property for category chess piece class type.
	 */	
	public interface IChessPiece extends IVisualElement,IPosition
	{
		function set agent(value:ChessAgent):void;
		function get agent():ChessAgent;
		
		function set chessVO(value:IChessVO):void;
		function get chessVO():IChessVO;
		
		function set omenVO(value:OmenVO):void;
		function get omenVO():OmenVO;
		
		function set type(value:String):void;
		function get type():String;
	}
}