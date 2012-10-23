package com.godpaper.the_2_tigers.model.vo
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.impl.AbstractChessVO;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.utils.LogUtil;

	import mx.logging.ILogger;


	/**
	 * The 2 tigers chess value object,include the occuipes,moves,capture,defends bitboards.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Feb 25, 2011 12:38:37 PM
	 * @see http://www.godpaper.com/godpaper/index.php/%E4%BA%8C%E8%99%8E%E6%A3%8B
	 */   	 
	public class ChessVO_The2Tigers extends AbstractChessVO
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(ChessVO_The2Tigers);
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
		public function ChessVO_The2Tigers(width:int, height:int, rowIndex:int, colIndex:int, flag:uint=0, identifier:String="")
		{
			//TODO: implement function
			super(width, height, rowIndex, colIndex, flag,identifier);
		}     	

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		override public function initialization(rowIndex:int, colIndex:int, flag:uint=0, identifier:String=""):void
		{
			//TODO: implement function
			//Define chess occupy/move/capture even defend bitboard here.
			//@see http://www.godpaper.com/godpaper/index.php/%E5%B0%8F%E7%A0%96%E6%A0%BC%E6%A3%8B
			// *
			// *s*
			// *
			//Notice:Don't worry about bitboard over-fence issues,that it wouble be handle it as default.
			//about occupies.
			//0
			if(rowIndex==0)
			{
				if(colIndex==0)
				{
					this.occupies.setBitt(rowIndex,colIndex+1,true);
					this.occupies.setBitt(rowIndex+1,colIndex,true);
					this.occupies.setBitt(rowIndex+1,colIndex+1,true);
				}
				if(colIndex==1)
				{
					this.occupies.setBitt(rowIndex,colIndex+1,true);
					this.occupies.setBitt(rowIndex,colIndex-1,true);
					this.occupies.setBitt(rowIndex+1,colIndex,true);
				}
				if(colIndex==2)
				{
					this.occupies.setBitt(rowIndex,colIndex+1,true);
					this.occupies.setBitt(rowIndex,colIndex-1,true);
					this.occupies.setBitt(rowIndex+1,colIndex,true);
					this.occupies.setBitt(rowIndex+1,colIndex-1,true);
					this.occupies.setBitt(rowIndex+1,colIndex+1,true);
				}
				if(colIndex==3)
				{
					this.occupies.setBitt(rowIndex,colIndex+1,true);
					this.occupies.setBitt(rowIndex,colIndex-1,true);
					this.occupies.setBitt(rowIndex+1,colIndex,true);
				}
				if(colIndex==4)
				{
					this.occupies.setBitt(rowIndex,colIndex+1,true);
					this.occupies.setBitt(rowIndex+1,colIndex,true);
					this.occupies.setBitt(rowIndex+1,colIndex-1,true);
				}
			}
			//1
			if((rowIndex==1)||(rowIndex==3)||(rowIndex==5))
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
					this.occupies.setBitt(rowIndex,colIndex+1,true);
					this.occupies.setBitt(rowIndex-1,colIndex,true);
				}
			}
			//2,4
			if((rowIndex==2)||(rowIndex==4))
			{
				if(colIndex==0)
				{
					this.occupies.setBitt(rowIndex,colIndex+1,true);
					this.occupies.setBitt(rowIndex-1,colIndex,true);
				}
				if(colIndex==1)
				{
					this.occupies.setBitt(rowIndex,colIndex+1,true);
					this.occupies.setBitt(rowIndex,colIndex-1,true);
					this.occupies.setBitt(rowIndex+1,colIndex,true);
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
					this.occupies.setBitt(rowIndex+1,colIndex,true);
				}
			}
			//
			LOG.info("occupies:{0}",this.occupies.dump());
			//about legal moves.
			LOG.info(chessPiecesModel.allPieces.dump());
			this.moves = this.occupies.xor(this.occupies.and(chessPiecesModel.allPieces));
			//
			LOG.info("moves:{0}",this.moves.dump());
			//blocker
			//about attacked captures.
			//about defends.
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

