/**
 *  GODPAPER Confidential,Copyright 2012. All rights reserved.
 *
 *  Permission is hereby granted, free of charge, to any person obtaining
 *  a copy of this software and associated documentation files (the "Software"),
 *  to deal in the Software without restriction, including without limitation
 *  the rights to use, copy, modify, merge, publish, distribute, sub-license,
 *  and/or sell copies of the Software, and to permit persons to whom the
 *  Software is furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included
 *  in all copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 *  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 *  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
 *  IN THE SOFTWARE.
 */
package com.godpaper.starling.views.impl
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.configs.BoardConfig;
	import com.godpaper.as3.configs.GameConfig;
	import com.godpaper.as3.core.IChessGasket;
	import com.godpaper.as3.core.IChessPiece;
	import com.godpaper.as3.model.ChessGasketsModel;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.lookbackon.ds.BitBoard;
	
	import flash.geom.Point;
	
	import org.osmf.logging.Logger;
	import org.spicefactory.lib.logging.LogContext;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	
	/**
	 * The chess gasket stores chess pieces, and each chess gasket’s space can contain more than one chess piece.  	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Apr 18, 2012 9:47:38 AM
	 */   	 
	public class ChessGasket extends Button implements IChessGasket
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var chessGasketsModel:ChessGasketsModel = ChessGasketsModel.getInstance();
		private var chessPiecesModel:ChessPiecesModel = ChessPiecesModel.getInstance();
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:Logger = LogContext.getLogger(ChessGasket);
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
				this.addChild(value);
			}
			else
			{
				this.removeChild(0);
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
		//		public function get bottomNode():ChessGasket
		//		{
		//			return chessGasketsModel.gaskets.gett(this.position.x,this.position.y+1) as ChessGasket;
		//		}
		//
		//		public function get rightNode():ChessGasket
		//		{
		//			return chessGasketsModel.gaskets.gett(this.position.x+1,this.position.y) as ChessGasket;
		//		}
		//
		//		public function get upNode():ChessGasket
		//		{
		//			return chessGasketsModel.gaskets.gett(this.position.x,this.position.y-1) as ChessGasket;
		//		}
		//
		//		public function get leftNode():ChessGasket
		//		{
		//			return chessGasketsModel.gaskets.gett(this.position.x-1,this.position.y) as ChessGasket;
		//		}
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
		public function ChessGasket(upState:Texture, text:String="", downState:Texture=null)
		{
			super(upState, text, downState);
			//
			this.addEventListener(Event.COMPLETE,creationCompleteHandler);
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
		protected function creationCompleteHandler(event:Event):void
		{
			// event listener method stub
			//			this.addEventListener(TouchEvent.TOUCH, dragEnterHandler);
			//			this.addEventListener(TouchEvent.TOUCH, dragDropHandler);
			this.addEventListener(TouchEvent.TOUCH,touchHandler);
			//once piece add or remove,maybe check event triggled.
			this.addEventListener(Event.ADDED_TO_STAGE, elementAddHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE, elementRemoveHandler);
			this.addEventListener(Event.TRIGGERED,mouseClickHandler);
		}
		//dragEnterHandler
		protected function dragEnterHandler(event:TouchEvent):void
		{
			this._conductVO =new ConductVO();
			_conductVO.target=event.target as IChessPiece;
			_conductVO.previousPosition=(event.target as ChessPiece).position;
			_conductVO.nextPosition=this.position;
			//do move validation
			if (GameConfig.chessPieceManager.doMoveValidation(_conductVO))
			{
//				DragManager.acceptDragDrop(event.currentTarget as IUIComponent);
//				DragManager.showFeedback(DragManager.LINK);
			}
			// remove event listener
			//				this.removeEventListener(DragEvent.DRAG_ENTER,dragEnterHandler);
		}
		
		//dragDropHandler
		protected function dragDropHandler(event:TouchEvent):void
		{
			this._conductVO=new ConductVO();
			_conductVO.target=event.target as IChessPiece;
			_conductVO.previousPosition=(event.target as ChessPiece).position;
			_conductVO.nextPosition=this.position;
			//apply move.
			GameConfig.chessPieceManager.applyMove(conductVO);
			//
			event.stopImmediatePropagation();
		}
		
		//
		protected function elementAddHandler(event:Event):void
		{
			LOG.debug("ElementExistenceEvent,element:{0}", event.target);
			//renew ChessPiece's position.
			//				ChessPiece(event.element).position = this.position;
			//clear gasket indicate effect.
			var emptyLegalMoves:BitBoard=new BitBoard(BoardConfig.xLines, BoardConfig.yLines);
			emptyLegalMoves.clear();
			//empty indicate effect.
			GameConfig.chessPieceManager.indicateGasketsMove(emptyLegalMoves);
		}
		
		//
		protected function elementRemoveHandler(event:Event):void
		{
			//
		}
		
		//mouseClickHandler
		protected function mouseClickHandler(event:TouchEvent):void
		{
			if(chessPiecesModel.selectedPiece)
			{
				this._conductVO=new ConductVO();
				_conductVO.target= chessPiecesModel.selectedPiece;
				_conductVO.previousPosition= chessPiecesModel.selectedPiece.position;
				_conductVO.nextPosition=this.position;
				//do move validation
				if (GameConfig.chessPieceManager.doMoveValidation(_conductVO))
				{
					//apply move.
					GameConfig.chessPieceManager.applyMove(conductVO);
				}
			}
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		private function touchHandler(event:TouchEvent):void
		{
			const touch:Touch = event.getTouch(this);
			//
			this.x = touch.globalX;
			this.y = touch.globalY;
			switch(touch.phase)
			{
				case TouchPhase.BEGAN:
					//delegate to drag enter handler
					dragEnterHandler(event);
					break;
				case TouchPhase.HOVER:
					break;
				case TouchPhase.MOVED:
					
					break;
				case TouchPhase.ENDED:
					//delegate to drag drop handler
					dragDropHandler(event);
					break;
				case TouchPhase.STATIONARY:
					//delegate to mouse click handler
					mouseClickHandler(event);
					break;
				default:
					break;
			}
		}
	}
	
}