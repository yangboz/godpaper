package com.godpaper.as3.tasks
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.adobe.cairngorm.task.Task;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.starling.views.components.ChessPiece;

	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;

	/**
	 * UpdatePiecesOmenVoTask.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Dec 2, 2010 1:43:27 PM
	 */   	 
	public class UpdatePiecesOmenVoTask extends Task
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var chessPiecesModel:ChessPiecesModel = ChessPiecesModel.getInstance();
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:Logger = LogContext.getLogger(UpdatePiecesOmenVoTask);
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
		public function UpdatePiecesOmenVoTask()
		{
			//TODO: implement function
			super();
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
			//TODO:update omen vo.
			for(var i:int=0;i<chessPiecesModel.pieces.length;i++)
			{
				var chessPiece:ChessPiece = chessPiecesModel.pieces[i];
				//update omenVO.
				chessPiece.omenVO.flexibility  = chessPiece.chessVO.moves.cellCount;
				chessPiece.omenVO.threat  = chessPiece.chessVO.captures.cellCount - chessPiece.chessVO.defends.cellCount;
			}
			LOG.info("{0} Chess Pieces' OmenVO Updated !",chessPiecesModel.pieces.length.toString());
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

