package com.godpaper.chinese_chess_jam.vo
{
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.consts.DefaultPiecesConstants;
	import com.godpaper.as3.impl.AbstractChessVO;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.utils.LogUtil;

	import mx.logging.ILogger;

	/**
	 *
	 * @author Knight.zhou
	 *
	 */	
	public class OfficalVO extends AbstractChessVO
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(OfficalVO);
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		/**
		 * @inheritDoc
		 */
		public function OfficalVO(width:int, height:int, rowIndex:int, colIndex:int,flag:int=0,identifier:String="")
		{
			//TODO: implement function
			super(width, height, rowIndex, colIndex, flag);
		}
		/**
		 * @inheritDoc
		 */
		override public function initialization( rowIndex:int, colIndex:int,flag:int=0,identifier:String="") : void
		{
			//* -
			//- *
			//TODO: implement function
			//about occupies.
			if(rowIndex%7!=2 && colIndex!=5 )
			{
				this.occupies.setBitt(rowIndex+1,colIndex+1,true);
			}
			if(rowIndex%7!=2 && colIndex!=3 )
			{
				this.occupies.setBitt(rowIndex+1,colIndex-1,true);
			}
			if(rowIndex%7!=0 && colIndex!=5 )
			{
				this.occupies.setBitt(rowIndex-1,colIndex+1,true);
			}	
			if(rowIndex%7!=0 && colIndex!=3 )
			{
				this.occupies.setBitt(rowIndex-1,colIndex-1,true);
			}	
			//about legal moves.
			//Notice:serveral admental(防守将问题)
			//TODO:
			if(flag==DefaultConstants.FLAG_RED)
			{
				this.defends = 
					this.moves = this.occupies.xor(this.occupies.and(chessPiecesModel.redPieces));
			}
			if(flag==DefaultConstants.FLAG_BLUE)
			{
				this.defends = 
					this.moves = this.occupies.xor(this.occupies.and(chessPiecesModel.bluePieces));
			}
			//about attacked captures.
			if(flag==DefaultConstants.FLAG_RED)
			{
				this.captures = this.moves.and(chessPiecesModel.bluePieces);
			}
			if(flag==DefaultConstants.FLAG_BLUE)
			{
				this.captures = this.moves.and(chessPiecesModel.redPieces);
			}
			LOG.debug("occupies:{0}",this.occupies.dump());
			LOG.debug("moves:{0}",this.moves.dump());
			LOG.debug("captures:{0}",this.captures.dump());
		}
	}
}

