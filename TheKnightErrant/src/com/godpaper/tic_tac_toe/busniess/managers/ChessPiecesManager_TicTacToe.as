package com.godpaper.tic_tac_toe.busniess.managers
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.business.managers.ChessPieceManagerDefault;
	import com.godpaper.as3.business.managers.GameStateManagerDefault;
	import com.godpaper.as3.configs.BoardConfig;
	import com.godpaper.as3.configs.GameConfig;
	import com.godpaper.as3.model.ChessBoardModel;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.model.FlexGlobals;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.utils.LogUtil;
	import com.godpaper.starling.views.components.ChessPiece;
	import com.lookbackon.ds.NumberBoard;
	
	import de.polygonal.ds.Array2;
	
	import mx.logging.ILogger;


	/**
	 * YourChessPiecesManager.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Feb 25, 2011 12:38:06 PM
	 */   	 
	public class ChessPiecesManager_TicTacToe extends ChessPieceManagerDefault
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var chessPieceModel:ChessPiecesModel = FlexGlobals.chessPiecesModel;
		private var chessBoardModel:ChessBoardModel = FlexGlobals.chessBoardModel;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(ChessPiecesManager_TicTacToe);
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
		public function ChessPiecesManager_TicTacToe()
		{
			//TODO: implement function
			super();
		}     	

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		override public function applyMove(conductVO:ConductVO):void
		{
			//super call here.
			super.applyMove(conductVO);
			//Apply your chess game rule here.
		}
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		override protected function blueSideHandler():void
		{
//			var cBoard:Array2=chessBoardModel.status.board;
//			//				var connex:Array=mnm.getConnex(cBoard, NUM_CONNECTION);
//			var connex:Array=chessBoardModel.numercal.getConnex(cBoard,BoardConfig.numConnex);
//			LOG.debug("current board connex:{0}", connex);
//			//horizontally.
//			if(connex[0].length)
//			{
//				LOG.debug("Computer connex[0]:", connex[0]);
//				//					trace(connex[0][0].length,(cBoard.getRow(BoardConfig.yLines).length-1),BoardConfig.numConnex);
//				if ( (connex[0][0].length == BoardConfig.numConnex) &&  ((cBoard.getRow(BoardConfig.yLines).length-1) == BoardConfig.numConnex) )
//				{
//					//Computer Win
//					GameConfig.gameStateManager.computerWin();
//				}
//			}
			//another simple rule functions here.
			if(chessPieceModel.blues.every(onTheBottom))
			{
				//Computer Win
				GameConfig.gameStateManager.computerWin();
			}
		}
		override protected function redSideHandler():void
		{
//			var cBoard:Array2=chessBoardModel.status.board;
//			//				var connex:Array=mnm.getConnex(cBoard, NUM_CONNECTION);
//			var connex:Array=chessBoardModel.numercal.getConnex(cBoard,BoardConfig.numConnex);
//			LOG.debug("current board connex:{0}", connex);
//			//horizontally.
//			if(connex[0].length)
//			{
//				LOG.debug("Huamn connex[0]:", connex[0]);
//				//					trace(connex[0][0].length,(cBoard.getRow(0).length-1),BoardConfig.numConnex);
//				if ( (connex[0][0].length == BoardConfig.numConnex) && ((cBoard.getRow(6).length-1) == BoardConfig.numConnex))
//				{
//					//Human Win
//					GameConfig.gameStateManager.humanWin();
//				}
//			}
			//another simple rule functions here.
			if(chessPieceModel.reds.every(onTheTop))
			{
				//Human Win
				GameConfig.gameStateManager.humanWin();
			}
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		private function onTheTop(element:*, index:int, vector:Vector.<ChessPiece>):Boolean 
		{
			return 0== (element as ChessPiece).position.y;
		}
		private function onTheBottom(element:*, index:int, vector:Vector.<ChessPiece>):Boolean 
		{
			return (BoardConfig.yLines-1)==(element as ChessPiece).position.y;
		}

	}

}

