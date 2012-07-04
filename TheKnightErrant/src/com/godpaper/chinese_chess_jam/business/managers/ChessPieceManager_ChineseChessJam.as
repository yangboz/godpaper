package com.godpaper.chinese_chess_jam.business.managers
{
	import com.godpaper.as3.business.managers.ChessPieceManagerDefault;
	import com.godpaper.as3.configs.GameConfig;
	import com.godpaper.as3.model.ChessGasketsModel;
	import com.godpaper.as3.model.FlexGlobals;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.utils.LogUtil;
	import com.godpaper.chinese_chess_jam.consts.PiecesConstants_ChineseChessJam;
	import com.godpaper.as3.views.components.ChessGasket;
	import com.godpaper.as3.views.components.ChessPiece;
	
	import mx.logging.ILogger;

	/**
	 * The chess piece manager manage chess piece move's validation/makeMove/unMakeMove.</br>
	 * Also a way for the originator to be responsible for saving and restoring its states.</br>
	 * @author Knight.zhou
	 * @history 2010-12-02 using memento design pattern to implment make/unmake functions.
	 */
	public class ChessPieceManager_ChineseChessJam extends ChessPieceManagerDefault
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private const LOG:ILogger=LogUtil.getLogger(ChessPieceManager_ChineseChessJam);
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		//generation.
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		//
		/**
		 * Apply make move data and piece entity change behaviors,to be overrided.
		 * @param conductVO
		 */
		override public function applyMove(conductVO:ConductVO):void
		{
			//clean up firstly.
			super.currentRemovedPieces.length=0;
			//TODO:with roll back function support.
			var cGasket:ChessGasket=chessGaketsModel.gaskets.gett(conductVO.nextPosition.x, conductVO.nextPosition.y) as ChessGasket;
//			if (cGasket.numElements >= 1)
			if (cGasket.numChildren >= 1)
			{
				//TODO:chess piece eat off.
//				var removedPiece:ChessPiece=cGasket.getElementAt(0) as ChessPiece;
				var removedPiece:ChessPiece=cGasket.getChildAt(0) as ChessPiece;
				LOG.info("Eat Off@{0} target:{1}", cGasket.position.toString(), removedPiece.toString());
				//
				currentRemovedPieces.push(removedPiece);
				//Checkmate condition
//				if (ChessPiece(cGasket.getElementAt(0)).label == PiecesConstants_ChineseChessJam.BLUE_MARSHAL.label)
				if (ChessPiece(cGasket.getChildAt(0)).label == PiecesConstants_ChineseChessJam.BLUE_MARSHAL.label)	
				{
					GameConfig.gameStateManager.humanWin();
				}
//				if (ChessPiece(cGasket.getElementAt(0)).label == PiecesConstants_ChineseChessJam.RED_MARSHAL.label)
				if (ChessPiece(cGasket.getChildAt(0)).label == PiecesConstants_ChineseChessJam.RED_MARSHAL.label)	
				{
					GameConfig.gameStateManager.computerWin();
				}
			}
			//
			super.applyMove(conductVO);
		}

	}

}


