package the_4_seasons.src.com.godpaper.the_4_seasons.model.vo
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.configs.BoardConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.impl.AbstractChessVO;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.utils.LogUtil;
	import com.godpaper.as3.views.components.ChessPiece;
	import the_4_seasons.src.com.godpaper.the_4_seasons.consts.ChessPiecesConsts_The4Seasons;
	import com.lookbackon.ds.BitBoard;
	
	import mx.logging.ILogger;


	/**
	 * The four seasons chess pieces,each one has its own plaid.Be care of the cross over detection related problems.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Feb 25, 2011 12:38:37 PM
	 * @see http://www.godpaper.com/godpaper/index.php/四季棋
	 */   	 
	public class ChessVO_The4Seasons extends AbstractChessVO
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(ChessVO_The4Seasons);
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
		public function ChessVO_The4Seasons(width:int, height:int, rowIndex:int, colIndex:int, flag:uint=0,identifier:String="")
		{
			super(width, height, rowIndex, colIndex, flag,identifier);
		}     	

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		override public function initialization(rowIndex:int, colIndex:int, flag:uint=0, identifier:String=""):void
		{
			//Define chess occupy/move/capture even defend bitboard here.
			//@see http://www.godpaper.com/godpaper/index.php/四季棋
			// *
			// *s*
			// *
			//Notice:Don't worry about bitboard over-fence issues,that it wouble be handle it as default.
			//about occupies.
			//None of static occupies,cuz it relays on the dynamic board status.
			//serveral admental included()
			for(var col:int=0;col<BoardConfig.xLines;col++)
			{
				this.occupies.setBitt(rowIndex,col,true);
			}
			for(var row:int=0;row<BoardConfig.yLines;row++)
			{
				this.occupies.setBitt(row,colIndex,true);
			}
//			this.occupies.setBitt(rowIndex,colIndex,false);
			LOG.debug("occupies:{0}",this.occupies.dump());
			//about legal moves.
			this.moves = this.occupies.xor(this.occupies.and(chessPiecesModel.allPieces));
			//			LOG.debug("allPieces:{0}",chessPieceModel.allPieces.dump());
			//
			LOG.info("moves:{0}",this.moves.dump());
			//blocker
			//regularly rule.
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
//						bb.setBitt(rowIndex,w,true);
						break;
					}
				}else
				{
					if(chessPiecesModel.redPieces.getBitt(rowIndex,w)) break;
					//notice rook's blocker issue.
					if(chessPiecesModel.bluePieces.getBitt(rowIndex,w))
					{
//						bb.setBitt(rowIndex,w,true);
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
//						bb.setBitt(n,colIndex,true);
						break;
					}
				}else
				{
					if(chessPiecesModel.redPieces.getBitt(n,colIndex)) break;
					//notice rook's blocker issue.
					if(chessPiecesModel.bluePieces.getBitt(n,colIndex))
					{
//						bb.setBitt(n,colIndex,true);
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
//						bb.setBitt(rowIndex,e,true);
						break;
					}
				}else
				{
					if(chessPiecesModel.redPieces.getBitt(rowIndex,e)) break;
					//notice rook's blocker issue.
					if(chessPiecesModel.bluePieces.getBitt(rowIndex,e))
					{
//						bb.setBitt(rowIndex,e,true);
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
//						bb.setBitt(s,colIndex,true);
						break;
					}
				}else
				{
					if(chessPiecesModel.redPieces.getBitt(s,colIndex)) break;
					//notice rook's blocker issue.
					if(chessPiecesModel.bluePieces.getBitt(s,colIndex))
					{
//						bb.setBitt(s,colIndex,true);
						break;
					}
				}
				bb.setBitt(s,colIndex,true);
			}
			return bb;
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

