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
			var west:BitBoard = getWestOccuipies(rowIndex, colIndex, rowMax, colMax);
			var north:BitBoard = getNorthOccuipies(rowIndex, colIndex, rowMax, colMax);
			var east:BitBoard = getEastOccuipies(rowIndex, colIndex, rowMax, colMax);
			var south:BitBoard = getSouthOccuipies(rowIndex, colIndex, rowMax, colMax);
			var bb:BitBoard = west.or(north.or(east.or(south)));
			return bb;
		}
		//
		public static function getBishopOccupies(rowIndex:int, colIndex:int, rowMax:int, colMax:int):BitBoard
		{
			var westNorth:BitBoard = getWestNorthOccuipies(rowIndex, colIndex, rowMax, colMax);
			var eastNorth:BitBoard = getEastNorthOccuipies(rowIndex, colIndex, rowMax, colMax);
			var eastSouth:BitBoard = getEastSouthOccuipies(rowIndex, colIndex, rowMax, colMax);
			var westSouth:BitBoard = getWestSouthOccuipies(rowIndex, colIndex, rowMax, colMax);
			var bb:BitBoard = westNorth.or(eastNorth.or(eastSouth.or(westSouth)));
			return bb;
		}
		//@see http://en.wikipedia.org/wiki/Chess
		public static function getQueenOccupies(rowIndex:int, colIndex:int, rowMax:int, colMax:int):BitBoard
		{
			return getRookOccupies(rowIndex, colIndex, rowMax, colMax).or(getBishopOccupies(rowIndex, colIndex, rowMax, colMax));
		}
		//----------------------------------
		//  X-ray style
		// @see http://chessprogramming.wikispaces.com/X-ray+Attacks+%28Bitboards%29
		//----------------------------------
		//west
		public static function getWestOccuipies(rowIndex:int, colIndex:int, rowMax:int, colMax:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(colMax,rowMax);
			var west:int = colIndex;
			while(west)
			{
				bb.setBitt(rowIndex,west,true);
				west--;
			}
			return bb;
		}
		//north
		public static function getNorthOccuipies(rowIndex:int, colIndex:int, rowMax:int, colMax:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(colMax,rowMax);
			var north:int = rowIndex;
			while(north)
			{
				bb.setBitt(north,colIndex,true);
				north--;
			}
			return bb;
		}
		//east
		public static function getEastOccuipies(rowIndex:int, colIndex:int, rowMax:int, colMax:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(colMax,rowMax);
			var east:int = 0;
			while(east<colMax)
			{
				bb.setBitt(rowIndex,east,true);
				east++;
			}
			return bb;
		}
		//south
		public static function getSouthOccuipies(rowIndex:int, colIndex:int, rowMax:int, colMax:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(colMax,rowMax);
			var south:int = 0;
			while(south<rowIndex)
			{
				bb.setBitt(south,colIndex,true);
				south++;
			}
			return bb;
		}
		//westNorth
		public static function getWestNorthOccuipies(rowIndex:int, colIndex:int, rowMax:int, colMax:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(colMax,rowMax);
			for(var i:int=rowIndex;i>0;i--)
			{
				if(colIndex-i)
				{
					bb.setBitt(rowIndex-i,colIndex-i,true);
				}
			}
			return bb;
		}
		//eastNorth
		public static function getEastNorthOccuipies(rowIndex:int, colIndex:int, rowMax:int, colMax:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(colMax,rowMax);
			for(var i:int=rowIndex;i>0;i--)
			{
				if(colIndex+i<colMax)
				{
					bb.setBitt(rowIndex-i,colIndex+i,true);
				}
			}
			return bb;
		}
		//eastSouth
		public static function getEastSouthOccuipies(rowIndex:int, colIndex:int, rowMax:int, colMax:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(colMax,rowMax);
			var len:int = rowMax-rowIndex;
			for(var i:int=0;i<len;i++)
			{
				if(colIndex+i<colMax)
				{
					bb.setBitt(rowIndex+i,colIndex+i,true);
				}
			}
			return bb;
		}
		//westSouth
		public static function getWestSouthOccuipies(rowIndex:int, colIndex:int, rowMax:int, colMax:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(colMax,rowMax);
			var len:int = rowMax-rowIndex;
			for(var i:int=0;i<len;i++)
			{
				if(colIndex-i)
				{
					bb.setBitt(rowIndex+i,colIndex-i,true);
				}
			}
			return bb;
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}
	
}