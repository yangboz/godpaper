package com.godpaper.as3.tasks
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.adobe.cairngorm.task.Task;
	import com.godpaper.as3.configs.GameConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.consts.DefaultPiecesConstants;
	import com.godpaper.as3.core.IChessPiece;
	import com.godpaper.as3.model.ChessGasketsModel;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.core.FlexGlobals;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.utils.LogUtil;
	import com.godpaper.as3.views.components.ChessGasket;
	import com.godpaper.as3.views.components.ChessPiece;
	import com.lookbackon.ds.BitBoard;
	
	import mx.logging.ILogger;

	/**
	 * UpdateChessPiecesTask.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Dec 2, 2010 1:17:30 PM
	 */   	 
	public class UpdateChessPiecesTask extends Task
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
		private static const LOG:ILogger = LogUtil.getLogger(UpdateChessPiecesTask);
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
		public function UpdateChessPiecesTask(conductVO:ConductVO)
		{
			super();
			//Set properties
			this.label = "UpdateChessPiecesTask";
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
			var cGasket:ChessGasket = 
//				ChessGasketsModel.getInstance().gaskets.gett(conductVO.nextPosition.x,conductVO.nextPosition.y) as ChessGasket;
				FlexGlobals.chessGasketsModel.gaskets.gett(conductVO.nextPosition.x,conductVO.nextPosition.y) as ChessGasket;
			//
//			if(cGasket.numElements>=1)
			if(cGasket.chessPiece)	
			{
				//TODO:chess piece eat off.
//				var removedPiece:ChessPiece = cGasket.getElementAt(0) as ChessPiece;
//				var removedPiece:ChessPiece = cGasket.getChildAt(0) as ChessPiece;
				var removedPiece:ChessPiece = cGasket.chessPiece as ChessPiece;
				var removedIndex:int = GameConfig.chessPieceManager.calculatePieceIndex(removedPiece);
				LOG.info("Eat Off@{0} target:{1}",cGasket.position.toString(),removedPiece.toString());
//				if(ChessPiece(cGasket.getElementAt(0)).label==DefaultPiecesConstants.BLUE_MARSHAL.label)
//				if(ChessPiece(cGasket.getChildAt(0)).label==DefaultPiecesConstants.BLUE_MARSHAL.label)	
				if(ChessPiece(cGasket.chessPiece).label==DefaultPiecesConstants.BLUE_MARSHAL.label)	
				{
					GameConfig.gameStateManager.humanWin();	
				}
//				if(ChessPiece(cGasket.getElementAt(0)).label==DefaultPiecesConstants.RED_MARSHAL.label)
//				if(ChessPiece(cGasket.getChildAt(0)).label==DefaultPiecesConstants.RED_MARSHAL.label)
				if(cGasket.chessPiece.label==DefaultPiecesConstants.RED_MARSHAL.label)	
				{
					GameConfig.gameStateManager.computerWin();
				}
				//clean this bit at pieces.
				BitBoard(FlexGlobals.chessPiecesModel[removedPiece.type]).setBitt(removedPiece.position.y,removedPiece.position.x,false);
				//set eat off value.
				GameConfig.chessPieceManager.eatOffs.push(removedPiece);
				//remove pieces data.
				if(GameConfig.turnFlag==DefaultConstants.FLAG_RED)
				{
					//clean this bit at bluePieces.
					FlexGlobals.chessPiecesModel.blues.splice(removedIndex,1);
				}else
				{
					//clean this bit at redPieces.
					FlexGlobals.chessPiecesModel.reds.splice(removedIndex,1);
				}
				//remove element from gasket.
//				cGasket.removeElementAt(0);
				cGasket.chessPiece = null;
			}
			//
//			cGasket.addElement(conductVO.target as IVisualElement);
			cGasket.chessPiece = conductVO.target as IChessPiece;
			//Align the chess piece's position.
			cGasket.chessPiece.x = cGasket.x;
			cGasket.chessPiece.y = cGasket.y;
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

