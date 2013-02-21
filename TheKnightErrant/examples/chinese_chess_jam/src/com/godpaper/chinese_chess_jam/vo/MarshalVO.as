package chinese_chess_jam.src.com.godpaper.chinese_chess_jam.vo
{
	import com.godpaper.as3.configs.BoardConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.impl.AbstractChessVO;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.utils.LogUtil;
	import com.lookbackon.ds.BitBoard;

	import mx.logging.ILogger;

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
		public function MarshalVO(width:int, height:int, rowIndex:int, colIndex:int, flag:uint=0,identifier:String="")
		{
			//TODO: implement function
			super(width, height, rowIndex, colIndex, flag);
		}

		/**
		 * @inheritDoc
		 */
		override public function initialization(rowIndex:int, colIndex:int, flag:uint=0, identifier:String=""):void
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
			if (flag == DefaultConstants.FLAG_RED)
			{
				forbiddenCity=forbiddenCity.reverse();
			}
			//set marshall 's left/right/up/down bit value.
			this.occupies.setBitt(rowIndex, colIndex - 1, Boolean(forbiddenCity.getBitt(rowIndex, colIndex - 1)));
			this.occupies.setBitt(rowIndex, colIndex + 1, Boolean(forbiddenCity.getBitt(rowIndex, colIndex + 1)));
			this.occupies.setBitt(rowIndex - 1, colIndex, Boolean(forbiddenCity.getBitt(rowIndex - 1, colIndex)));
			this.occupies.setBitt(rowIndex + 1, colIndex, Boolean(forbiddenCity.getBitt(rowIndex + 1, colIndex)));
			//about legal moves.
			if (flag == DefaultConstants.FLAG_RED)
			{
				//serveral admental(将对面问题)
				this.moves=this.occupies.xor(this.occupies.and(chessPiecesModel.redPieces));
			}
			if (flag == DefaultConstants.FLAG_BLUE)
			{
				this.moves=this.occupies.xor(this.occupies.and(chessPiecesModel.bluePieces));
			}
			//about attacked captures.
			if (flag == DefaultConstants.FLAG_RED)
			{
				this.captures=this.moves.and(chessPiecesModel.bluePieces);
			}
			if (flag == DefaultConstants.FLAG_BLUE)
			{
				this.captures=this.moves.and(chessPiecesModel.redPieces);
			}
			//
			LOG.debug("occupies:{0}", this.occupies.dump());
			LOG.debug("moves:{0}", this.moves.dump());
			LOG.debug("captures:{0}", this.captures.dump());
		}
	}
}

