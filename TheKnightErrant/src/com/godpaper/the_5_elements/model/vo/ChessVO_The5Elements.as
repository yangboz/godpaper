package com.godpaper.the_5_elements.model.vo
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
	 * The 5 elements(gold,lumber,water,fire,earth) with graph connection and path finding functions.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jul 1, 2011 3:20:15 PM
	 * @see http://www.godpaper.com/godpaper/index.php/手工五行棋
	 */
	public class ChessVO_The5Elements extends AbstractChessVO
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger=LogUtil.getLogger(ChessVO_The5Elements);

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
		public function ChessVO_The5Elements(width:int, height:int, rowIndex:int, colIndex:int, flag:uint=0)
		{
			//TODO: implement function
			super(width, height, rowIndex, colIndex, flag);
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		//
		override public function initialization(rowIndex:int, colIndex:int, flag:uint=0, identifier:String=""):void
		{
			//@see http://www.godpaper.com/godpaper/index.php/手工五行棋
			//  *
			// *s*
			//  *
			//Notice:Don't worry about bitboard over-fence issues,that it wouble be handle it as default.
			//about occupies.
			//right
			if(colIndex<3)
			{
				if( (rowIndex==0 && colIndex==2) || (rowIndex==3 && colIndex==2) )
				{
					
				}else
				{
					this.occupies.setBitt(rowIndex, colIndex + 1, true);
				}
			}
			//left
			if(colIndex>0)
			{
				if( (rowIndex==0 && colIndex==1) || (rowIndex==3 && colIndex==1) )
				{
					
				}else
				{
					this.occupies.setBitt(rowIndex, colIndex - 1, true);
				}
			}
			//down
			if(rowIndex<3)
			{
				if( (rowIndex==2 && colIndex==0) || (rowIndex==2 && colIndex==3) )
				{
					
				}else
				{
					this.occupies.setBitt(rowIndex + 1, colIndex, true);
				}
			}
			//up
			if(rowIndex>0)
			{
				if( (rowIndex==1 && colIndex==0) || (rowIndex==1 && colIndex==3) )
				{
					
				}else
				{
					this.occupies.setBitt(rowIndex - 1, colIndex, true);
				}
			}
			//exceptions by rule
			//	
			LOG.info("occupies:{0}", this.occupies.dump());
			//about legal moves.
			LOG.info(chessPiecesModel.allPieces.dump());
			this.moves=this.occupies.xor(this.occupies.and(chessPiecesModel.allPieces));
			//
			LOG.info("moves:{0}", this.moves.dump());
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
