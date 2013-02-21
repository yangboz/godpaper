package the_3_directs.src.com.godpaper.the_3_directs.business.factory
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	import com.godpaper.as3.business.factory.ChessFactoryBase;
	import com.godpaper.as3.configs.BoardConfig;
	import com.godpaper.as3.configs.GasketConfig;
	import com.godpaper.as3.configs.PieceConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.consts.DefaultPiecesConstants;
	import com.godpaper.as3.core.IChessGasket;
	import com.godpaper.as3.core.IChessPiece;
	import com.godpaper.as3.core.IChessVO;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.model.pools.ChessGasketsPool;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.model.vos.OmenVO;
	import com.godpaper.as3.views.components.ChessGasket;
	import com.godpaper.as3.views.components.ChessPiece;
	import the_3_directs.src.com.godpaper.the_3_directs.model.vo.ChessVO_The3Directs;
	
	import flash.geom.Point;
	
//	import spark.components.Application;
	
	import starling.textures.TextureAtlas;
	
	/**
	 * T3dChessFactory.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Feb 25, 2011 12:37:46 PM
	 */   	 
	public class ChessFactory_The3Directs extends ChessFactoryBase
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		public static var gasketsHasProduced:Boolean = false;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		//
		public static const STYLE_TRIANGLE:String = "triangle";
		public static const STYLE_TRIANGLE_HEADSTAND:String = "headstandTriangle";
		//
		private static const X_OFFSET:Number = 40;
		private static const Y_OFFSET:Number = 69.282;
		private static const X_ORIGIN:Number = 384;
		private static const Y_ORIGIN:Number = 120;
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
		public function ChessFactory_The3Directs()
		{
			super();
			//initialize the triangles according the shape of the 3 direction.
		}     	
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		//
		override public function createChessGasket(position:Point):IChessGasket
		{
			var gasketButton:ChessGasket;
			//Return triangle chess gasket.
			if(position.y==0)
			{
				if(position.x<1)
				{
					gasketButton = ChessGasketsPool.get();
					gasketButton.x = X_ORIGIN;
					gasketButton.y = Y_ORIGIN;
//					gasketButton.styleName = STYLE_TRIANGLE;
				}
			}
			if(position.y==1)
			{
				if(position.x<3)
				{
					if(position.x%2)
					{
						gasketButton = ChessGasketsPool.get();
						gasketButton.x = X_ORIGIN-2*X_OFFSET;
						gasketButton.y = Y_ORIGIN;
//						gasketButton.styleName = STYLE_TRIANGLE_HEADSTAND;
					}else
					{
						gasketButton = ChessGasketsPool.get();
						gasketButton.x = X_ORIGIN-X_OFFSET + position.x*X_OFFSET;
						gasketButton.y = Y_ORIGIN+Y_OFFSET;
//						gasketButton.styleName = STYLE_TRIANGLE;
					}
				}
			}
			if(position.y==2)
			{
				if(position.x<5)
				{
					if(position.x%2)
					{
						gasketButton = ChessGasketsPool.get();
						gasketButton.x = X_ORIGIN-3*X_OFFSET+ (position.x-1)*X_OFFSET;
						gasketButton.y = Y_ORIGIN+Y_OFFSET;
//						gasketButton.styleName = STYLE_TRIANGLE_HEADSTAND;
					}else
					{
						gasketButton = ChessGasketsPool.get();
						gasketButton.x = X_ORIGIN-2*X_OFFSET + position.x*X_OFFSET;
						gasketButton.y = Y_ORIGIN+2*Y_OFFSET;
//						gasketButton.styleName = STYLE_TRIANGLE;
					}
				}
			}
			if(position.y==3)
			{
				if(position.x<7)
				{
					if(position.x%2)
					{
						gasketButton = ChessGasketsPool.get();
						gasketButton.x = X_ORIGIN-4*X_OFFSET + (position.x-1)*X_OFFSET;
						gasketButton.y = Y_ORIGIN+2*Y_OFFSET;
//						gasketButton.styleName = STYLE_TRIANGLE_HEADSTAND;
					}else
					{
						gasketButton = ChessGasketsPool.get();
						gasketButton.x = X_ORIGIN-3*X_OFFSET + position.x*X_OFFSET;
						gasketButton.y = Y_ORIGIN+3*Y_OFFSET;
//						gasketButton.styleName = STYLE_TRIANGLE;
					}
				}
			}
			if(position.y==4)
			{
				if(position.x<9)
				{
					if(position.x%2)
					{
						gasketButton = ChessGasketsPool.get();
						gasketButton.x = X_ORIGIN-5*X_OFFSET + (position.x-1)*X_OFFSET;
						gasketButton.y = Y_ORIGIN+3*Y_OFFSET;
//						gasketButton.styleName = STYLE_TRIANGLE_HEADSTAND;
					}else
					{
						gasketButton = ChessGasketsPool.get();
						gasketButton.x = X_ORIGIN-4*X_OFFSET + position.x*X_OFFSET;
						gasketButton.y = Y_ORIGIN+4*Y_OFFSET;
//						gasketButton.styleName = STYLE_TRIANGLE;
					}
				}
			}
			if(position.y==5)
			{
				if(position.x<11)
				{
					if(position.x%2)
					{
						gasketButton = ChessGasketsPool.get();
						gasketButton.x = X_ORIGIN-6*X_OFFSET + (position.x-1)*X_OFFSET;
						gasketButton.y = Y_ORIGIN+4*Y_OFFSET;
//						gasketButton.styleName = STYLE_TRIANGLE_HEADSTAND;
					}else
					{
						gasketButton = ChessGasketsPool.get();
						gasketButton.x = X_ORIGIN-5*X_OFFSET + position.x*X_OFFSET;
						gasketButton.y = Y_ORIGIN+5*Y_OFFSET;
//						gasketButton.styleName = STYLE_TRIANGLE;
					}
				}
			}
			if(position.y==6)
			{
				if(position.x<13)
				{
					if(position.x%2)
					{
						gasketButton = ChessGasketsPool.get();
						gasketButton.x = X_ORIGIN-7*X_OFFSET + (position.x-1)*X_OFFSET;
						gasketButton.y = Y_ORIGIN+5*Y_OFFSET;
//						gasketButton.styleName = STYLE_TRIANGLE_HEADSTAND;
					}else
					{
						gasketButton = ChessGasketsPool.get();
						gasketButton.x = X_ORIGIN-6*X_OFFSET + position.x*X_OFFSET;
						gasketButton.y = Y_ORIGIN+6*Y_OFFSET;
//						gasketButton.styleName = STYLE_TRIANGLE;
					}
				}
			}
			if(position.y==7)
			{
				if(position.x<15)
				{
					if(position.x%2)
					{
						gasketButton = ChessGasketsPool.get();
						gasketButton.x = X_ORIGIN-8*X_OFFSET + (position.x-1)*X_OFFSET;
						gasketButton.y = Y_ORIGIN+6*Y_OFFSET;
//						gasketButton.styleName = STYLE_TRIANGLE_HEADSTAND;
					}else
					{
						gasketButton = ChessGasketsPool.get();
						gasketButton.x = X_ORIGIN-7*X_OFFSET + position.x*X_OFFSET;
						gasketButton.y = Y_ORIGIN+7*Y_OFFSET;
//						gasketButton.styleName = STYLE_TRIANGLE;
					}
				}
			}
			if(gasketButton)
			{
				gasketButton.position = position;
			}
			//
			return gasketButton;
		}
		override public function createChessPiece(position:Point, flag:uint=0):IChessPiece
		{
			//custom define properties.
			if(flag==DefaultConstants.FLAG_BLUE)//about blue
			{
				chessPieceLabel=DefaultPiecesConstants.BLUE.label;
				chessPieceValue=16+int(position.x);
				chessPieceType = DefaultConstants.BLUE;
			}else//about red
			{
				chessPieceLabel=DefaultPiecesConstants.RED.label;
				chessPieceValue=8+int(position.x);
				chessPieceType=DefaultConstants.RED;
			}
			//custom define view.
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
			switch ((conductVO.target as ChessPiece).label)
			{
				case DefaultPiecesConstants.BLUE.label:
					chessVO=new ChessVO_The3Directs(BoardConfig.xLines,BoardConfig.yLines,oRowIndex, oColIndex,DefaultConstants.FLAG_BLUE);
					break;
				case DefaultPiecesConstants.RED.label:
					chessVO=new ChessVO_The3Directs(BoardConfig.xLines, BoardConfig.yLines, oRowIndex, oColIndex,DefaultConstants.FLAG_RED);
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
