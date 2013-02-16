/**
 *  GODPAPER Confidential,Copyright 2013. All rights reserved.
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
package com.godpaper.as3.utils
{
	import com.lookbackon.ds.BitBoard;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * BitBoardUtil.as class. Esp for bishop/rook/queen move generation 	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Feb 16, 2013 11:03:31 PM
	 */   	 
	public class BitBoardUtil
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
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		//
		public static function getRookOccupies(rowIndex:int, colIndex:int, rowMax:int, colMax:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(colMax,rowMax);
			//TODO:
			return bb;
		}
		//
		public static function getBishopOccupies(rowIndex:int, colIndex:int, rowMax:int, colMax:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(colMax,rowMax);
			//TODO:
			return bb;
		}
		//@see http://en.wikipedia.org/wiki/Chess
		public static function getQueenOccupies(rowIndex:int, colIndex:int, rowMax:int, colMax:int):BitBoard
		{
			return getRookOccupies(rowIndex, colIndex).or(getBishopOccupies(rowIndex, colIndex));
		}
		//----------------------------------
		//  X-ray style
		// @see http://chessprogramming.wikispaces.com/X-ray+Attacks+%28Bitboards%29
		//----------------------------------
		//west
		public static function getWestOccuipies(rowIndex:int, colIndex:int, rowMax:int, colMax:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			return bb;
		}
		//north
		public static function getNorthOccuipies(rowIndex:int, colIndex:int, rowMax:int, colMax:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			return bb;
		}
		//east
		public static function getEastOccuipies(rowIndex:int, colIndex:int, rowMax:int, colMax:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			return bb;
		}
		//south
		public static function getSouthOccuipies(rowIndex:int, colIndex:int, rowMax:int, colMax:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			return bb;
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}
	
}