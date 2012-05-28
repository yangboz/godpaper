package com.godpaper.as3.tasks
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.adobe.cairngorm.task.Task;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.lookbackon.ds.BitBoard;
	
	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;
	
	/**
	 * UpdatePiecesBitboardTask.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Dec 2, 2010 1:15:34 PM
	 */   	 
	public class UpdatePiecesBitboardTask extends Task
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var conductVO:ConductVO;
		//
		private var chessPiecesModel:ChessPiecesModel = ChessPiecesModel.getInstance();
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:Logger = LogContext.getLogger(UpdatePiecesBitboardTask);
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
		public function UpdatePiecesBitboardTask(conductVO:ConductVO)
		{
			super();
			//Set properties
			this.label = "UpdatePiecesBitboardTask";
			//
			this.conductVO = conductVO;
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
		override protected function performTask():void
		{
			//TODO:
			LOG.debug("before move,allPieces:{0}",chessPiecesModel.allPieces.dump());
			BitBoard(chessPiecesModel[conductVO.target.type]).setBitt(conductVO.nextPosition.y,conductVO.nextPosition.x,true);
			BitBoard(chessPiecesModel[conductVO.target.type]).setBitt(conductVO.previousPosition.y,conductVO.previousPosition.x,false);
			LOG.info("after move,allPieces:{0}",chessPiecesModel.allPieces.dump());
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