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
package com.godpaper.the_go.business.factory
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.business.factory.ChessFactoryBase;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.consts.DefaultPiecesConstants;
	import com.godpaper.as3.core.IChessPiece;
	import com.godpaper.as3.core.IChessVO;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.model.vos.ColorPositionVO;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.model.vos.OmenVO;
	import com.godpaper.as3.views.components.ChessPiece;
	import com.godpaper.the_go.model.vo.ChessVO_TheGo;
	
	import flash.geom.Point;
	
	/**
	 * YourChessFactory.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Oct 10, 2012 1:35:01 PM
	 */   	 
	public class ChessFactory_TheGo extends ChessFactoryBase
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//with initialization
//		public static var dataProvider:Vector.<ColorPositionVO> = ChessFacotryHelper_ColorLines.randomColorfulPieces();
		public static var dataProvider:Vector.<ColorPositionVO>;
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
		public function ChessFactory_TheGo()
		{
			//TODO: implement function
			super();
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		override public function createChessPiece(position:Point, flag:uint=0):IChessPiece
		{
			//switch custom define properties.
			switch (position.toString())
			{
				//about blue
				case "(x=1, y=0)":
				case "(x=2, y=0)":
				case "(x=1, y=1)":
				case "(x=2, y=1)":
					chessPieceLabel=DefaultPiecesConstants.BLUE.label;
					chessPieceValue=16+int(position.x);
					chessPieceType=DefaultConstants.BLUE;
					break;
				//about red
				case "(x=1, y=2)":
				case "(x=2, y=2)":
				case "(x=1, y=3)":
				case "(x=2, y=3)":
					chessPieceLabel=DefaultPiecesConstants.RED.label;
					chessPieceValue=8+int(position.x);
					chessPieceType=DefaultConstants.RED;
					break;
				default:
					return null;
					break;
			}
			//call super functions.
			return super.createChessPiece(position,flag);
		}
		//
		override public function generateChessVO(conductVO:ConductVO):IChessVO
		{
			//TODO
			var oColIndex:int=conductVO.currentPosition.x;
			var oRowIndex:int=conductVO.currentPosition.y;
			var chessVO:IChessVO;
			//			LOG.info(conductVO.dump());
			switch ((conductVO.target as ChessPiece).name)
			{
				case DefaultPiecesConstants.BLUE.label:
					chessVO=new ChessVO_TheGo(4,4,oRowIndex, oColIndex,DefaultConstants.FLAG_BLUE);
					break;
				case DefaultPiecesConstants.RED.label:
					chessVO=new ChessVO_TheGo(4, 4, oRowIndex, oColIndex,DefaultConstants.FLAG_RED);
					break;
				default:
					break;
			}
			return chessVO;
		}
		//
		override public function generateOmenVO(conductVO:ConductVO):OmenVO
		{
			var omenVO:OmenVO;
			//TODO:importance initialization.
			//			LOG.info(omenVO.dump());
			switch ((conductVO.target as ChessPiece).name)
			{
				case DefaultPiecesConstants.BLUE.label:
					omenVO=new OmenVO(DefaultPiecesConstants.BLUE_BISHOP.strength, DefaultPiecesConstants.BLUE.important, conductVO.target.chessVO.moves.celled, conductVO.target.chessVO.captures.celled, -1);
					break;
				case DefaultPiecesConstants.RED.label:
					omenVO=new OmenVO(DefaultPiecesConstants.RED_BISHOP.strength, DefaultPiecesConstants.RED.important, conductVO.target.chessVO.moves.celled, conductVO.target.chessVO.captures.celled, -1);
					break;
				default:
					break;
			}
			return omenVO;
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