package com.godpaper.color_lines.busniess.factory
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.business.factory.ChessFactoryBase;
	import com.godpaper.as3.configs.PieceConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.consts.DefaultPiecesConstants;
	import com.godpaper.as3.core.IChessGasket;
	import com.godpaper.as3.core.IChessPiece;
	import com.godpaper.as3.core.IChessVO;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.model.vos.OmenVO;
	import com.godpaper.as3.utils.LogUtil;
	import com.godpaper.as3.utils.MathUtil;
	import com.godpaper.as3.views.components.ChessPiece;
	import com.godpaper.color_lines.model.vo.ChessVO_ColorLines;
	import com.godpaper.color_lines.model.vo.ColorPositionVO;
	import com.masterbaboon.AdvancedMath;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	import mx.events.FlexEvent;
	import mx.logging.ILogger;


	/**
	 * ColorLinesChessFactory.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Feb 25, 2011 12:37:46 PM
	 */   	 
	public class ChessFactory_ColorLines extends ChessFactoryBase
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//with initialization
		public static var dataProvider:Vector.<ColorPositionVO> = ChessFacotryHelper_ColorLines.randomColorfulPieces();
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(ChessFactory_ColorLines);
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
		public function ChessFactory_ColorLines()
		{
			super();
//			trace("dataProvider:",dataProvider);
		}     	

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		//
		override public function createChessGasket(position:Point):IChessGasket
		{
			//Return default chess gasket.
			return super.createChessGasket(position);
		}
		//Full scan this board with matched position.
		override public function createChessPiece(position:Point, flag:int=0):IChessPiece
		{
//			trace("chessPieceModel.allPieces:",chessPieceModel.allPieces.dump());
//			trace("current position is:",position);
			if(dataProvider.length<=0)
			{
				return null;
			}
			//
			var foundIndex:int = this.positionIsMatched(position);
			if(foundIndex!=-1)
			{
				//Your chess piece under construction.
				//custom define properties.
				//			for(var j:int=0;j<randomPremutatedColors.length;j++)
				//			{
				//				chessPieceLabel=DefaultPiecesConstants.BLUE.label;
				//				chessPieceValue=16+int(position.x);
				//				chessPieceType=DefaultConstants.BLUE;
				//			}
				var colorPositionVO:ColorPositionVO = dataProvider[foundIndex];
				chessPieceLabel=DefaultPiecesConstants.RED.label;
				chessPieceValue=18+int(colorPositionVO.position.x);
				chessPieceType=DefaultConstants.RED;
				//custom define view.
				var randomColor:String = colorPositionVO.color;
//				this.chessPieceSource = EmbededAssets[randomColor];
			}else
			{
				return null;
			}
			//call super function.
//			return super.createChessPiece(position,flag);
			return customeCreateChessPiece(colorPositionVO.position,flag);
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
				case DefaultPiecesConstants.BLUE.label:
					chessVO=new ChessVO_ColorLines(9,9,oRowIndex, oColIndex,DefaultConstants.FLAG_BLUE);
					break;
				case DefaultPiecesConstants.RED.label:
					chessVO=new ChessVO_ColorLines(9, 9, oRowIndex, oColIndex,DefaultConstants.FLAG_RED);
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
		//
		/**
		 * Chess piece manipulate.
		 * @param position chessPiece's position type is Point(x, y).
		 * @param flag chessPices's side flag.(red/blue).
		 * @return ChessPiece component with implement IChessPiece
		 *
		 */
		private function customeCreateChessPiece(position:Point, flag:int=0):IChessPiece
		{
			//view
			var simpleChessPiece:ChessPiece = new ChessPiece();
			simpleChessPiece.label=this.chessPieceLabel;
			simpleChessPiece.name=this.chessPieceLabel;
			simpleChessPiece.type=chessPieceType;
			//			simpleChessPiece.swfLoader.source = String("./assets/").concat(chessPieceType,".swf");
//			simpleChessPiece.swfLoader.source=this.chessPieceSource;
//			simpleChessPiece.swfLoader.scaleX = PieceConfig.scaleX;
//			simpleChessPiece.swfLoader.scaleY = PieceConfig.scaleY;
			//set flag to identify.
			simpleChessPiece.flag=DefaultConstants.FLAG_RED;
			//avoid duplicate usless components.
			if (this.chessPieceLabel!="")
			{
				//data
				chessPiecesModel[simpleChessPiece.type].setBitt(position.y, position.x, true);
				//push to blues collection.
				chessPiecesModel.blues.push(simpleChessPiece);
				//
				simpleChessPiece.position=position;
				LOG.debug("Anew chess piece created@{0}",position);
				return simpleChessPiece as IChessPiece;
			}
			return null;
		}
		//
		private function positionIsMatched(position:Point):int
		{
			var found:int = -1;
			//
			for(var i:int=0;i<dataProvider.length;i++)
			{
				if( (position.x == dataProvider[i].position.x) && (position.y == dataProvider[i].position.y))
				{
					found = i;
//					trace("found matched position is:",position);
				}
			}
			//
			return found;
		}
	}

}

