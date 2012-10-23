package com.godpaper.cat_and_mouse.model.vo
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.impl.AbstractChessVO;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.core.FlexGlobals;
	import com.godpaper.as3.utils.LogUtil;
	
	import mx.logging.ILogger;


	/**
	 * YourChessVO.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Feb 25, 2011 12:38:37 PM
	 * @see http://www.godpaper.com/godpaper/index.php/%E7%8C%AB%E6%8D%89%E9%BC%A0%E6%A3%8B
	 */   	 
	public class ChessVO_CatAndMouse extends AbstractChessVO
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(ChessVO_CatAndMouse);
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
		public function ChessVO_CatAndMouse(width:int, height:int, rowIndex:int, colIndex:int, flag:uint=0,identifier:String="")
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
			if(rowIndex==0)
			{
				if(colIndex==0)
				{
					//
				}
				if(colIndex==1)
				{
					this.occupies.setBitt(rowIndex,colIndex+1,true);
					this.occupies.setBitt(rowIndex+1,colIndex,true);
					this.occupies.setBitt(rowIndex+1,colIndex-1,true);
				}
				if(colIndex==2 || colIndex==3)
				{
					this.occupies.setBitt(rowIndex,colIndex-1,true);
					this.occupies.setBitt(rowIndex,colIndex+1,true);
					this.occupies.setBitt(rowIndex+1,colIndex,true);
				}
				if(colIndex==4)
				{
					this.occupies.setBitt(rowIndex,colIndex-1,true);
					this.occupies.setBitt(rowIndex+1,colIndex,true);
				}
			}
			//1
			if(rowIndex==1)
			{
				if(colIndex==0)
				{
					this.occupies.setBitt(rowIndex,colIndex+1,true);
					this.occupies.setBitt(rowIndex+1,colIndex,true);
					this.occupies.setBitt(rowIndex-1,colIndex+1,true);
				}
				if( colIndex==1 || colIndex==2 || colIndex==3)
				{
					this.occupies.setBitt(rowIndex,colIndex-1,true);
					this.occupies.setBitt(rowIndex,colIndex+1,true);
					this.occupies.setBitt(rowIndex+1,colIndex,true);
					this.occupies.setBitt(rowIndex-1,colIndex,true);
				}
				if(colIndex==4)
				{
					this.occupies.setBitt(rowIndex,colIndex-1,true);
					this.occupies.setBitt(rowIndex+1,colIndex,true);
					this.occupies.setBitt(rowIndex-1,colIndex,true);
				}
			}
			//2,3
			if((rowIndex==2)||(rowIndex==3))
			{
				if(colIndex==0)
				{
					this.occupies.setBitt(rowIndex,colIndex+1,true);
					this.occupies.setBitt(rowIndex+1,colIndex,true);
					this.occupies.setBitt(rowIndex-1,colIndex,true);
				}
				if( colIndex==1 || colIndex==2 || colIndex==3)
				{
					this.occupies.setBitt(rowIndex,colIndex-1,true);
					this.occupies.setBitt(rowIndex,colIndex+1,true);
					this.occupies.setBitt(rowIndex+1,colIndex,true);
					this.occupies.setBitt(rowIndex-1,colIndex,true);
				}
				if(colIndex==4)
				{
					this.occupies.setBitt(rowIndex,colIndex-1,true);
					this.occupies.setBitt(rowIndex+1,colIndex,true);
					this.occupies.setBitt(rowIndex-1,colIndex,true);
				}
			}
			//4
			if(rowIndex==4)
			{
				if(colIndex==0)
				{
					this.occupies.setBitt(rowIndex,colIndex+1,true);
					this.occupies.setBitt(rowIndex-1,colIndex,true);
				}
				if( colIndex==1 || colIndex==2 || colIndex==3)
				{
					this.occupies.setBitt(rowIndex,colIndex-1,true);
					this.occupies.setBitt(rowIndex,colIndex+1,true);
					this.occupies.setBitt(rowIndex-1,colIndex,true);
				}
				if(colIndex==4)
				{
					this.occupies.setBitt(rowIndex,colIndex-1,true);
					this.occupies.setBitt(rowIndex-1,colIndex,true);
				}
			}
			//
			LOG.info("occupies:{0}",this.occupies.dump());
			//about legal moves.
			LOG.info(chessPiecesModel.allPieces.dump());
			if(flag==DefaultConstants.FLAG_RED)
			{
				this.moves = this.occupies.xor(this.occupies.and(chessPiecesModel.redPieces));
			}
			if(flag==DefaultConstants.FLAG_BLUE)
			{
				this.moves = this.occupies.xor(this.occupies.and(chessPiecesModel.bluePieces));
			}
			//
			LOG.info("moves:{0}",this.moves.dump());
			//blocker
			//about attacked captures.
			if(flag==DefaultConstants.FLAG_RED)
			{
				this.captures = this.moves.and(chessPiecesModel.bluePieces);
			}
			//Mouse can not capture Cat.
//			if(flag==DefaultConstants.FLAG_BLUE)
//			{
//				this.captures = this.moves.and(ChessPiecesModel.getInstance().redPieces);
//			}
			LOG.debug("captures:{0}",this.captures.dump());
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

