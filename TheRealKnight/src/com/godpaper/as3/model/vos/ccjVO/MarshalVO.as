package com.godpaper.as3.model.vos.ccjVO
{
	import com.godpaper.as3.configs.BoardConfig;
	import com.godpaper.as3.consts.CcjConstants;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.utils.LogUtil;
	import com.lookbackon.ds.BitBoard;
	
	import mx.logging.ILogger;
	import com.godpaper.as3.impl.AbstractChessVO;

	/**
	 * MarshalVO.as
	 * @author Knight.zhou
	 *
	 */
	public class MarshalVO extends AbstractChessVO
	{
		private static const LOG:ILogger=LogUtil.getLogger(MarshalVO);

		/**
		 * @inheritDoc
		 */
		public function MarshalVO(width:int, height:int, rowIndex:int, colIndex:int, flag:int=0)
		{
			//TODO: implement function
			super(width, height, rowIndex, colIndex, flag);
		}

		/**
		 * @inheritDoc
		 */
		override public function initialization(rowIndex:int, colIndex:int, flag:int=0):void
		{
			//TODO: implement function
			//serveral admental(将对面问题)
			//about occupies.
			//restricted in forbidden city.
			var forbiddenCity:BitBoard=new BitBoard(BoardConfig.xLines, BoardConfig.yLines);
			//forbidden city pre-define.
			forbiddenCity.setBitt(0, 3, true);
			forbiddenCity.setBitt(0, 4, true);
			forbiddenCity.setBitt(0, 5, true);
			forbiddenCity.setBitt(1, 3, true);
			forbiddenCity.setBitt(1, 4, true);
			forbiddenCity.setBitt(1, 5, true);
			forbiddenCity.setBitt(2, 3, true);
			forbiddenCity.setBitt(2, 4, true);
			forbiddenCity.setBitt(2, 5, true);
			//
			if (flag == CcjConstants.FLAG_RED)
			{
				forbiddenCity=forbiddenCity.reverse();
			}
			//set marshall 's left/right/up/down bit value.
			this.occupies.setBitt(rowIndex, colIndex - 1, Boolean(forbiddenCity.getBitt(rowIndex, colIndex - 1)));
			this.occupies.setBitt(rowIndex, colIndex + 1, Boolean(forbiddenCity.getBitt(rowIndex, colIndex + 1)));
			this.occupies.setBitt(rowIndex - 1, colIndex, Boolean(forbiddenCity.getBitt(rowIndex - 1, colIndex)));
			this.occupies.setBitt(rowIndex + 1, colIndex, Boolean(forbiddenCity.getBitt(rowIndex + 1, colIndex)));
			//about legal moves.
			if (flag == CcjConstants.FLAG_RED)
			{
				//serveral admental(将对面问题)
				this.moves=this.occupies.xor(this.occupies.and(ChessPiecesModel.getInstance().redPieces));
			}
			if (flag == CcjConstants.FLAG_BLUE)
			{
				this.moves=this.occupies.xor(this.occupies.and(ChessPiecesModel.getInstance().bluePieces));
			}
			//about attacked captures.
			if (flag == CcjConstants.FLAG_RED)
			{
				this.captures=this.moves.and(ChessPiecesModel.getInstance().bluePieces);
			}
			if (flag == CcjConstants.FLAG_BLUE)
			{
				this.captures=this.moves.and(ChessPiecesModel.getInstance().redPieces);
			}
			//
			LOG.debug("occupies:{0}", this.occupies.dump());
			LOG.debug("moves:{0}", this.moves.dump());
			LOG.debug("captures:{0}", this.captures.dump());
		}
	}
}