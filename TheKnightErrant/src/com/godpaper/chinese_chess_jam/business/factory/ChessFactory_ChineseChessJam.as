package com.godpaper.chinese_chess_jam.business.factory
{
	import com.godpaper.as3.business.factory.ChessFactoryBase;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.core.IChessPiece;
	import com.godpaper.as3.core.IChessVO;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.model.vos.OmenVO;
	import com.godpaper.chinese_chess_jam.consts.Constants_ChineseChessJam;
	import com.godpaper.chinese_chess_jam.consts.PiecesConstants_ChineseChessJam;
	import com.godpaper.chinese_chess_jam.vo.BishopVO;
	import com.godpaper.chinese_chess_jam.vo.CannonVO;
	import com.godpaper.chinese_chess_jam.vo.KnightVO;
	import com.godpaper.chinese_chess_jam.vo.MarshalVO;
	import com.godpaper.chinese_chess_jam.vo.OfficalVO;
	import com.godpaper.chinese_chess_jam.vo.PawnVO;
	import com.godpaper.chinese_chess_jam.vo.RookVO;
	import com.godpaper.as3.views.components.ChessPiece;
	
	import flash.geom.Point;
	
	import starling.textures.TextureAtlas;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	/**
	 * CcjChessFactory.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jan 27, 2011 4:15:49 PM
	 */
	public class ChessFactory_ChineseChessJam extends ChessFactoryBase
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
		public function ChessFactory_ChineseChessJam()
		{
			//TODO: implement function
			super();
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		override public function createChessPiece(position:Point, flag:int=0):IChessPiece
		{
			//switch custom define properties.
			switch (position.toString())
			{
				//about blue
				case "(x=0, y=0)":
				case "(x=8, y=0)":
					chessPieceLabel=PiecesConstants_ChineseChessJam.BLUE_ROOK.label;
					chessPieceValue=PiecesConstants_ChineseChessJam.BLUE_ROOK.value;
					chessPieceType=Constants_ChineseChessJam.BLUE_ROOK;
					break;
				case "(x=1, y=0)":
				case "(x=7, y=0)":
					chessPieceLabel=PiecesConstants_ChineseChessJam.BLUE_KNIGHT.label;
					chessPieceValue=PiecesConstants_ChineseChessJam.BLUE_KNIGHT.value;
					chessPieceType=Constants_ChineseChessJam.BLUE_KNIGHT;
					break;
				case "(x=2, y=0)":
				case "(x=6, y=0)":
					chessPieceLabel=PiecesConstants_ChineseChessJam.BLUE_BISHOP.label;
					chessPieceValue=PiecesConstants_ChineseChessJam.BLUE_BISHOP.value;
					chessPieceType=Constants_ChineseChessJam.BLUE_BISHOP;
					break;
				case "(x=3, y=0)":
				case "(x=5, y=0)":
					chessPieceLabel=PiecesConstants_ChineseChessJam.BLUE_OFFICAL.label;
					chessPieceValue=PiecesConstants_ChineseChessJam.BLUE_OFFICAL.value;
					chessPieceType=Constants_ChineseChessJam.BLUE_OFFICAL;
					break;
				case "(x=4, y=0)":
					chessPieceLabel=PiecesConstants_ChineseChessJam.BLUE_MARSHAL.label;
					chessPieceValue=PiecesConstants_ChineseChessJam.BLUE_MARSHAL.value;
					chessPieceType=Constants_ChineseChessJam.BLUE_MARSHAL;
					break;
				case "(x=1, y=2)":
				case "(x=7, y=2)":
					chessPieceLabel=PiecesConstants_ChineseChessJam.BLUE_CANNON.label;
					chessPieceValue=PiecesConstants_ChineseChessJam.BLUE_CANNON.value;
					chessPieceType=Constants_ChineseChessJam.BLUE_CANNON;
					break;
				case "(x=0, y=3)":
				case "(x=2, y=3)":
				case "(x=4, y=3)":
				case "(x=6, y=3)":
				case "(x=8, y=3)":
					chessPieceLabel=PiecesConstants_ChineseChessJam.BLUE_PAWN.label;
					chessPieceValue=PiecesConstants_ChineseChessJam.BLUE_PAWN.value;
					chessPieceType=Constants_ChineseChessJam.BLUE_PAWN;
					break;
				//about red
				case "(x=0, y=9)":
				case "(x=8, y=9)":
					chessPieceLabel=PiecesConstants_ChineseChessJam.RED_ROOK.label;
					chessPieceValue=PiecesConstants_ChineseChessJam.RED_ROOK.value;
					chessPieceType=Constants_ChineseChessJam.RED_ROOK;
					break;
				case "(x=1, y=9)":
				case "(x=7, y=9)":
					chessPieceLabel=PiecesConstants_ChineseChessJam.RED_KNIGHT.label;
					chessPieceValue=PiecesConstants_ChineseChessJam.RED_KNIGHT.value;
					chessPieceType=Constants_ChineseChessJam.RED_KNIGHT;
					break;
				case "(x=2, y=9)":
				case "(x=6, y=9)":
					chessPieceLabel=PiecesConstants_ChineseChessJam.RED_BISHOP.label;
					chessPieceValue=PiecesConstants_ChineseChessJam.RED_BISHOP.value;
					chessPieceType=Constants_ChineseChessJam.RED_BISHOP;
					break;
				case "(x=3, y=9)":
				case "(x=5, y=9)":
					chessPieceLabel=PiecesConstants_ChineseChessJam.RED_OFFICAL.label;
					chessPieceValue=PiecesConstants_ChineseChessJam.RED_OFFICAL.value;
					chessPieceType=Constants_ChineseChessJam.RED_OFFICAL;
					break;
				case "(x=4, y=9)":
					chessPieceLabel=PiecesConstants_ChineseChessJam.RED_MARSHAL.label;
					chessPieceValue=PiecesConstants_ChineseChessJam.RED_MARSHAL.value;
					chessPieceType=Constants_ChineseChessJam.RED_MARSHAL;
					break;
				case "(x=1, y=7)":
				case "(x=7, y=7)":
					chessPieceLabel=PiecesConstants_ChineseChessJam.RED_CANNON.label;
					chessPieceValue=PiecesConstants_ChineseChessJam.RED_CANNON.value;
					chessPieceType=Constants_ChineseChessJam.RED_CANNON;
					break;
				case "(x=0, y=6)":
				case "(x=2, y=6)":
				case "(x=4, y=6)":
				case "(x=6, y=6)":
				case "(x=8, y=6)":
					chessPieceLabel=PiecesConstants_ChineseChessJam.RED_PAWN.label;
					chessPieceValue=PiecesConstants_ChineseChessJam.RED_PAWN.value;
					chessPieceType=Constants_ChineseChessJam.RED_PAWN;
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
			var oColIndex:int=conductVO.currentPosition.x;
			var oRowIndex:int=conductVO.currentPosition.y;
			var chessVO:IChessVO;
			//			LOG.info(conductVO.dump());
			switch ((conductVO.target as ChessPiece).label)
			{
				case PiecesConstants_ChineseChessJam.BLUE_BISHOP.label:
					chessVO=new BishopVO(9, 10, oRowIndex, oColIndex, 1);
					break;
				case PiecesConstants_ChineseChessJam.RED_BISHOP.label:
					chessVO=new BishopVO(9, 10, oRowIndex, oColIndex);
					break;
				case PiecesConstants_ChineseChessJam.BLUE_CANNON.label:
					chessVO=new CannonVO(9, 10, oRowIndex, oColIndex, 1);
					break;
				case PiecesConstants_ChineseChessJam.RED_CANNON.label:
					chessVO=new CannonVO(9, 10, oRowIndex, oColIndex);
					break;
				case PiecesConstants_ChineseChessJam.BLUE_ROOK.label:
					chessVO=new RookVO(9, 10, oRowIndex, oColIndex, 1);
					break;
				case PiecesConstants_ChineseChessJam.RED_ROOK.label:
					chessVO=new RookVO(9, 10, oRowIndex, oColIndex);
					break;
				case PiecesConstants_ChineseChessJam.BLUE_KNIGHT.label:
					chessVO=new KnightVO(9, 10, oRowIndex, oColIndex, 1);
					break;
				case PiecesConstants_ChineseChessJam.RED_KNIGHT.label:
					chessVO=new KnightVO(9, 10, oRowIndex, oColIndex);
					break;
				case PiecesConstants_ChineseChessJam.BLUE_MARSHAL.label:
					chessVO=new MarshalVO(9, 10, oRowIndex, oColIndex, 1);
					break;
				case PiecesConstants_ChineseChessJam.RED_MARSHAL.label:
					chessVO=new MarshalVO(9, 10, oRowIndex, oColIndex);
					break;
				case PiecesConstants_ChineseChessJam.BLUE_OFFICAL.label:
					chessVO=new OfficalVO(9, 10, oRowIndex, oColIndex, 1);
					break;
				case PiecesConstants_ChineseChessJam.RED_OFFICAL.label:
					chessVO=new OfficalVO(9, 10, oRowIndex, oColIndex);
					break;
				case PiecesConstants_ChineseChessJam.BLUE_PAWN.label:
					chessVO=new PawnVO(9, 10, oRowIndex, oColIndex, 1);
					break;
				case PiecesConstants_ChineseChessJam.RED_PAWN.label:
					chessVO=new PawnVO(9, 10, oRowIndex, oColIndex);
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
			switch ((conductVO.target as ChessPiece).label)
			{
				case PiecesConstants_ChineseChessJam.BLUE_BISHOP.label:
					omenVO=new OmenVO(PiecesConstants_ChineseChessJam.BLUE_BISHOP.strength, PiecesConstants_ChineseChessJam.BLUE_BISHOP.important, conductVO.target.chessVO.moves.celled, conductVO.target.chessVO.captures.celled, -1);
					break;
				case PiecesConstants_ChineseChessJam.RED_BISHOP.label:
					omenVO=new OmenVO(PiecesConstants_ChineseChessJam.RED_BISHOP.strength, PiecesConstants_ChineseChessJam.RED_BISHOP.important, conductVO.target.chessVO.moves.celled, conductVO.target.chessVO.captures.celled, -1);
					break;
				case PiecesConstants_ChineseChessJam.BLUE_CANNON.label:
					omenVO=new OmenVO(PiecesConstants_ChineseChessJam.BLUE_CANNON.strength, PiecesConstants_ChineseChessJam.BLUE_CANNON.important, conductVO.target.chessVO.moves.celled, conductVO.target.chessVO.captures.celled, -1);
					break;
				case PiecesConstants_ChineseChessJam.RED_CANNON.label:
					omenVO=new OmenVO(PiecesConstants_ChineseChessJam.RED_CANNON.strength, PiecesConstants_ChineseChessJam.RED_CANNON.important, conductVO.target.chessVO.moves.celled, conductVO.target.chessVO.captures.celled, -1);
					break;
				case PiecesConstants_ChineseChessJam.BLUE_ROOK.label:
					omenVO=new OmenVO(PiecesConstants_ChineseChessJam.BLUE_ROOK.strength, PiecesConstants_ChineseChessJam.BLUE_ROOK.important, conductVO.target.chessVO.moves.celled, conductVO.target.chessVO.captures.celled, -1);
					break;
				case PiecesConstants_ChineseChessJam.RED_ROOK.label:
					omenVO=new OmenVO(PiecesConstants_ChineseChessJam.RED_ROOK.strength, PiecesConstants_ChineseChessJam.RED_ROOK.important, conductVO.target.chessVO.moves.celled, conductVO.target.chessVO.captures.celled, -1);
					break;
				case PiecesConstants_ChineseChessJam.BLUE_KNIGHT.label:
					omenVO=new OmenVO(PiecesConstants_ChineseChessJam.BLUE_KNIGHT.strength, PiecesConstants_ChineseChessJam.BLUE_KNIGHT.important, conductVO.target.chessVO.moves.celled, conductVO.target.chessVO.captures.celled, -1);
					break;
				case PiecesConstants_ChineseChessJam.RED_KNIGHT.label:
					omenVO=new OmenVO(PiecesConstants_ChineseChessJam.RED_KNIGHT.strength, PiecesConstants_ChineseChessJam.RED_KNIGHT.important, conductVO.target.chessVO.moves.celled, conductVO.target.chessVO.captures.celled, -1);
					break;
				case PiecesConstants_ChineseChessJam.BLUE_MARSHAL.label:
					omenVO=new OmenVO(PiecesConstants_ChineseChessJam.BLUE_MARSHAL.strength, PiecesConstants_ChineseChessJam.BLUE_MARSHAL.important, conductVO.target.chessVO.moves.celled, conductVO.target.chessVO.captures.celled, -1);
					break;
				case PiecesConstants_ChineseChessJam.RED_MARSHAL.label:
					omenVO=new OmenVO(PiecesConstants_ChineseChessJam.RED_MARSHAL.strength, PiecesConstants_ChineseChessJam.RED_MARSHAL.important, conductVO.target.chessVO.moves.celled, conductVO.target.chessVO.captures.celled, -1);
					break;
				case PiecesConstants_ChineseChessJam.BLUE_OFFICAL.label:
					omenVO=new OmenVO(PiecesConstants_ChineseChessJam.BLUE_OFFICAL.strength, PiecesConstants_ChineseChessJam.BLUE_OFFICAL.important, conductVO.target.chessVO.moves.celled, conductVO.target.chessVO.captures.celled, -1);
					break;
				case PiecesConstants_ChineseChessJam.RED_OFFICAL.label:
					omenVO=new OmenVO(PiecesConstants_ChineseChessJam.RED_OFFICAL.strength, PiecesConstants_ChineseChessJam.RED_OFFICAL.important, conductVO.target.chessVO.moves.celled, conductVO.target.chessVO.captures.celled, -1);
					break;
				case PiecesConstants_ChineseChessJam.BLUE_PAWN.label:
					omenVO=new OmenVO(PiecesConstants_ChineseChessJam.BLUE_PAWN.strength, PiecesConstants_ChineseChessJam.BLUE_PAWN.important, conductVO.target.chessVO.moves.celled, conductVO.target.chessVO.captures.celled, -1);
					break;
				case PiecesConstants_ChineseChessJam.RED_PAWN.label:
					omenVO=new OmenVO(PiecesConstants_ChineseChessJam.RED_PAWN.strength, PiecesConstants_ChineseChessJam.RED_PAWN.important, conductVO.target.chessVO.moves.celled, conductVO.target.chessVO.captures.celled, -1);
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

