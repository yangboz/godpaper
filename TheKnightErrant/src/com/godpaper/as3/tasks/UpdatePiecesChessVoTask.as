package com.godpaper.as3.tasks
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.adobe.cairngorm.task.Task;
	import com.godpaper.as3.core.IChessFactory;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.utils.LogUtil;
	import com.godpaper.starling.views.components.ChessPiece;
	
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import mx.logging.ILogger;

	/**
	 * UpdatePiecesChessVoTask.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Dec 2, 2010 1:16:34 PM
	 */   	 
	public class UpdatePiecesChessVoTask extends ChessTaskBase
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
		private static const LOG:ILogger = LogUtil.getLogger(UpdatePiecesChessVoTask);
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
		public function UpdatePiecesChessVoTask(factory:Class)
		{
			super();
			//Set properties
			this.label = "UpdatePiecesChessVoTask";
			//
			this.factory = factory;
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
			var className:String = getQualifiedClassName(factory);
			var implementation:Object = getDefinitionByName(className);
			var realFactoy:IChessFactory  = new implementation();
			//TODO:
			for(var i:int=0;i<chessPiecesModel.pieces.length;i++)
			{
				var chessPiece:ChessPiece = chessPiecesModel.pieces[i];
				//renew data.
				var currentConductVO:ConductVO = new ConductVO();
				currentConductVO.target = chessPiece;
				//				LOG.info("before move,currentConductVO:{0}",currentConductVO.dump());
				//				LOG.info("before move,chessPiece's chessVO's legal moves:{0}",chessPiece.chessVO.moves.dump());
				//renew chessVO.
				chessPiece.chessVO = realFactoy.generateChessVO(currentConductVO);
					//				LOG.info("after move,chessPiece's chessVO's legal moves:{0}",chessPiece.chessVO.moves.dump());
			}
			LOG.info("{0} Chess Pieces' ChessVO Updated !",chessPiecesModel.pieces.length.toString());
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

