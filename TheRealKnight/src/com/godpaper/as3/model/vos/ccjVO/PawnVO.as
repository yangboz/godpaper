package com.godpaper.as3.model.vos.ccjVO
{
	import com.godpaper.as3.consts.CcjConstants;
	import com.godpaper.as3.consts.CcjPiecesConstants;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.utils.LogUtil;
	
	import mx.logging.ILogger;
	import com.godpaper.as3.impl.AbstractChessVO;

	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class PawnVO extends AbstractChessVO
	{
		private static const LOG:ILogger = LogUtil.getLogger(PawnVO);
		/**
		 * @inheritDoc
		 */
		public function PawnVO(width:int, height:int, rowIndex:int, colIndex:int,flag:int=0)
		{
			//TODO: implement function
			super(width, height, rowIndex, colIndex, flag);
		}
		/**
		 * @inheritDoc
		 */		
		override public function initialization(rowIndex:int, colIndex:int,flag:int=0) : void
		{
			//* -
			//* -
			//TODO: implement function
			//about occupies.
			//Notice:serveral admental(兵横向移动问题,兵后退问题)
			//right or left direction.
			if(flag==CcjConstants.FLAG_BLUE)
			{
				if(rowIndex>=5)
				{
					this.occupies.setBitt(rowIndex,colIndex+1,true);
					this.occupies.setBitt(rowIndex,colIndex-1,true);
				}
			}
			if(flag==CcjConstants.FLAG_RED)
			{
				if(rowIndex<=4)
				{
					this.occupies.setBitt(rowIndex,colIndex+1,true);
					this.occupies.setBitt(rowIndex,colIndex-1,true);
				}
			}
			//serveral admental(兵后退问题)
			//up direction
			if(flag==CcjConstants.FLAG_BLUE)
			{
				this.occupies.setBitt(rowIndex+1,colIndex,true);
			}
			//down direction
			if(flag==CcjConstants.FLAG_RED)
			{
				this.occupies.setBitt(rowIndex-1,colIndex,true);
			}
			//about legal moves.
			if(flag==CcjConstants.FLAG_RED)
			{
				this.moves = this.occupies.xor(this.occupies.and(ChessPiecesModel.getInstance().redPieces));
			}
			if(flag==CcjConstants.FLAG_BLUE)
			{
				this.moves = this.occupies.xor(this.occupies.and(ChessPiecesModel.getInstance().bluePieces));
			}
			//about attacked captures.
			if(flag==CcjConstants.FLAG_RED)
			{
				this.captures = this.moves.and(ChessPiecesModel.getInstance().bluePieces);
			}
			if(flag==CcjConstants.FLAG_BLUE)
			{
				this.captures = this.moves.and(ChessPiecesModel.getInstance().redPieces);
			}
			//
			LOG.debug("occupies:{0}",this.occupies.dump());
			LOG.debug("moves:{0}",this.moves.dump());
			LOG.debug("captures:{0}",this.captures.dump());
		}
	}
}