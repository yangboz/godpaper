package com.godpaper.as3.tasks
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
//	import com.adobe.cairngorm.task.Task;
	import com.godpaper.as3.configs.BoardConfig;
	import com.godpaper.as3.core.IChessPiece;
	import com.godpaper.as3.model.ChessGasketsModel;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.model.FlexGlobals;
	import com.godpaper.as3.utils.LogUtil;
	import com.godpaper.starling.views.components.ChessGasket;
	import com.godpaper.starling.views.components.ChessPiece;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	import mx.logging.ILogger;
	
	import org.spicefactory.lib.task.Task;

	/**
	 * CleanUpChessPieceTask.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Dec 29, 2010 11:51:40 AM
	 */   	 
	public class CleanUpChessPieceTask extends Task
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var chessPiecesModel:ChessPiecesModel = FlexGlobals.chessPiecesModel;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(CleanUpChessPieceTask);
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
		public function CleanUpChessPieceTask()
		{
			super();
			//Set properties
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
//		override protected function performTask():void
		override protected function doStart():void	
		{
			//clean up chess piece
			for(var v:int=0;v<BoardConfig.yLines;v++)
			{
				for(var h:int=0;h<BoardConfig.xLines;h++)
				{
//					var chessGasket:ChessGasket = (ChessGasketsModel.getInstance().gaskets.gett(h,v) as ChessGasket);
					var chessGasket:ChessGasket = (FlexGlobals.chessGasketsModel.gaskets.gett(h,v) as ChessGasket);
					if( chessGasket.chessPiece )
					{
						LOG.info("removed piece:{0}",ChessPiece(chessGasket.chessPiece).label );
						try{
							chessGasket.chessPiece.chessVO = null;
							chessGasket.chessPiece.omenVO = null;
							chessGasket.chessPiece = null;
//							chessGasket.removeElement( chessGasket.chessPiece );
							//
							chessPiecesModel.reds.length = 0;
							chessPiecesModel.blues.length = 0;
								//
						}catch(error:Error)
						{
							//
							LOG.error(error.toString());
						}
					}
				}
			}
			//
			this.complete();
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

