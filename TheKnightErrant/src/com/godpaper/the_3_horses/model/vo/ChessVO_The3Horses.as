package com.godpaper.the_3_horses.model.vo
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
	
	import mx.logging.ILogger;


	/**
	 * YourChessVO.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Feb 25, 2011 12:38:37 PM
	 * @see http://www.godpaper.com/godpaper/index.php/%E4%B8%89%E9%A9%AC%E6%A3%8B
	 */   	 
	public class ChessVO_The3Horses extends AbstractChessVO
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(ChessVO_The3Horses);
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
		public function ChessVO_The3Horses(width:int, height:int, rowIndex:int, colIndex:int, flag:uint=0,identifier:String="")
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
			// - - * - * - -
			// - - - - - - -
			// * - - - - - *
			// - - - s - - -
			// * - - - - - *
			// - - - - - - -
			// - - * - * - -
			//serveral admental(马撇脚问题)
			//left direction.
			if(!chessPiecesModel.allPieces.getBitt(rowIndex+1,colIndex-1))
			{
				//several amendments.
				if( (rowIndex+1<=BoardConfig.yLines-1) && (colIndex-3>=0))
				{
					this.occupies.setBitt(rowIndex+1,colIndex-3,true);
				}
			}
			if(!chessPiecesModel.allPieces.getBitt(rowIndex-1,colIndex-1))
			{
				//several amendments.
				if( (rowIndex-1>=0) && (colIndex-3>=0) )
				{
					this.occupies.setBitt(rowIndex-1,colIndex-3,true);
				}
			}
			//up direction.
			if(!chessPiecesModel.allPieces.getBitt(rowIndex-1,colIndex-1))
			{
				//several amendments.
				if( (rowIndex-3>=0) && (colIndex-1>=0) )
				{
					this.occupies.setBitt(rowIndex-3,colIndex-1,true);
				}
			}
			if(!chessPiecesModel.allPieces.getBitt(rowIndex-1,colIndex+1))
			{
				//several amendments.
				if( (rowIndex-3>=0) && (colIndex+1<=BoardConfig.xLines-1) )
				{
					this.occupies.setBitt(rowIndex-3,colIndex+1,true);
				}
			}
			//right direction.
			if(!chessPiecesModel.allPieces.getBitt(rowIndex+1,colIndex+1))
			{
				//several amendments.
				if( ( rowIndex+1<=BoardConfig.yLines-1) && (colIndex+3<=BoardConfig.xLines-1) )
				{
					this.occupies.setBitt(rowIndex+1,colIndex+3,true);
				}
			}
			if(!chessPiecesModel.allPieces.getBitt(rowIndex-1,colIndex+1))
			{
				//several amendments.
				if( ( rowIndex-1 >=0 ) && (colIndex+3<=BoardConfig.xLines-1) )
				{
					this.occupies.setBitt(rowIndex-1,colIndex+3,true);
				}
			}
			//down direction.
			if(!chessPiecesModel.allPieces.getBitt(rowIndex+1,colIndex+1))
			{
				//several amendments.
				if( ( rowIndex+3<=BoardConfig.yLines-1 ) && (colIndex+1<=BoardConfig.xLines-1) )
				{
					this.occupies.setBitt(rowIndex+3,colIndex+1,true);
				}
			}
			if(!chessPiecesModel.allPieces.getBitt(rowIndex+1,colIndex-1))
			{
				//several amendments.
				if( ( rowIndex+3<=BoardConfig.yLines-1 ) && (colIndex-1>=0) )
				{
					this.occupies.setBitt(rowIndex+3,colIndex-1,true);
				}
			}
			//about legal moves.
			this.moves = this.occupies.xor(this.occupies.and(chessPiecesModel.allPieces));
			//about attacked captures.
			//no capture here.
//			if(flag==DefaultConstants.FLAG_RED)
//			{
//				this.captures = this.moves.and(ChessPiecesModel.getInstance().bluePieces);
//			}
//			if(flag==DefaultConstants.FLAG_BLUE)
//			{
//				this.captures = this.moves.and(ChessPiecesModel.getInstance().redPieces);
//			}
			//
			LOG.debug("occupies:{0}",this.occupies.dump());
			LOG.debug("moves:{0}",this.moves.dump());
//			LOG.debug("captures:{0}",this.captures.dump());
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

