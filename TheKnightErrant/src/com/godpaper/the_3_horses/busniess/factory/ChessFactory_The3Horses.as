package com.godpaper.the_3_horses.busniess.factory
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.business.factory.ChessFactoryBase;
	import com.godpaper.as3.configs.BoardConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.consts.DefaultPiecesConstants;
	import com.godpaper.as3.core.IChessGasket;
	import com.godpaper.as3.core.IChessPiece;
	import com.godpaper.as3.core.IChessVO;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.model.vos.OmenVO;
	import com.godpaper.as3.views.components.ChessPiece;
	import com.godpaper.the_3_horses.model.vo.ChessVO_The3Horses;
	
	import flash.geom.Point;


	/**
	 * YourChessFacory.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Feb 25, 2011 12:37:46 PM
	 */   	 
	public class ChessFactory_The3Horses extends ChessFactoryBase
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
		public function ChessFactory_The3Horses()
		{
			//TODO: implement function
			super();
		}     	

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		//
//		override public function createChessGasket(position:Point):IChessGasket
//		{
//			//Return default chess gasket.
//			return super.createChessGasket(position);
//		}
		//
		override public function createChessPiece(position:Point, flag:uint=0):IChessPiece
		{
			//Your chess piece under construction.
			//custom define properties.
			switch (position.toString())
			{
				//about blue
				case "(x=0, y=1)":
				case "(x=0, y=3)":
				case "(x=0, y=5)":
					chessPieceLabel=DefaultPiecesConstants.BLUE.label;
					chessPieceValue=16+int(position.x);
					chessPieceType=DefaultConstants.BLUE;
					break;
				//about red
				case "(x=10, y=1)":
				case "(x=10, y=3)":
				case "(x=10, y=5)":
					chessPieceLabel=DefaultPiecesConstants.RED.label;
					chessPieceValue=8+int(position.x);
					chessPieceType=DefaultConstants.RED;
					break;
				default:
					return null;
					break;
			}
			//call super function.
			return super.createChessPiece(position,flag);
		}
		//
		override public function generateChessVO(conductVO:ConductVO):IChessVO
		{
			//Your ChessVO under construction.
			var oColIndex:int=conductVO.currentPosition.x;
			var oRowIndex:int=conductVO.currentPosition.y;
			var chessVO:IChessVO;
			// LOG.info(conductVO.dump());
			switch ((conductVO.target as ChessPiece).label)
			{
				case DefaultPiecesConstants.BLUE.label:
					chessVO=new ChessVO_The3Horses(BoardConfig.xLines,BoardConfig.yLines,oRowIndex, oColIndex,DefaultConstants.FLAG_BLUE);
					break;
				case DefaultPiecesConstants.RED.label:
					chessVO=new ChessVO_The3Horses(BoardConfig.xLines,BoardConfig.yLines, oRowIndex, oColIndex,DefaultConstants.FLAG_RED);
					break;
				default:
					break;
			}
			return chessVO;
		}
		//
		override public function generateOmenVO(conductVO:ConductVO):OmenVO
		{
			//Your omenVO under construction.
			var omenVO:OmenVO;
			//TODO:importance initialization.
			// LOG.info(omenVO.dump());
			switch ((conductVO.target as ChessPiece).label)
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

