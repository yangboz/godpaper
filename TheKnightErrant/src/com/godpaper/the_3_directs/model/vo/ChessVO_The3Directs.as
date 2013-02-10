package com.godpaper.the_3_directs.model.vo
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.impl.AbstractChessVO;
	import com.godpaper.as3.model.ChessGasketsModel;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.utils.LogUtil;
	
	import mx.logging.ILogger;
	
	
	/**
	 * T3dChessVO.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Feb 25, 2011 12:38:37 PM
	 */   	 
	public class ChessVO_The3Directs extends AbstractChessVO
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(ChessVO_The3Directs);
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
		public function ChessVO_The3Directs(width:int, height:int, rowIndex:int, colIndex:int, flag:uint=0)
		{
			super(width, height, rowIndex, colIndex, flag);
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
						this.occupies.setBitt(row,col,true);
					}
				}
			}
			LOG.info("occupies:{0}",this.occupies.dump());
			//about legal moves.
			LOG.info(chessPiecesModel.allPieces.dump());
			this.moves = this.occupies.xor(this.occupies.and(chessPiecesModel.allPieces));
			//
			LOG.info("moves:{0}",this.moves.dump());
			//blocker
			//about attacked captures.
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
