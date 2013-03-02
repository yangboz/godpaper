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
	public class PawnVO extends AbstractChessVO
	{
		private static const LOG:ILogger = LogUtil.getLogger(PawnVO);
		/**
		 * @inheritDoc
		 */
		public function PawnVO(width:int, height:int, rowIndex:int, colIndex:int,flag:uint=0,identifier:String="")
		{
			super(width, height, rowIndex, colIndex, flag);
		}
		/**
		 * @inheritDoc
		 */		
		override public function initialization(rowIndex:int, colIndex:int, flag:uint=0, identifier:String=""):void
		{
			//* -
			//* -
			//about occupies.
			//Notice:serveral admental(兵横向移动问题,兵后退问题)
			//right or left direction.
			if(flag==DefaultConstants.FLAG_BLUE)
			{
				if(rowIndex>=5)
				{
					this.occupies.setBitt(rowIndex,colIndex+1,true);
					this.occupies.setBitt(rowIndex,colIndex-1,true);
				}
			}
			if(flag==DefaultConstants.FLAG_RED)
			{
				if(rowIndex<=4)
				{
					this.occupies.setBitt(rowIndex,colIndex+1,true);
					this.occupies.setBitt(rowIndex,colIndex-1,true);
				}
			}
			//serveral admental(兵后退问题)
			//up direction
			if(flag==DefaultConstants.FLAG_BLUE)
			{
				this.occupies.setBitt(rowIndex+1,colIndex,true);
			}
			//down direction
			if(flag==DefaultConstants.FLAG_RED)
			{
				this.occupies.setBitt(rowIndex-1,colIndex,true);
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
			LOG.debug("[{0},{1}] occupies:{2}",colIndex,rowIndex,this.occupies.dump());
			LOG.debug("[{0},{1}] moves:{2}",colIndex,rowIndex,this.moves.dump());
			LOG.debug("[{0},{1}] captures:{2}",colIndex,rowIndex,this.captures.dump());
		}
	}
}

