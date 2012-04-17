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
	import com.godpaper.as3.business.fsm.ChessAgent;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.model.vos.OmenVO;
	import com.godpaper.as3.core.IChessPiece;
	import com.godpaper.as3.core.IChessVO;
	import com.godpaper.starling.views.components.RoundButton;
	
	import flash.geom.Point;
	
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.textures.Texture;
	
	/**
	 * AbstractChessPiece.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Apr 16, 2012 3:17:37 PM
	 */   	 
	public class AbstractChessPiece extends RoundButton implements IChessPiece
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		
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
		public function AbstractChessPiece(upState:Texture, text:String="", downState:Texture=null)
		{
			//TODO: implement function
			super(upState, text, downState);
			//
			this.addEventListener(Event.COMPLETE,creationCompleteHandler);
		}
		
		public function set agent(value:ChessAgent):void
		{
			//TODO: implement function
		}
		
		public function get agent():ChessAgent
		{
			//TODO: implement function
			return null;
		}
		
		public function set chessVO(value:IChessVO):void
		{
			//TODO: implement function
		}
		
		public function get chessVO():IChessVO
		{
			//TODO: implement function
			return null;
		}
		
		public function set omenVO(value:OmenVO):void
		{
			//TODO: implement function
		}
		
		public function get omenVO():OmenVO
		{
			//TODO: implement function
			return null;
		}
		
		public function set position(value:Point):void
		{
			//TODO: implement function
		}
		
		public function get position():Point
		{
			//TODO: implement function
			return null;
		}
		
		public function set type(value:String):void
		{
			//TODO: implement function
		}
		
		public function get type():String
		{
			//TODO: implement function
			return null;
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
			// event listener method stub
			this.addEventListener(TouchEvent.TOUCH, dragEnterHandler);
			this.addEventListener(TouchEvent.TOUCH, dragDropHandler);
			//once piece add or remove,maybe check event triggled.
			this.addEventListener(Event.ADDED_TO_STAGE, elementAddHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE, elementRemoveHandler);
			//
			this.addEventListener(Event.TRIGGERED, mouseClickHandler);
		}
		
		//dragEnterHandler
		protected function dragEnterHandler(event:DragEvent):void
		{
			this._conductVO =new ConductVO();
			_conductVO.target=event.dragInitiator as IChessPiece;
			_conductVO.previousPosition=(event.dragInitiator as ChessPiece).position;
			_conductVO.nextPosition=this.position;
			//do move validation
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
			var emptyLegalMoves:BitBoard=new BitBoard(BoardConfig.xLines, BoardConfig.yLines);
			emptyLegalMoves.clear();
			//empty indicate effect.
			GameConfig.chessPieceManager.indicateGasketsMove(emptyLegalMoves);
		}
		
		//
		protected function elementRemoveHandler(event:ElementExistenceEvent):void
		{
			//
		}
		
		//mouseClickHandler
		protected function mouseClickHandler(event:MouseEvent):void
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
	}
	
}