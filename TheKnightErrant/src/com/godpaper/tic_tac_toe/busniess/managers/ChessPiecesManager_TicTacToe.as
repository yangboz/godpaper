package com.godpaper.tic_tac_toe.busniess.managers
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.business.managers.ChessPiecesManagerDefault;
	import com.godpaper.as3.business.managers.GameStateManagerDefault;
	import com.godpaper.as3.configs.BoardConfig;
	import com.godpaper.as3.configs.GameConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.core.FlexGlobals;
	import com.godpaper.as3.model.ChessBoardModel;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.utils.LogUtil;
	import com.godpaper.as3.views.components.ChessPiece;
	import com.lookbackon.ds.NumberBoard;
	
	import de.polygonal.ds.Array2;
	
	import mx.logging.ILogger;


	/**
	 * ChessPiecesManager_TicTacToe.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Feb 25, 2011 12:38:06 PM
	 */   	 
	public class ChessPiecesManager_TicTacToe extends ChessPiecesManagerDefault
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
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
			var cBoard:Array2=chessBoardModel.status.board;
			//				var connex:Array=mnm.getConnex(cBoard, NUM_CONNECTION);
			var connex:Array=chessBoardModel.numerical.getConnex(cBoard,BoardConfig.numConnex,patternFunc_BBB);
			LOG.debug("blueSideHandler,current board connex:{0}", connex);
			//connex check
			this.checkConnex(connex,DefaultConstants.FLAG_BLUE);
		}
		override protected function redSideHandler():void
		{
			var cBoard:Array2=chessBoardModel.status.board;
			//				var connex:Array=mnm.getConnex(cBoard, NUM_CONNECTION);
			var connex:Array=chessBoardModel.numerical.getConnex(cBoard,BoardConfig.numConnex,patternFunc_RRR);
			LOG.debug("redSideHandler,current board connex:{0}", connex);
			//connex check
			this.checkConnex(connex,DefaultConstants.FLAG_RED);
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
		//
		private function sameRedFlag(element:*, index:int, arr:Array):Boolean
		{
			return (ChessPiece(element).label.indexOf("+")!=-1);
		}
		//
		private function sameBlueFlag(element:*, index:int, arr:Array):Boolean
		{
			return (ChessPiece(element).label.indexOf("-")!=-1);
		}
		//
		private function patternFunc_RRR(values:Array):Array
		{
			var result:Array = [];
			//
			if(values[0].every(sameRedFlag))
			{
				trace("patternFunc_RRR:",values);
				result = values;
			}
			return result;
		}
		//
		private function patternFunc_BBB(values:Array):Array
		{
			var result:Array = [];
			//
			if(values[0].every(sameBlueFlag))
			{
				trace("patternFunc_BBB:",values);
				result = values;
			}
			return result;
		}
		//
		private function checkConnex(connex:Array,flag:uint):void
		{
			//horizontally.
			if(connex[0].length)
			{
				LOG.debug("Computer connex[0]:{0}", connex[0]);
				//					trace(connex[0][0].length,(cBoard.getRow(BoardConfig.yLines).length-1),BoardConfig.numConnex);
				//				if ( (connex[0][0].length == BoardConfig.numConnex) &&  ((cBoard.getRow(BoardConfig.yLines).length-1) == BoardConfig.numConnex) )
				if ( (connex[0][0].length == BoardConfig.numConnex) )	
				{
					//Who Win?
					if(flag== DefaultConstants.FLAG_BLUE)
					{
						GameConfig.gameStateManager.computerWin();
					}
					if(flag==DefaultConstants.FLAG_RED)
					{
						GameConfig.gameStateManager.humanWin();
					}
				}
			}
			//vertically.
			if(connex[1].length)
			{
				LOG.debug("Computer connex[0]:{0}", connex[0]);
				//					trace(connex[0][0].length,(cBoard.getRow(BoardConfig.yLines).length-1),BoardConfig.numConnex);
				//				if ( (connex[0][0].length == BoardConfig.numConnex) &&  ((cBoard.getRow(BoardConfig.yLines).length-1) == BoardConfig.numConnex) )
				if ( (connex[1][0].length == BoardConfig.numConnex) )	
				{
					//Who Win?
					if(flag== DefaultConstants.FLAG_BLUE)
					{
						GameConfig.gameStateManager.computerWin();
					}
					if(flag==DefaultConstants.FLAG_RED)
					{
						GameConfig.gameStateManager.humanWin();
					}
				}
			}
			//forwardDiagonally.
			if(connex[2].length)
			{
				LOG.debug("Computer connex[0]:{0}", connex[0]);
				//					trace(connex[0][0].length,(cBoard.getRow(BoardConfig.yLines).length-1),BoardConfig.numConnex);
				//				if ( (connex[0][0].length == BoardConfig.numConnex) &&  ((cBoard.getRow(BoardConfig.yLines).length-1) == BoardConfig.numConnex) )
				if ( (connex[2][0].length == BoardConfig.numConnex) )	
				{
					//Who Win?
					if(flag== DefaultConstants.FLAG_BLUE)
					{
						GameConfig.gameStateManager.computerWin();
					}
					if(flag==DefaultConstants.FLAG_RED)
					{
						GameConfig.gameStateManager.humanWin();
					}
				}
			}
			//backwardDiagonally.
			if(connex[3].length)
			{
				LOG.debug("Computer connex[0]:{0}", connex[0]);
				//					trace(connex[0][0].length,(cBoard.getRow(BoardConfig.yLines).length-1),BoardConfig.numConnex);
				//				if ( (connex[0][0].length == BoardConfig.numConnex) &&  ((cBoard.getRow(BoardConfig.yLines).length-1) == BoardConfig.numConnex) )
				if ( (connex[3][0].length == BoardConfig.numConnex) )	
				{
					//Who Win?
					if(flag== DefaultConstants.FLAG_BLUE)
					{
						GameConfig.gameStateManager.computerWin();
					}
					if(flag==DefaultConstants.FLAG_RED)
					{
						GameConfig.gameStateManager.humanWin();
					}
				}
			}
		}
	}

}

