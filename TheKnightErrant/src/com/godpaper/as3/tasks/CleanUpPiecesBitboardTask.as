package com.godpaper.as3.tasks
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
//	import com.adobe.cairngorm.task.Task;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.core.FlexGlobals;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.utils.LogUtil;
	import com.lookbackon.ds.BitBoard;
	
	import mx.logging.ILogger;
	
	import org.spicefactory.lib.task.Task;


	/**
	 * CleanUpPiecesBitboardTask.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jan 4, 2011 5:11:54 PM
	 */
	public class CleanUpPiecesBitboardTask extends Task
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//
		private var chessPiecesModel:ChessPiecesModel = FlexGlobals.chessPiecesModel;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger=LogUtil.getLogger(CleanUpPiecesBitboardTask);
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
		public function CleanUpPiecesBitboardTask()
		{
			super();
			//Set properties
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
//		override protected function performTask():void
		override protected function doStart():void
		{
			//TODO:
			LOG.info("before clean up,allPieces:{0}", chessPiecesModel.allPieces.dump());
			//
			chessPiecesModel.BLUE.clear();
			chessPiecesModel.BLUE_BISHOP.clear();
			chessPiecesModel.BLUE_CANNON.clear();
			chessPiecesModel.BLUE_KNIGHT.clear();
			chessPiecesModel.BLUE_MARSHAL.clear();
			chessPiecesModel.BLUE_OFFICAL.clear();
			chessPiecesModel.BLUE_PAWN.clear();
			chessPiecesModel.BLUE_ROOK.clear();
			//
			chessPiecesModel.RED.clear();
			chessPiecesModel.RED_BISHOP.clear();
			chessPiecesModel.RED_CANNON.clear();
			chessPiecesModel.RED_KNIGHT.clear();
			chessPiecesModel.RED_MARSHAL.clear();
			chessPiecesModel.RED_OFFICAL.clear();
			chessPiecesModel.RED_PAWN.clear();
			chessPiecesModel.RED_ROOK.clear();
			//
			LOG.info("after clean up,allPieces:{0}", chessPiecesModel.allPieces.dump());
			//
			this.complete();
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}

}