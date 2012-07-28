package com.godpaper.tiger_in_beijing.model.vo
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.impl.AbstractChessVO;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.utils.LogUtil;
	import com.lookbackon.ds.BitBoard;
	
	import mx.logging.ILogger;


	/**
	 * YourChessVO.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Feb 25, 2011 12:38:37 PM
	 */   	 
	public class ChessVO_TigerInBeijing extends AbstractChessVO
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(ChessVO_TigerInBeijing);
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
		public function ChessVO_TigerInBeijing(width:int, height:int, rowIndex:int, colIndex:int, flag:int=0)
		{
			//TODO: implement function
			super(width, height, rowIndex, colIndex, flag);
		}     	

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		override public function initialization(rowIndex:int, colIndex:int, flag:int=0, identifier:String=""):void
		{
			//TODO: implement function
			//Define chess occupy/move/capture even defend bitboard here.
			//@see http://www.godpaper.com/godpaper/index.php/%E5%B0%8F%E7%A0%96%E6%A0%BC%E6%A3%8B
			// *
			// *s*
			// *
			//Notice:Don't worry about bitboard over-fence issues,that it wouble be handle it as default.
			if(DefaultConstants.FLAG_BLUE == flag)
			{
				//about occupies.
				if(rowIndex==0)
				{
					if(colIndex==0)
					{
					}
					if(colIndex==1)
					{
						this.occupies.setBitt(rowIndex,colIndex+1,true);
						this.occupies.setBitt(rowIndex+1,colIndex,true);
						this.occupies.setBitt(rowIndex+1,colIndex+1,true);
					}
					if(colIndex==2)
					{
						this.occupies.setBitt(rowIndex,colIndex-1,true);
						this.occupies.setBitt(rowIndex,colIndex+1,true);
						this.occupies.setBitt(rowIndex+1,colIndex,true);
					}
					if(colIndex==3)
					{
						this.occupies.setBitt(rowIndex,colIndex-1,true);
						this.occupies.setBitt(rowIndex+1,colIndex,true);
						this.occupies.setBitt(rowIndex+1,colIndex,true);
					}
					if(colIndex==4)
					{
					}
				}
				if(rowIndex==1)
				{
					if(colIndex==0)
					{
					}
					if(colIndex==1)
					{
						this.occupies.setBitt(rowIndex,colIndex-1,true);
						this.occupies.setBitt(rowIndex,colIndex+1,true);
						this.occupies.setBitt(rowIndex-1,colIndex,true);
					}
					if(colIndex==2)
					{
						this.occupies.setBitt(rowIndex-1,colIndex-1,true);
						this.occupies.setBitt(rowIndex,colIndex-1,true);
						this.occupies.setBitt(rowIndex+1,colIndex-1,true);
						
						this.occupies.setBitt(rowIndex-1,colIndex,true);
						this.occupies.setBitt(rowIndex+1,colIndex,true);
						
						this.occupies.setBitt(rowIndex-1,colIndex+1,true);
						this.occupies.setBitt(rowIndex,colIndex+1,true);
						this.occupies.setBitt(rowIndex+1,colIndex+1,true);
					}
					if(colIndex==3)
					{
						this.occupies.setBitt(rowIndex,colIndex-1,true);
						this.occupies.setBitt(rowIndex-1,colIndex,true);
						this.occupies.setBitt(rowIndex+1,colIndex,true);
					}
					if(colIndex==4)
					{
					}
				}
				if(rowIndex==2)
				{
					if(colIndex==0)
					{
						this.occupies.setBitt(rowIndex,colIndex+1,true);
						this.occupies.setBitt(rowIndex+1,colIndex,true);
					}
					if(colIndex==1)
					{
						this.occupies.setBitt(rowIndex,colIndex-1,true);
						this.occupies.setBitt(rowIndex,colIndex+1,true);
						this.occupies.setBitt(rowIndex-1,colIndex,true);
						this.occupies.setBitt(rowIndex-1,colIndex+1,true);
						
						this.occupies.setBitt(rowIndex+1,colIndex,true);
					}
					if(colIndex==2)
					{
						this.occupies.setBitt(rowIndex,colIndex-1,true);
						this.occupies.setBitt(rowIndex,colIndex+1,true);
						this.occupies.setBitt(rowIndex-1,colIndex,true);
						
						this.occupies.setBitt(rowIndex+1,colIndex,true);
					}
					if(colIndex==3)
					{
						this.occupies.setBitt(rowIndex,colIndex-1,true);
						this.occupies.setBitt(rowIndex,colIndex+1,true);
						this.occupies.setBitt(rowIndex-1,colIndex,true);
						this.occupies.setBitt(rowIndex-1,colIndex-1,true);
						
						this.occupies.setBitt(rowIndex+1,colIndex,true);
					}
					if(colIndex==4)
					{
						this.occupies.setBitt(rowIndex,colIndex-1,true);
						
						this.occupies.setBitt(rowIndex+1,colIndex,true);
					}
				}
				if(rowIndex>2)
				{
					if(colIndex==0)
					{
						this.occupies.setBitt(rowIndex-1,colIndex,true);
						this.occupies.setBitt(rowIndex,colIndex+1,true);
						this.occupies.setBitt(rowIndex-1,colIndex+1,true);
						
						this.occupies.setBitt(rowIndex+1,colIndex,true);
					}
					if(colIndex==1 || colIndex==3)
					{
						this.occupies.setBitt(rowIndex-1,colIndex,true);
						this.occupies.setBitt(rowIndex,colIndex-1,true);
						this.occupies.setBitt(rowIndex,colIndex+1,true);
						
						this.occupies.setBitt(rowIndex+1,colIndex,true);
					}
					if(colIndex==2)
					{
						this.occupies.setBitt(rowIndex-1,colIndex,true);
						this.occupies.setBitt(rowIndex,colIndex-1,true);
						this.occupies.setBitt(rowIndex,colIndex+1,true);
						this.occupies.setBitt(rowIndex-1,colIndex-1,true);
						this.occupies.setBitt(rowIndex-1,colIndex+1,true);
						
						this.occupies.setBitt(rowIndex+1,colIndex,true);
					}
					if(colIndex==4)
					{
						this.occupies.setBitt(rowIndex-1,colIndex,true);
						this.occupies.setBitt(rowIndex,colIndex-1,true);
						this.occupies.setBitt(rowIndex-1,colIndex-1,true);
						
						this.occupies.setBitt(rowIndex+1,colIndex,true);
					}
				}
			}else
			{
				//about occupies.
				if(rowIndex==0)
				{
					if(colIndex==0)
					{
					}
					if(colIndex==1)
					{
						this.occupies.setBitt(rowIndex,colIndex+1,true);
					}
					if(colIndex==2)
					{
						this.occupies.setBitt(rowIndex,colIndex-1,true);
						this.occupies.setBitt(rowIndex,colIndex+1,true);
					}
					if(colIndex==3)
					{
						this.occupies.setBitt(rowIndex,colIndex-1,true);
					}
					if(colIndex==4)
					{
					}
				}
				if(rowIndex==1)
				{
					if(colIndex==0)
					{
					}
					if(colIndex==1)
					{
						this.occupies.setBitt(rowIndex,colIndex-1,true);
						this.occupies.setBitt(rowIndex,colIndex+1,true);
					}
					if(colIndex==2)
					{
						this.occupies.setBitt(rowIndex,colIndex-1,true);
						this.occupies.setBitt(rowIndex,colIndex+1,true);
						
						this.occupies.setBitt(rowIndex-1,colIndex-1,true);
						this.occupies.setBitt(rowIndex-1,colIndex,true);
						this.occupies.setBitt(rowIndex-1,colIndex+1,true);
					}
					if(colIndex==3)
					{
						this.occupies.setBitt(rowIndex,colIndex-1,true);
						this.occupies.setBitt(rowIndex-1,colIndex,true);
					}
					if(colIndex==4)
					{
					}
				}
				if(rowIndex==2)
				{
					if(colIndex==0)
					{
						this.occupies.setBitt(rowIndex,colIndex+1,true);
					}
					if(colIndex==1)
					{
						this.occupies.setBitt(rowIndex,colIndex-1,true);
						this.occupies.setBitt(rowIndex,colIndex+1,true);
						this.occupies.setBitt(rowIndex-1,colIndex,true);
						this.occupies.setBitt(rowIndex-1,colIndex+1,true);
					}
					if(colIndex==2)
					{
						this.occupies.setBitt(rowIndex,colIndex-1,true);
						this.occupies.setBitt(rowIndex,colIndex+1,true);
						this.occupies.setBitt(rowIndex-1,colIndex,true);
					}
					if(colIndex==3)
					{
						this.occupies.setBitt(rowIndex,colIndex-1,true);
						this.occupies.setBitt(rowIndex,colIndex+1,true);
						this.occupies.setBitt(rowIndex-1,colIndex,true);
						this.occupies.setBitt(rowIndex-1,colIndex-1,true);
					}
					if(colIndex==4)
					{
						this.occupies.setBitt(rowIndex,colIndex-1,true);
					}
				}
				if(rowIndex>2)
				{
					if(colIndex==0)
					{
						this.occupies.setBitt(rowIndex-1,colIndex,true);
						this.occupies.setBitt(rowIndex,colIndex+1,true);
						this.occupies.setBitt(rowIndex-1,colIndex+1,true);
					}
					if(colIndex==1 || colIndex==3)
					{
						this.occupies.setBitt(rowIndex-1,colIndex,true);
						this.occupies.setBitt(rowIndex,colIndex-1,true);
						this.occupies.setBitt(rowIndex,colIndex+1,true);
					}
					if(colIndex==2)
					{
						this.occupies.setBitt(rowIndex-1,colIndex,true);
						this.occupies.setBitt(rowIndex,colIndex-1,true);
						this.occupies.setBitt(rowIndex,colIndex+1,true);
						this.occupies.setBitt(rowIndex-1,colIndex-1,true);
						this.occupies.setBitt(rowIndex-1,colIndex+1,true);
					}
					if(colIndex==4)
					{
						this.occupies.setBitt(rowIndex-1,colIndex,true);
						this.occupies.setBitt(rowIndex,colIndex-1,true);
						this.occupies.setBitt(rowIndex-1,colIndex-1,true);
					}
				}
				
			}
			//
			LOG.info("occupies:{0}",this.occupies.dump());
			//about legal moves.
			LOG.info(chessPiecesModel.allPieces.dump());
			this.moves = this.occupies.xor(this.occupies.and(chessPiecesModel.allPieces));
			//
			LOG.info("moves:{0}",this.moves.dump());
			if(DefaultConstants.FLAG_BLUE == flag)
			{
				//blocker
				blocker = this.occupies.xor(this.moves);
				//
				LOG.debug("blocker.isEmpty:{0}",blocker.isEmpty.toString());
				if(!blocker.isEmpty)
				{
					LOG.debug("blocker:{0}",blocker.dump());
					// LOG.debug("all pieces:{0}",ChessPiecesModel.getInstance().allPieces.dump());
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
		}
		//----------------------------------
		// X-ray attacks(override)
		//----------------------------------
		//west
		override public function getWest(rowIndex:int, colIndex:int):BitBoard
		{
			var mountIndex:int = -1;//find cannon mount().
			var bb:BitBoard = new BitBoard(this.column,this.row);
			for(var w:int=colIndex-1;w>=0;w--)
			{
				if(chessPiecesModel.allPieces.getBitt(rowIndex,w))
				{
					mountIndex = w;
					break;
				}else
				{
					bb.setBitt(rowIndex,w,true);
				}
			}
			if(mountIndex!=-1)
			{
				for(var m:int=mountIndex-1;m>=0;m--)
				{
					if(this.flag==DefaultConstants.FLAG_BLUE)
					{
						if(chessPiecesModel.bluePieces.getBitt(rowIndex,m)) break;
						if(chessPiecesModel.redPieces.getBitt(rowIndex,m))
						{
							bb.setBitt(rowIndex,m,true);
							break;
						}
					}else
					{
						if(chessPiecesModel.redPieces.getBitt(rowIndex,m)) break;
						if(chessPiecesModel.bluePieces.getBitt(rowIndex,m))
						{
							bb.setBitt(rowIndex,m,true);
							break;
						}
					}
				}
			}
			return bb;
		}
		//north
		override public function getNorth(rowIndex:int, colIndex:int):BitBoard
		{
			var mountIndex:int = -1;//find cannon mount().
			var bb:BitBoard = new BitBoard(this.column,this.row);
			for(var n:int=rowIndex-1;n>=0;n--)
			{
				if(chessPiecesModel.allPieces.getBitt(n,colIndex))
				{
					mountIndex = n;
					break;
				}else
				{
					bb.setBitt(n,colIndex,true);
				}
			}
			if(mountIndex!=-1)
			{
				for(var m:int=mountIndex-1;m>=0;m--)
				{
					if(this.flag==DefaultConstants.FLAG_BLUE)
					{
						if(chessPiecesModel.bluePieces.getBitt(m,colIndex)) break;
						if(chessPiecesModel.redPieces.getBitt(m,colIndex))
						{
							bb.setBitt(m,colIndex,true);
							break;
						}
					}else
					{
						if(chessPiecesModel.redPieces.getBitt(m,colIndex)) break;
						if(chessPiecesModel.bluePieces.getBitt(m,colIndex))
						{
							bb.setBitt(m,colIndex,true);
							break;
						}
					}
				}
			}
			return bb;
		}
		//east
		override public function getEast(rowIndex:int, colIndex:int):BitBoard
		{
			var mountIndex:int = -1;//find cannon mount().
			var bb:BitBoard = new BitBoard(this.column,this.row);
			for(var e:int=colIndex+1;e<this.column;e++)
			{
				if(chessPiecesModel.allPieces.getBitt(rowIndex,e))
				{
					mountIndex = e;
					break;
				}else
				{
					bb.setBitt(rowIndex,e,true);
				}
			}
			if(mountIndex!=-1)
			{
				for(var m:int=mountIndex+1;m<this.column;m++)
				{
					if(this.flag==DefaultConstants.FLAG_BLUE)
					{
						if(chessPiecesModel.bluePieces.getBitt(rowIndex,m)) break;
						if(chessPiecesModel.redPieces.getBitt(rowIndex,m))
						{
							bb.setBitt(rowIndex,m,true);
							break;
						}
					}else
					{
						if(chessPiecesModel.redPieces.getBitt(rowIndex,m)) break;
						if(chessPiecesModel.bluePieces.getBitt(rowIndex,m))
						{
							bb.setBitt(rowIndex,m,true);
							break;
						}
					}
				}
			}
			return bb;
		}
		//south
		override public function getSouth(rowIndex:int, colIndex:int):BitBoard
		{
			var mountIndex:int = -1;//find cannon mount().
			var bb:BitBoard = new BitBoard(this.column,this.row);
			for(var s:int=rowIndex+1;s<this.row;s++)
			{
				if(chessPiecesModel.allPieces.getBitt(s,colIndex))
				{
					mountIndex = s;
					break;
				}else
				{
					bb.setBitt(s,colIndex,true);
				}
			}
			if(mountIndex!=-1)
			{
				for(var m:int=mountIndex+1;m<this.row;m++)
				{
					if(this.flag==DefaultConstants.FLAG_BLUE)
					{
						if(chessPiecesModel.bluePieces.getBitt(m,colIndex)) break;
						if(chessPiecesModel.redPieces.getBitt(m,colIndex))
						{
							bb.setBitt(m,colIndex,true);
							break;
						}
					}else
					{
						if(chessPiecesModel.redPieces.getBitt(m,colIndex)) break;
						if(chessPiecesModel.bluePieces.getBitt(m,colIndex))
						{
							bb.setBitt(m,colIndex,true);
							break;
						}
					}
				}
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

