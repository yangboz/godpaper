package com.godpaper.chinese_chess_jam.vo
{
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.consts.DefaultPiecesConstants;
	import com.godpaper.as3.impl.AbstractChessVO;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.model.ZobristKeysModel;
	import com.godpaper.as3.utils.LogUtil;
	import com.lookbackon.ds.BitBoard;

	import flash.geom.Point;

	import mx.logging.ILogger;

	/**
	 *
	 * @author Knight.zhou
	 *
	 */	
	public class RookVO extends AbstractChessVO
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		protected static const LOG:ILogger = LogUtil.getLogger(RookVO);
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		/**
		 * @inheritDoc
		 */
		public function RookVO(width:int, height:int, rowIndex:int, colIndex:int,flag:uint=0,identifier:String="")
		{
			//TODO: implement function
			super(width, height,rowIndex,colIndex,flag);
		}
		/**
		 * @inheritDoc
		 */
		override public function initialization(rowIndex:int, colIndex:int, flag:uint=0, identifier:String=""):void
		{
			//    *
			// ***s*****
			//    *
			//Notice:serveral admental(车越子移动/吃子问题)
			//about occupies.
			for(var r:int=0;r<this.row;r++)
			{
				this.occupies.setBitt(r,colIndex,true);
			}
			for(var c:int=0;c<this.column;c++)
			{
				this.occupies.setBitt(rowIndex,c,true);
			}
//			LOG.info("occupies:{0}",this.occupies.dump());
			//about legal moves.
//			LOG.info("redPieces:{0}",ChessPositionModelLocator.getInstance().redPieces.dump());
//			LOG.info("bluePieces:{0}",ChessPositionModelLocator.getInstance().bluePieces.dump());
			if(flag==DefaultConstants.FLAG_RED)
			{
				this.moves = this.occupies.xor(this.occupies.and(chessPiecesModel.redPieces));
			}
			if(flag==DefaultConstants.FLAG_BLUE)
			{
				this.moves = this.occupies.xor(this.occupies.and(chessPiecesModel.bluePieces));
			}
//			LOG.info("moves:{0}",this.moves.dump());
			//blocker
			//
			blocker = this.occupies.xor(this.moves);
//			trace("blocker.reverse():",blocker.reverse().dump());

			LOG.debug("blocker.isEmpty:{0}",blocker.isEmpty.toString());
			if(!blocker.isEmpty)
			{
				LOG.debug("blocker:{0}",blocker.dump());
				//
				var east:BitBoard = this.getEast(rowIndex,colIndex);
				var north:BitBoard = this.getNorth(rowIndex,colIndex);
				var west:BitBoard = this.getWest(rowIndex,colIndex);
				var south:BitBoard = this.getSouth(rowIndex,colIndex);
				LOG.debug("east:{0}",east.dump());
				LOG.debug("north:{0}",north.dump());
				LOG.debug("west:{0}",west.dump());
				LOG.debug("south:{0}",south.dump());
				this.moves = east.or(north.or(west.or(south)));
				LOG.debug("moves:{0}",this.moves.dump());
			}
			//about attacked captures.
			//TODO:(find Cannon moutain.)
			if(flag==DefaultConstants.FLAG_RED)
			{
				this.captures = this.moves.and(chessPiecesModel.bluePieces);
			}
			if(flag==DefaultConstants.FLAG_BLUE)
			{
				this.captures = this.moves.and(chessPiecesModel.redPieces);
			}
			LOG.debug("captures:{0}",this.captures.dump());
		}	

		//----------------------------------
		//  X-ray attacks
		//----------------------------------
		//west
		override public function getWest(rowIndex:int, colIndex:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			for(var w:int=colIndex-1;w>=0;w--)
			{
				if(this.flag==DefaultConstants.FLAG_BLUE)
				{
					if(chessPiecesModel.bluePieces.getBitt(rowIndex,w)) break;
					//notice rook's blocker issue.
					if(chessPiecesModel.redPieces.getBitt(rowIndex,w))
					{
						bb.setBitt(rowIndex,w,true);
						break;
					}
				}else
				{
					if(chessPiecesModel.redPieces.getBitt(rowIndex,w)) break;
					//notice rook's blocker issue.
					if(chessPiecesModel.bluePieces.getBitt(rowIndex,w))
					{
						bb.setBitt(rowIndex,w,true);
						break;
					}
				}
				bb.setBitt(rowIndex,w,true);
			}
			return bb;
		}
		//north
		override public function getNorth(rowIndex:int, colIndex:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			for(var n:int=rowIndex-1;n>=0;n--)
			{
				if(this.flag==DefaultConstants.FLAG_BLUE)
				{
					if(chessPiecesModel.bluePieces.getBitt(n,colIndex)) break;
					//notice rook's blocker issue.
					if(chessPiecesModel.redPieces.getBitt(n,colIndex))
					{
						bb.setBitt(n,colIndex,true);
						break;
					}
				}else
				{
					if(chessPiecesModel.redPieces.getBitt(n,colIndex)) break;
					//notice rook's blocker issue.
					if(chessPiecesModel.bluePieces.getBitt(n,colIndex))
					{
						bb.setBitt(n,colIndex,true);
						break;
					}
				}
				bb.setBitt(n,colIndex,true);
			}
			return bb;
		}
		//east
		override public function getEast(rowIndex:int, colIndex:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			for(var e:int=colIndex+1;e<this.column;e++)
			{
				if(this.flag==DefaultConstants.FLAG_BLUE)
				{
					if(chessPiecesModel.bluePieces.getBitt(rowIndex,e)) break;
					//notice rook's blocker issue.
					if(chessPiecesModel.redPieces.getBitt(rowIndex,e))
					{
						bb.setBitt(rowIndex,e,true);
						break;
					}
				}else
				{
					if(chessPiecesModel.redPieces.getBitt(rowIndex,e)) break;
					//notice rook's blocker issue.
					if(chessPiecesModel.bluePieces.getBitt(rowIndex,e))
					{
						bb.setBitt(rowIndex,e,true);
						break;
					}
				}
				bb.setBitt(rowIndex,e,true);
			}
			return bb;
		}
		//south
		override public function getSouth(rowIndex:int, colIndex:int):BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			for(var s:int=rowIndex+1;s<this.row;s++)
			{
				if(this.flag==DefaultConstants.FLAG_BLUE)
				{
					if(chessPiecesModel.bluePieces.getBitt(s,colIndex)) break;
					//notice rook's blocker issue.
					if(chessPiecesModel.redPieces.getBitt(s,colIndex))
					{
						bb.setBitt(s,colIndex,true);
						break;
					}
				}else
				{
					if(chessPiecesModel.redPieces.getBitt(s,colIndex)) break;
					//notice rook's blocker issue.
					if(chessPiecesModel.bluePieces.getBitt(s,colIndex))
					{
						bb.setBitt(s,colIndex,true);
						break;
					}
				}
				bb.setBitt(s,colIndex,true);
			}
			return bb;
		}
	}
}

