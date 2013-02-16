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
	import com.godpaper.as3.utils.LogUtil;
	
	import mx.logging.ILogger;
	
	
	/**
	 * MarshalVO.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Feb 16, 2013 12:53:34 AM
	 */   	 
	public class MarshalVO extends AbstractChessVO
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(MarshalVO);
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
		public function MarshalVO(width:int, height:int, rowIndex:int, colIndex:int, flag:uint=1, identifier:String="")
		{
			//TODO: implement function
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
			// * - -
			// - - -
			// - - *
			//about occupies.
			//serveral admental(象田心问题，象过河问题)
			if(!chessPiecesModel.allPieces.getBitt(rowIndex+1,colIndex+1))
			{
				//serveral admental(象过河问题)
				if(flag==DefaultConstants.FLAG_BLUE)
				{
					if(rowIndex<4)
					{
						this.occupies.setBitt(rowIndex+2,colIndex+2,true);
					}
				}else
				{
					this.occupies.setBitt(rowIndex+2,colIndex+2,true);
				}
			}
			if(!chessPiecesModel.allPieces.getBitt(rowIndex+1,colIndex-1))
			{
				//serveral admental(象过河问题)
				if(flag==DefaultConstants.FLAG_BLUE)
				{
					if(rowIndex<4)
					{
						this.occupies.setBitt(rowIndex+2,colIndex-2,true);
					}
				}else
				{
					this.occupies.setBitt(rowIndex+2,colIndex-2,true);
				}
			}
			if(!chessPiecesModel.allPieces.getBitt(rowIndex-1,colIndex+1))
			{
				//serveral admental(象过河问题)
				if(flag==DefaultConstants.FLAG_RED)
				{
					if(rowIndex>5)
					{
						this.occupies.setBitt(rowIndex-2,colIndex+2,true);
					}
				}else
				{
					this.occupies.setBitt(rowIndex-2,colIndex+2,true);
				}
			}
			if(!chessPiecesModel.allPieces.getBitt(rowIndex-1,colIndex-1))
			{
				//serveral admental(象过河问题)
				if(flag==DefaultConstants.FLAG_RED)
				{
					if(rowIndex>5)
					{
						this.occupies.setBitt(rowIndex-2,colIndex-2,true);
					}
				}else
				{
					this.occupies.setBitt(rowIndex-2,colIndex-2,true);
				}
			}
			//about legal moves.
			//			LOG.info("redPieces:{0}",ChessPositionModelLocator.getInstance().redPieces.dump());
			//			LOG.info("bluePieces:{0}",ChessPositionModelLocator.getInstance().bluePieces.dump());
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
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}
	
}