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
	 * @author knight.zhou
	 *
	 */	
	public class KnightVO extends AbstractChessVO
	{
		private static const LOG:ILogger = LogUtil.getLogger(KnightVO);
		/**
		 * @inheritDoc
		 */
		public function KnightVO(width:int, height:int, rowIndex:int, colIndex:int,flag:int=0,identifier:String="")
		{
			super(width, height, rowIndex, colIndex, flag);
		}
		/**
		 * @inheritDoc
		 */
		override public function initialization(rowIndex:int, colIndex:int, flag:int=0, identifier:String=""):void
		{
			// - * - * -
			// * - - - *
			// - - s - -
			// * - - - *
			// - * - * -
			//serveral admental(马撇脚问题)
			//left direction.
			if(!chessPiecesModel.allPieces.getBitt(rowIndex,colIndex-1))
			{
				//several amendments.
				this.occupies.setBitt(rowIndex+1,colIndex-2,true);
				this.occupies.setBitt(rowIndex-1,colIndex-2,true);
			}
			//up direction.
			if(!chessPiecesModel.allPieces.getBitt(rowIndex-1,colIndex))
			{
				//several amendments.
				this.occupies.setBitt(rowIndex-2,colIndex-1,true);
				this.occupies.setBitt(rowIndex-2,colIndex+1,true);
			}
			//right direction.
			if(chessPiecesModel.allPieces.getBitt(rowIndex,colIndex+1))
			{
				//several amendments.
				this.occupies.setBitt(rowIndex+1,colIndex+2,true);
				this.occupies.setBitt(rowIndex-1,colIndex+2,true);
			}
			//down direction.
			if(!chessPiecesModel.allPieces.getBitt(rowIndex+1,colIndex))
			{
				//several amendments.
				this.occupies.setBitt(rowIndex+2,colIndex+1,true);
				this.occupies.setBitt(rowIndex+2,colIndex-1,true);
			}
			//about legal moves.
			if(flag==DefaultConstants.FLAG_RED)
			{
				this.moves = this.occupies.xor(this.occupies.and(chessPiecesModel.redPieces));
			}
			if(flag==DefaultConstants.FLAG_BLUE)
			{
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
			//
			LOG.debug("occupies:{0}",this.occupies.dump());
			LOG.debug("moves:{0}",this.moves.dump());
			LOG.debug("captures:{0}",this.captures.dump());
		}
	}
}

