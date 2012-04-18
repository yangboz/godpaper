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
package com.godpaper.starling.views.components
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.configs.PieceConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.core.IPiecesBox;
	import com.godpaper.as3.model.pools.BlueChessPiecesPool;
	import com.godpaper.as3.model.pools.RedChessPiecesPool;
	
	import flash.geom.Rectangle;
	
	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	
	/**
	 * A pieces box is defined by a number of piece items that represents slots for movable chess pieces.  	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Apr 18, 2012 9:54:47 AM
	 */   	 
	public class PiecesBox extends Sprite implements IPiecesBox
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var _type:String;
		private var _childrenArea:Rectangle;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:Logger = LogContext.getLogger(PiecesBox);
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
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
		public function PiecesBox()
		{
			super();
			//
			this.addEventListener(Event.COMPLETE, creationCompleteHandler);
			//
			_childrenArea = new Rectangle(0,0,this.width,this.height);
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
		protected function creationCompleteHandler(event:Event):void
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