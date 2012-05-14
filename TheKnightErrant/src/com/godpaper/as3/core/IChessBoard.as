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
package com.godpaper.as3.core
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import starling.display.Image;

	/**
	 * A chess board is defined by a number of rows and columns, which may vary for different application levels. 
	 * Chess board types(Bitboard,NumberBoard,GraphBoard,ArrayBoard...) 	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Apr 19, 2012 5:46:39 PM
	 */
	public interface IChessBoard extends IType
	{
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		//----------------------------------
		//  background(CrossLines or Embbed image textures)
		//----------------------------------
		function set background(value:Image):void;
		function get background():Image;
		//----------------------------------
		//  yAdjust(for pixel adjustment at y axis)
		//----------------------------------
		function get yAdjust():Number;
		function set yAdjust(value:Number):void;
		//----------------------------------
		//  xAdjust(for pixel adjustment at x axis)
		//----------------------------------
		function get xAdjust():Number;
		function set xAdjust(value:Number):void;
		//----------------------------------
		//  height(the height of ChessBoard)
		//----------------------------------
		function get height():Number;
		function set height(value:Number):void;
		//----------------------------------
		//  width(the width of ChessBoard)
		//----------------------------------
		function get width():Number;
		function set width(value:Number):void;
		//----------------------------------
		//  yOffset(the lattice of ChessBoard at y axis)
		//----------------------------------
		function get yOffset():Number;
		function set yOffset(value:Number):void;
		//----------------------------------
		//  xOffset(the lattice of ChessBoard at x axis)
		//----------------------------------
		function get xOffset():Number;
		function set xOffset(value:Number):void;
		//----------------------------------
		//  yScale(the scale rate of ChessBoard at y axis)
		//----------------------------------
		function get yScale():Number;
		function set yScale(value:Number):void;
		//----------------------------------
		//  xScale(the scale rate of ChessBoard at x axis)
		//----------------------------------
		function get xScale():Number;
		function set xScale(value:Number):void;
		//----------------------------------
		//  yLines(the number of lines displayed on ChessBoard at y axis)
		//----------------------------------
		function get yLines():Number;
		function set yLines(value:Number):void;
		//----------------------------------
		//  xLines(the number of lines displayed on ChessBoard at x axis)
		//----------------------------------
		function get xLines():Number;
		function set xLines(value:Number):void;
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