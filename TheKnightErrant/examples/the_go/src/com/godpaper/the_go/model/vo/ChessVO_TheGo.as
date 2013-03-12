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
package com.godpaper.the_go.model.vo
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.configs.BoardConfig;
	import com.godpaper.as3.impl.AbstractChessVO;
	import com.godpaper.as3.utils.LogUtil;
	import com.lookbackon.ds.BitBoard;
	
	import mx.logging.ILogger;
	
	
	/**
	 * YourChessVO.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Oct 10, 2012 1:36:02 PM
	 */   	 
	public class ChessVO_TheGo extends AbstractChessVO
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(ChessVO_TheGo);
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
		public function ChessVO_TheGo(width:int, height:int, rowIndex:int, colIndex:int, flag:uint=0, identifier:String="")
		{
			super(width, height, rowIndex, colIndex, flag, identifier);
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		override public function initialization(rowIndex:int, colIndex:int, flag:uint=0, identifier:String=""):void
		{
			//Define chess occupy/move/capture even defend bitboard here.
			//@see http://www.godpaper.com/godpaper/index.php/%E5%B0%8F%E7%A0%96%E6%A0%BC%E6%A3%8B
			// *
			// *s*
			// *
			//Notice:Don't worry about bitboard over-fence issues,that it wouble be handle it as default.
			//about occupies.set all cells on this big triangle.
			for(var row:int=0;row<chessGasketModel.gaskets.height;row++)
			{
				for(var col:int=0;col<chessGasketModel.gaskets.width;col++)
				{
					if(chessGasketModel.gaskets.gett(col,row))
					{
						if(rowIndex==-1 && colIndex==-1)
						{
							this.occupies.setBitt(row,col,true);
						}
					}
				}
			}
			LOG.info("occupies:{0}",this.occupies.dump());
			//about legal moves.
			LOG.info("allPieces:{0}",chessPiecesModel.allPieces.dump());
			this.moves = this.occupies.xor(this.occupies.and(chessPiecesModel.allPieces));
			//
			LOG.info("moves:{0}",this.moves.dump());
			//blocker
			//about attacked captures.
//			this.captures = new BitBoard(BoardConfig.xLines,BoardConfig.yLines);
			//about defends.
		}
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}
	
}