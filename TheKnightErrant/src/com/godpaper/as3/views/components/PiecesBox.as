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
package com.godpaper.as3.views.components
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.business.fsm.ChessAgent;
	import com.godpaper.as3.configs.PieceConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.core.IPiecesBox;
	import com.godpaper.as3.model.pools.BlueChessPiecesPool;
	import com.godpaper.as3.model.pools.RedChessPiecesPool;
	import com.godpaper.as3.utils.LogUtil;
	
	import flash.display.Shape;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.logging.ILogger;
	
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.textures.Texture;
	import starling.utils.Color;
	import starling.utils.Polygon;
	
	
	/**
	 * A pieces box is defined by a number of piece items that represents slots for movable chess pieces.  	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Apr 18, 2012 9:54:47 AM
	 * @history,using the starling(stage3d) version.
	 */   	 
	public class PiecesBox extends ChessGasket implements IPiecesBox
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var _type:String;
		private var _childrenArea:Rectangle;
		private var _chessPieces:Vector.<ChessPiece> = new Vector.<ChessPiece>();
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(PiecesBox);
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		//----------------------------------
		//  position
		//----------------------------------
		override public function get position():Point
		{
			return new Point(-1,-1);;
		}
		//----------------------------------
		//  type(RED/BLUE...)
		//----------------------------------
		public function get type():String
		{
			return _type;
		}
		
		public function set type(value:String):void
		{
			_type=value;
		}
		//----------------------------------
		//  childrenArea
		//----------------------------------
		public function get childrenArea():Rectangle
		{
			return _childrenArea;
		}
		
		public function set childrenArea(value:Rectangle):void
		{
			_childrenArea = value;
		}
		//----------------------------------
		//  chessPieces
		//----------------------------------
		public function get chessPieces():Vector.<ChessPiece>
		{
			return _chessPieces;
		}
		
		public function set chessPieces(value:Vector.<ChessPiece>):void
		{
			_chessPieces = value;
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
		public function PiecesBox(upState:Texture=null)
		{
			super(upState);
			//
//			this.addEventListener(Event.COMPLETE, creationCompleteHandler);
			this.addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			//
			_childrenArea = new Rectangle(0,0,this.width,this.height);
		}
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		override public function dispose():void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			super.dispose();
		}//
		//
		override public function toString():String
		{
			return "PiecesBox:#".concat(this.type,",pieces:",this.chessPieces.length);
		}
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
//		protected function creationCompleteHandler(event:Event):void
		override protected function addToStageHandler(event:Event):void
		{
			if (PieceConfig.bluePieces.length)
			{
				if (type == DefaultConstants.BLUE)
				{
					BlueChessPiecesPool.initialize(PieceConfig.maxPoolSizeBlue, PieceConfig.growthValue);
					//store this reference
					PieceConfig.bluePiecesBox = this;
				}
			}
			if (PieceConfig.redPieces.length)
			{
				if (type == DefaultConstants.RED)
				{
					RedChessPiecesPool.initialize(PieceConfig.maxPoolSizeRed, PieceConfig.growthValue);
					//store this reference
					PieceConfig.redPiecesBox = this;
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