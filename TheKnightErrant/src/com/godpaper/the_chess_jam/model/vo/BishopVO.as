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
package com.godpaper.the_chess_jam.model.vo
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.impl.AbstractChessVO;
	import com.godpaper.as3.utils.BitBoardUtil;
	import com.godpaper.as3.utils.LogUtil;
	import com.lookbackon.ds.BitBoard;
	
	import mx.logging.ILogger;
	
	
	/**
	 * BishopVO.as class.X-Ray attacks.
	 * @see http://chessprogramming.wikispaces.com/X-ray+Attacks+%28Bitboards%29   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Feb 16, 2013 12:52:19 AM
	 */   	 
	public class BishopVO extends AbstractChessVO
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(BishopVO);
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
		public function BishopVO(width:int, height:int, rowIndex:int, colIndex:int, flag:uint=1, identifier:String="")
		{
			super(width, height, rowIndex, colIndex, flag, identifier);
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		/**
		 * @inheritDoc
		 */
		override public function initialization(rowIndex:int, colIndex:int, flag:uint=0, identifier:String=""):void
		{
			// * - *
			// - * -
			// * - *
			//about occupies on diagonal direction.
			this.occupies = BitBoardUtil.getBishopOccupies(rowIndex,colIndex,this.row,this.column);
//			LOG.info("occupies:{0}",this.occupies.dump());
			//serveral admental
			//about legal moves.
			//			LOG.info("redPieces:{0}",ChessPositionModelLocator.getInstance().redPieces.dump());
			//			LOG.info("bluePieces:{0}",ChessPositionModelLocator.getInstance().bluePieces.dump());
			//			LOG.info("moves:{0}",this.moves.dump());
			//blocker
			//
			blocker = this.occupies.xor(this.moves);
			//			trace("blocker.reverse():",blocker.reverse().dump());
			
			LOG.debug("blocker.isEmpty:{0}",blocker.isEmpty.toString());
			if(!blocker.isEmpty)
			{
				LOG.debug("blocker:{0}",blocker.dump());
				//
				var eastNorth:BitBoard = this.getEastNorth(rowIndex,colIndex);
				var eastSouth:BitBoard = this.getEastSouth(rowIndex,colIndex);
				var westNorth:BitBoard = this.getWestNorth(rowIndex,colIndex);
				var westSouth:BitBoard = this.getWestSouth(rowIndex,colIndex);
				LOG.debug("eastNorth:{0}",eastNorth.dump());
				LOG.debug("eastSouth:{0}",eastSouth.dump());
				LOG.debug("westNorth:{0}",westNorth.dump());
				LOG.debug("westSouth:{0}",westSouth.dump());
				this.moves = eastNorth.or(eastSouth.or(westNorth.or(westSouth)));
				LOG.debug("moves:{0}",this.moves.dump());
			}
			//about attacked captures.
			if(flag==DefaultConstants.FLAG_RED)
			{
				this.moves = this.occupies.xor(this.occupies.and(chessPiecesModel.redPieces));
			}
			if(flag==DefaultConstants.FLAG_BLUE)
			{
				this.moves = this.occupies.xor(this.occupies.and(chessPiecesModel.bluePieces));
			}
			//about attacked captures.
			if(flag==DefaultConstants.FLAG_RED)
			{
				this.captures = this.moves.and(chessPiecesModel.bluePieces);
			}
			if(flag==DefaultConstants.FLAG_BLUE)
			{
				this.captures = this.moves.and(chessPiecesModel.redPieces);
			}
			//
			LOG.debug("occupies:{0}",this.occupies.dump());
			LOG.debug("moves:{0}",this.moves.dump());
			LOG.debug("captures:{0}",this.captures.dump());
		}
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		protected function getEastNorth(rowIndex:int, colIndex:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			//east north
			var en:int = 1;
			while(rowIndex-en)
			{
				if(colIndex+en<this.column)
				{
					if(chessPiecesModel.bluePieces.getBitt(rowIndex-en,colIndex+en)) break;
					if(chessPiecesModel.redPieces.getBitt(rowIndex-en,colIndex+en)) break;
					//
					this.occupies.setBitt(rowIndex-en,colIndex+en,true);
				}else
				{
					break;
				}
				en++;
			}
			//
			return bb;
		}
		//
		protected function getEastSouth(rowIndex:int, colIndex:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			//east south
			var es:int = 1;
			while((this.row-es)>rowIndex)
			{
				if(colIndex+es<this.column)
				{
					if(chessPiecesModel.bluePieces.getBitt(rowIndex+es,colIndex+es)) break;
					if(chessPiecesModel.redPieces.getBitt(rowIndex+es,colIndex+es)) break;
					//
					this.occupies.setBitt(rowIndex+es,colIndex+es,true);
				}else
				{
					break;
				}
				es++;
			}
			//
			return bb;
		}
		//
		protected function getWestNorth(rowIndex:int, colIndex:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			//west north
			var wn:int = 1;
			while(rowIndex-wn)
			{
				if(colIndex-wn)
				{
					if(chessPiecesModel.bluePieces.getBitt(rowIndex-wn,colIndex-wn)) break;
					if(chessPiecesModel.redPieces.getBitt(rowIndex-wn,colIndex-wn)) break;
					//
					this.occupies.setBitt(rowIndex-wn,colIndex-wn,true);
				}else
				{
					break;
				}
				wn++;
			}
			//
			return bb;
		}
		//
		protected function getWestSouth(rowIndex:int, colIndex:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			//west south
			var ws:int = 1;
			while((this.row-ws)>rowIndex)
			{
				if(colIndex-ws)
				{
					if(chessPiecesModel.bluePieces.getBitt(rowIndex+ws,colIndex-ws)) break;
					if(chessPiecesModel.redPieces.getBitt(rowIndex+ws,colIndex-ws)) break;
					//
					this.occupies.setBitt(rowIndex+ws,colIndex-ws,true);
				}else
				{
					break;
				}
				ws++;
			}
			//
			return bb;
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}
	
}