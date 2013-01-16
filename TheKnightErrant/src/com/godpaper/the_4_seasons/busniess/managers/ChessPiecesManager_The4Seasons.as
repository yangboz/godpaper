package com.godpaper.the_4_seasons.busniess.managers
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.business.managers.ChessPiecesManagerDefault;
	import com.godpaper.as3.configs.BoardConfig;
	import com.godpaper.as3.configs.GameConfig;
	import com.godpaper.as3.core.IChessGasket;
	import com.godpaper.as3.core.IChessPiece;
	import com.godpaper.as3.core.IChessVO;
	import com.godpaper.as3.model.ChessBoardModel;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.utils.LogUtil;
	import com.godpaper.as3.views.components.ChessPiece;
	import com.godpaper.the_4_seasons.consts.ChessPiecesConsts_The4Seasons;
	import com.lookbackon.ds.BitBoard;
	import com.lookbackon.ds.NumberBoard;
	
	import de.polygonal.ds.Array2;
	
	import mx.logging.ILogger;

	/**
	 * T4sChessPiecesManager.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Feb 25, 2011 12:38:06 PM
	 */   	 
	public class ChessPiecesManager_The4Seasons extends com.godpaper.as3.business.managers.ChessPiecesManagerDefault
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(ChessPiecesManager_The4Seasons);
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
		//spring
		protected function get spring():ChessPiece
		{
			return this.getChessPiece(ChessPiecesConsts_The4Seasons.NAME_SPRING);
		}
		protected function get springMoves():BitBoard
		{
			return spring.chessVO.moves;
		}
		//summer
		protected function get summer():ChessPiece
		{
			return this.getChessPiece(ChessPiecesConsts_The4Seasons.NAME_SUMMER);
		}
		protected function get summerMoves():BitBoard
		{
			return summer.chessVO.moves;
		}
		//autumn
		protected function get autumn():ChessPiece
		{
			return this.getChessPiece(ChessPiecesConsts_The4Seasons.NAME_AUTUMN);
		}
		protected function get autumnMoves():BitBoard
		{
			return autumn.chessVO.moves;
		}
		//winter
		protected function get winter():ChessPiece
		{
			return this.getChessPiece(ChessPiecesConsts_The4Seasons.NAME_WINTER);
		}
		protected function get winterMoves():BitBoard
		{
			return winter.chessVO.moves;
		}
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function ChessPiecesManager_The4Seasons()
		{
			super();
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		override public function applyMove(conductVO:ConductVO):void
		{
			//super call here.
			super.applyMove(conductVO);
			//Apply your chess game rule here.
		}
		//
		override public function doMoveValidation(conductVO:ConductVO):Boolean
		{
//			return super.doMoveValidation(conductVO);
			//implment the actual rule.
			//esp for the 4 season,(spring limit autumn,summer limit winter,both of horizontally and vertically).
			var cp:ChessPiece = conductVO.target as ChessPiece;
			var validationResult:Boolean = true;
			//
			var chessVO:IChessVO=conductVO.target.chessVO;
			var preMoves:BitBoard=chessVO.moves;
			var preMovesFile:Array = preMoves.getCols(cp.position.x);
			//
			trace("preMoves:", preMoves.dump());
			var filterMoves:BitBoard;
			//append move validations here.
			if(ChessPiecesConsts_The4Seasons.NAME_SPRING == cp.name)
			{
				//					trace("springMoves:",springMoves.dump());
				//					trace("autumnMoves:",autumnMoves.dump());
				//
				filterMoves = preMoves.xor(springMoves.and(autumnMoves));
				//autumn alway at the bottom of spring.
				//remove invalid bit set at file direction:
				for(var sy:int=autumn.position.y;sy<BoardConfig.yLines;sy++)
				{
					filterMoves.setBitt(sy,spring.position.x,false);
				}
				//autumn alway at the right of spring.
				//remove invalid bit set at file direction:
				for(var sx:int=autumn.position.x;sx<BoardConfig.xLines;sx++)
				{
					filterMoves.setBitt(spring.position.y,sx,false);
				}
			}else if(ChessPiecesConsts_The4Seasons.NAME_SUMMER == cp.name)
			{
				//
				filterMoves = preMoves.xor(summerMoves.and(winterMoves));
				//winter alway at the bottom of summer.
				//remove invalid bit set at file direction:
				for(var sumY:int=winter.position.y;sumY<BoardConfig.yLines;sumY++)
				{
					filterMoves.setBitt(sumY,summer.position.x,false);
				}
				//winter alway at the left of summer.
				//remove invalid bit set at file direction:
				for(var sumX:int=winter.position.x;sumX>=0;sumX--)
				{
					filterMoves.setBitt(summer.position.y,sumX,false);
				}
			}else if(ChessPiecesConsts_The4Seasons.NAME_AUTUMN == cp.name)
			{
				//
				filterMoves = preMoves.xor(autumnMoves.and(springMoves));
				//autumn alway at the bottom of spring.
				//remove invalid bit set at file direction:
				for(var ay:int=spring.position.y;ay>=0;ay--)
				{
					filterMoves.setBitt(ay,autumn.position.x,false);
				}
				//autumn alway at the right of spring.
				//remove invalid bit set at file direction:
				for(var ax:int=spring.position.x;ax>=0;ax--)
				{
					filterMoves.setBitt(autumn.position.y,ax,false);
				}
			}else
			{
				//
				filterMoves = preMoves.xor(summerMoves.and(winterMoves));
				//winter alway at the bottom of summer.
				//remove invalid bit set at file direction:
				for(var winY:int=summer.position.y;winY>=0;winY--)
				{
					filterMoves.setBitt(winY,winter.position.x,false);
				}
				//winter alway at the left of summer.
				//remove invalid bit set at file direction:
				for(var winX:int=summer.position.x;winX<BoardConfig.xLines;winX++)
				{
					filterMoves.setBitt(winter.position.y,winX,false);
				}
			}
			trace("filterMoves:",filterMoves.dump());
			//
			validationResult = Boolean(filterMoves.getBitt(conductVO.nextPosition.y, conductVO.nextPosition.x));
//			trace("validationResult:",validationResult);
			//
			return validationResult;
		}
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		protected function getChessPiece(name:String):ChessPiece
		{
			for(var i:int=0;i<chessPiecesModel.pieces.length;i++)
			{
				if( chessPiecesModel.pieces[i].name == name )
				{
					return chessPiecesModel.pieces[i];
				}
			}
			return null;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}

}

