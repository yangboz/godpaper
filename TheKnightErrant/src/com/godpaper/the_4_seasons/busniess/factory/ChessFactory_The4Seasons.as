package com.godpaper.the_4_seasons.busniess.factory
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
	import com.godpaper.the_4_seasons.consts.ChessPiecesConsts_The4Seasons;
	import com.godpaper.the_4_seasons.model.vo.ChessVO_The4Seasons;
	
	import flash.geom.Point;
	
	import starling.textures.TextureAtlas;


	/**
	 * YourChessFacory.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Feb 25, 2011 12:37:46 PM
	 */   	 
	public class ChessFactory_The4Seasons extends ChessFactoryBase
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
		public function ChessFactory_The4Seasons()
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
		override public function createChessPiece(position:Point, flag:int=0):IChessPiece
		{
			//Your chess piece under construction.
			//custom define properties.
			switch (position.toString())
			{
				//about blue
				case "(x=0, y=0)":
					chessPieceLabel=DefaultPiecesConstants.BLUE.label;
					chessPieceValue=16+int(position.x);
					chessPieceType=DefaultConstants.BLUE;
//					this.chessPieceSource = EmbededAssets.SPRING;
					chessPieceSubType = this.chessPieceName = ChessPiecesConsts_The4Seasons.NAME_SPRING;
					break;
				case "(x=8, y=0)":
					chessPieceLabel=DefaultPiecesConstants.BLUE.label;
					chessPieceValue=16+int(position.x);
					chessPieceType=DefaultConstants.BLUE;
//					this.chessPieceSource = EmbededAssets.SUMMER;
					chessPieceSubType = this.chessPieceName = ChessPiecesConsts_The4Seasons.NAME_SUMMER;
					break;
				//about red
				case "(x=0, y=8)":
					chessPieceLabel=DefaultPiecesConstants.RED.label;
					chessPieceValue=8+int(position.x);
					chessPieceType=DefaultConstants.RED;
//					this.chessPieceSource = EmbededAssets.WINTER;
					chessPieceSubType = this.chessPieceName = ChessPiecesConsts_The4Seasons.NAME_WINTER;
					break;
				case "(x=8, y=8)":
					chessPieceLabel=DefaultPiecesConstants.RED.label;
					chessPieceValue=8+int(position.x);
					chessPieceType=DefaultConstants.RED;
//					this.chessPieceSource = EmbededAssets.AUTUMN;
					chessPieceSubType = this.chessPieceName = ChessPiecesConsts_The4Seasons.NAME_AUTUMN;
					break;
				default:
					return null;
					break;
			}
//			//custom define view.
			var atlas:TextureAtlas = AssetEmbedsDefault.getTextureAtlas();
			this.chessPieceSource = atlas.getTexture(chessPieceType);
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
			switch ((conductVO.target as ChessPiece).name)
			{
				case ChessPiecesConsts_The4Seasons.NAME_SPRING:
					chessVO=new ChessVO_The4Seasons(BoardConfig.xLines,BoardConfig.yLines,oRowIndex, oColIndex,DefaultConstants.FLAG_BLUE,ChessPiecesConsts_The4Seasons.NAME_SPRING);
					break;
				case ChessPiecesConsts_The4Seasons.NAME_SUMMER:
					chessVO=new ChessVO_The4Seasons(BoardConfig.xLines,BoardConfig.yLines,oRowIndex, oColIndex,DefaultConstants.FLAG_BLUE,ChessPiecesConsts_The4Seasons.NAME_SUMMER);
					break;
				case ChessPiecesConsts_The4Seasons.NAME_AUTUMN:
					chessVO=new ChessVO_The4Seasons(BoardConfig.xLines,BoardConfig.yLines, oRowIndex, oColIndex,DefaultConstants.FLAG_RED,ChessPiecesConsts_The4Seasons.NAME_AUTUMN);
					break;
				case ChessPiecesConsts_The4Seasons.NAME_WINTER:
					chessVO=new ChessVO_The4Seasons(BoardConfig.xLines,BoardConfig.yLines, oRowIndex, oColIndex,DefaultConstants.FLAG_RED,ChessPiecesConsts_The4Seasons.NAME_WINTER);
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
			switch ((conductVO.target as ChessPiece).name)
			{
				case ChessPiecesConsts_The4Seasons.NAME_SPRING:
				case ChessPiecesConsts_The4Seasons.NAME_SUMMER:	
					omenVO=new OmenVO(DefaultPiecesConstants.BLUE_BISHOP.strength, DefaultPiecesConstants.BLUE.important, conductVO.target.chessVO.moves.celled, conductVO.target.chessVO.captures.celled, -1);
					break;
				case ChessPiecesConsts_The4Seasons.NAME_AUTUMN:
				case ChessPiecesConsts_The4Seasons.NAME_WINTER:	
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

