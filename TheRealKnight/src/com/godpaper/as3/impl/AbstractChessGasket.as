package com.godpaper.as3.impl
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.configs.GameConfig;
	import com.godpaper.as3.core.IChessGasket;
	import com.godpaper.as3.core.IChessPiece;
	import com.godpaper.as3.core.IXray;
	import com.godpaper.as3.model.ChessGasketsModel;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.views.components.ChessGasket;
	import com.godpaper.as3.views.components.ChessPiece;
	import com.lookbackon.ds.BitBoard;

	import flash.geom.Point;

	import mx.core.IUIComponent;
	import mx.events.DragEvent;
	import mx.events.FlexEvent;
	import mx.managers.DragManager;

	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;

	import spark.components.BorderContainer;
	import spark.events.ElementExistenceEvent;

	/**
	 * AbstractChessGasket.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jan 21, 2011 3:51:25 PM
	 */
	public class AbstractChessGasket extends BorderContainer implements IChessGasket,IXray
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		[Bindable]
		private var chessGasketsModel:ChessGasketsModel = ChessGasketsModel.getInstance();
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:Logger = LogContext.getLogger(AbstractChessGasket);
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		//----------------------------------
		//  position
		//----------------------------------
		private var _position:Point;

		public function get position():Point
		{
			return _position;
		}

		public function set position(value:Point):void
		{
			_position=value;
		}
		//----------------------------------
		//  chessPiece
		//----------------------------------
		private var _chessPiece:IChessPiece;

		public function get chessPiece():IChessPiece
		{
			return _chessPiece;
		}

		public function set chessPiece(value:IChessPiece):void
		{
			_chessPiece=value;
			//
			if (null != value)
			{
				this.addElement(value);
			}
			else
			{
				this.removeElementAt(0);
			}
		}
		//----------------------------------
		//  conductVO
		//----------------------------------
		private var _conductVO:ConductVO;

		public function get conductVO():ConductVO
		{
			return _conductVO;
		}
		//----------------------------------
		//  X-Ray properties
		//----------------------------------
		public function get bottomNode():ChessGasket
		{
			return chessGasketsModel.gaskets.gett(this.position.x,this.position.y+1) as ChessGasket;
		}

		public function get rightNode():ChessGasket
		{
			return chessGasketsModel.gaskets.gett(this.position.x+1,this.position.y) as ChessGasket;
		}

		public function get upNode():ChessGasket
		{
			return chessGasketsModel.gaskets.gett(this.position.x,this.position.y-1) as ChessGasket;
		}

		public function get leftNode():ChessGasket
		{
			return chessGasketsModel.gaskets.gett(this.position.x-1,this.position.y) as ChessGasket;
		}
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//-------------------------------------------------------------------------- 

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function AbstractChessGasket()
		{
			//TODO: implement function
			super();
			//
			this.addEventListener(FlexEvent.CREATION_COMPLETE,creationCompleteHandler);
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		//creationCompleteHandler
		protected function creationCompleteHandler(event:FlexEvent):void
		{
			// TODO Auto-generated method stub
			this.addEventListener(DragEvent.DRAG_ENTER, dragEnterHandler);
			this.addEventListener(DragEvent.DRAG_DROP, dragDropHandler);
			//once piece add or remove,maybe check event triggled.
			this.addEventListener(ElementExistenceEvent.ELEMENT_ADD, elementAddHandler);
			this.addEventListener(ElementExistenceEvent.ELEMENT_REMOVE, elementRemoveHandler);
		}

		//dragEnterHandler
		protected function dragEnterHandler(event:DragEvent):void
		{
			this._conductVO =new ConductVO();
			_conductVO.target=event.dragInitiator as IChessPiece;
			_conductVO.previousPosition=this.position;
			if (GameConfig.chessPieceManager.doMoveValidation(_conductVO))
			{
				DragManager.acceptDragDrop(event.currentTarget as IUIComponent);
				DragManager.showFeedback(DragManager.LINK);
			}
			// remove event listener
			//				this.removeEventListener(DragEvent.DRAG_ENTER,dragEnterHandler);
		}

		//dragDropHandler
		protected function dragDropHandler(event:DragEvent):void
		{
			this._conductVO=new ConductVO();
			_conductVO.target=event.dragInitiator as IChessPiece;
			_conductVO.previousPosition=(event.dragInitiator as ChessPiece).position;
			_conductVO.nextPosition=this.position;
			//apply move.
			GameConfig.chessPieceManager.applyMove(conductVO);
			//
			event.stopImmediatePropagation();
		}

		//
		protected function elementAddHandler(event:ElementExistenceEvent):void
		{
			LOG.debug("ElementExistenceEvent,element:{0},@index:{1}", event.element, event.index.toString());
			//renew ChessPiece's position.
			//				ChessPiece(event.element).position = this.position;
			//clear gasket indicate effect.
			var emptyLegalMoves:BitBoard=new BitBoard(9, 10);
			emptyLegalMoves.clear();
			//empty indicate effect.
			GameConfig.chessPieceManager.indicateGaskets(emptyLegalMoves);
		}

		//
		protected function elementRemoveHandler(event:ElementExistenceEvent):void
		{
			//
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}

}

