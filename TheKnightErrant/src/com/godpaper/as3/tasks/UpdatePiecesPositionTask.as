package com.godpaper.as3.tasks
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.adobe.cairngorm.task.Task;
	import com.godpaper.as3.model.ChessGasketsModel;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.starling.views.components.ChessGasket;

	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;

	/**
	 * UpdatePiecesPostionTask.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Dec 2, 2010 1:14:27 PM
	 */   	 
	public class UpdatePiecesPositionTask extends Task
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var conductVO:ConductVO;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:Logger = LogContext.getLogger(UpdatePiecesPositionTask);
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
		public function UpdatePiecesPositionTask(conductVO:ConductVO)
		{
			super();
			//Set properties
			this.label = "UpdatePiecesPositionTask";
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
			var cGasket:ChessGasket = 
				ChessGasketsModel.getInstance().gaskets.gett(conductVO.nextPosition.x,conductVO.nextPosition.y) as ChessGasket;
			this.conductVO.target.position = cGasket.position;
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

