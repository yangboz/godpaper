package com.godpaper.as3.business.factory
{
	import assets.DefaultEmbededAssets;
	
	import com.godpaper.as3.configs.BoardConfig;
	import com.godpaper.as3.configs.GasketConfig;
	import com.godpaper.as3.configs.PieceConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.core.IChessBoard;
	import com.godpaper.as3.core.IChessFactory;
	import com.godpaper.as3.core.IChessGasket;
	import com.godpaper.as3.core.IChessPiece;
	import com.godpaper.as3.core.IChessVO;
	import com.godpaper.as3.errors.DefaultErrors;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.model.pools.BlueChessPiecesPool;
	import com.godpaper.as3.model.pools.ChessGasketsPool;
	import com.godpaper.as3.model.pools.RedChessPiecesPool;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.model.vos.OmenVO;
	import com.godpaper.starling.views.components.ChessGasket;
	import com.godpaper.starling.views.components.ChessPiece;
	
	import flash.geom.Point;
	
	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------

	/**
	 * Simply factory produce ChessPiece/ChessGasket/ChessVO/OmenVO and relatived properties.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jan 27, 2011 3:52:34 PM
	 */
	public class ChessFactoryBase implements IChessFactory
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		protected var chessPieceLabel:String="";//The label of chess piece.@see DefaultPiecesConstants.as
		protected var chessPieceValue:int=0;//The value of chess piece(hex value prefered).
		protected var chessPieceType:String="";//Blue/Red/Green...
		protected var chessPieceSource:Object;//style source asset(@see assets/EmbededAssets.as).
		protected var chessPieceName:String="";//the unique chess piece name to identify the chess piece of typed group.
		protected var chessGasketTips:String="";//The tool tips of chess gasket.
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:Logger=LogContext.getLogger(ChessFactoryBase);
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
		public function ChessFactoryBase()
		{
			//The ObjectPool class creates a pool of new objects at the initialization of the application. 
			ChessGasketsPool.initialize(GasketConfig.maxPoolSize,GasketConfig.growthValue);
			//Maybe this pools has been initialized in some places(PiecesBox).
			if(!BlueChessPiecesPool.initialized)
			{
				BlueChessPiecesPool.initialize(PieceConfig.maxPoolSizeBlue,PieceConfig.growthValue);
			}
			if(!RedChessPiecesPool.initialized)
			{
				RedChessPiecesPool.initialize(PieceConfig.maxPoolSizeRed,PieceConfig.growthValue);
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		/**
		 * Chess piece manipulate.
		 * @param position chessPiece's position type is Point(x, y).
		 * @param flag chessPices's side flag.(red/blue).
		 * @return ChessPiece component with implement IChessPiece
		 *
		 */
		public function createChessPiece(position:Point, flag:int=0):IChessPiece
		{
			//view
			var simpleChessPiece:ChessPiece;
			if (this.chessPieceType.indexOf(DefaultConstants.RED)!=-1)//red
			{
				simpleChessPiece = RedChessPiecesPool.get();
			}else
			{
				simpleChessPiece = BlueChessPiecesPool.get();
			}
			//Set properties
			simpleChessPiece.label=this.chessPieceLabel;
			simpleChessPiece.name=this.chessPieceName;
			simpleChessPiece.type=chessPieceType;
			//Set texture atlas
			var atlas:TextureAtlas = DefaultEmbededAssets.getTextureAtlas();
			simpleChessPiece.upState = atlas.getTexture(chessPieceType);
			simpleChessPiece.downState = atlas.getTexture(chessPieceType);
			//set flag to identify.
			simpleChessPiece.flag=DefaultConstants.FLAG_BLUE;
			//
			if (this.chessPieceLabel!="")
			{
				if (this.chessPieceType.indexOf(DefaultConstants.RED)!=-1)//red
				{
					simpleChessPiece.flag=DefaultConstants.FLAG_RED; 
					//					ChessPiecesModel.getInstance().redPieces.setBitt(position.y,position.x,true);
					ChessPiecesModel.getInstance()[simpleChessPiece.type].setBitt(position.y, position.x, true);
					//push to reds collection.
					ChessPiecesModel.getInstance().reds.push(simpleChessPiece);
				}
				else //blue
				{
					//simpleChessPiece.enabled = false;
					//					ChessPiecesModel.getInstance().bluePieces.setBitt(position.y,position.x,true);
					ChessPiecesModel.getInstance()[simpleChessPiece.type].setBitt(position.y, position.x, true);
					//push to blues collection.
					ChessPiecesModel.getInstance().blues.push(simpleChessPiece);
				}
			}
			//avoid duplicate usless components.
			if (this.chessPieceLabel!="")
			{
				//data
				simpleChessPiece.position=position;
				LOG.debug("Anew chess piece has been created@{0},type:{1},name:{2},value:{3},label:{4}",position,chessPieceType,chessPieceName,chessPieceValue,chessPieceLabel);
				return simpleChessPiece as IChessPiece;
			}
			return null;
		}

		/**
		 * Chess gasket manipulate.
		 * @param position
		 * @return ChessGasket component which implement IChessGasket
		 *
		 */
		public function createChessGasket(position:Point):IChessGasket
		{
			//
//			var myChessGasket:ChessGasket=new ChessGasket();
			var myChessGasket:ChessGasket= ChessGasketsPool.get();
			myChessGasket.position=position;
			myChessGasket.x=position.x * BoardConfig.xOffset - myChessGasket.width / 2 + BoardConfig.xAdjust;
			myChessGasket.y=position.y * BoardConfig.yOffset - myChessGasket.height / 2+ BoardConfig.yAdjust;
			if(GasketConfig.tipsVisible)
			{
//				chessGasketTips = position.toString();
//				myChessGasket.toolTip=chessGasketTips;
				chessGasketTips = "".concat(position.x,",",position.y);
				myChessGasket.text = chessGasketTips;
			}
			LOG.debug("Anew chess gasket has been created@{0},label:{1}",position,chessGasketTips);
			return myChessGasket;
		}

		/**
		 * ChessVO manipulate.
		 * @param conductVO has property target(type is chessPiece) and newPosition([0,1]).
		 * @return precise chess value object(prototype is chessVOBase).
		 *
		 */
		public function generateChessVO(conductVO:ConductVO):IChessVO
		{
			throw new Error(DefaultErrors.INITIALIZE_VIRTUAL_FUNCTION);
			return null;
		}

		/**
		 * OmenVO manipulate.
		 * @param conductVO has property target(type is chessPiece) and newPosition([0,1]).
		 * @return precise chess value object(prototype is OmenVO).
		 *
		 */
		public function generateOmenVO(conductVO:ConductVO):OmenVO
		{
			throw new Error(DefaultErrors.INITIALIZE_VIRTUAL_FUNCTION);
			return null;
		}
		/**
		 * Create the type specialed chess board
		 * @param type the chess board type(bitBoard,graphBoard,arrayBoard...)
		 * @return the IChessBoard.
		 * 
		 */		
		public function createChessBoard(type:String):IChessBoard
		{
			switch(type)
			{
				//TODO:implment funcs.
			}
			return null;
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
