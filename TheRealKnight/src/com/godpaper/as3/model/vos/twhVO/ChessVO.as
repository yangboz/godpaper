package com.godpaper.as3.model.vos.twhVO
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.consts.CcjConstants;
	import com.godpaper.as3.impl.AbstractChessVO;
	import com.godpaper.as3.model.ChessPiecesModel;

	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;


	/**
	 * TwhVO.as class.The "two hit one" chess piece's value object.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jan 28, 2011 11:07:45 AM
	 */   	 
	public class ChessVO extends AbstractChessVO
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:Logger = LogContext.getLogger(ChessVO);
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
		public function ChessVO(width:int, height:int, rowIndex:int, colIndex:int, flag:int=0)
		{
			//TODO: implement function
			super(width, height, rowIndex, colIndex, flag);
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		//
		override public function initialization(rowIndex:int, colIndex:int, flag:int=0):void
		{
			//@see http://www.godpaper.com/godpaper/index.php/%E5%85%AD%E5%AD%90%E6%A3%8B
			//  *
			// *s*
			//  *
			//Notice:Don't worry about bitboard over-fence issues,that it wouble be handle it as default.
			//about occupies.
			if(colIndex<3)
			{
				this.occupies.setBitt(rowIndex,colIndex+1,true);
			}
			if(colIndex>0)
			{
				this.occupies.setBitt(rowIndex,colIndex-1,true);
			}
			if(rowIndex<3)
			{
				this.occupies.setBitt(rowIndex+1,colIndex,true);
			}
			if(rowIndex>0)
			{
				this.occupies.setBitt(rowIndex-1,colIndex,true);
			}
			LOG.info("occupies:{0}",this.occupies.dump());
			//about legal moves.
			LOG.info(ChessPiecesModel.getInstance().allPieces.dump());
			this.moves = this.occupies.xor(this.occupies.and(ChessPiecesModel.getInstance().allPieces));
			//
			LOG.info("moves:{0}",this.moves.dump());
			//blocker
			//about attacked captures.
			//about defends.
		}
		//
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

