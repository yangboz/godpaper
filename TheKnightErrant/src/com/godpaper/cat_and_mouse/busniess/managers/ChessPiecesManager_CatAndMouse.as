package com.godpaper.cat_and_mouse.busniess.managers
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.business.managers.ChessPieceManagerDefault;
	import com.godpaper.as3.configs.BoardConfig;
	import com.godpaper.as3.configs.GameConfig;
	import com.godpaper.as3.model.ChessBoardModel;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.core.FlexGlobals;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.utils.LogUtil;
	import com.godpaper.as3.views.components.ChessPiece;
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
	public class ChessPiecesManager_CatAndMouse extends ChessPieceManagerDefault
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
		private static const LOG:ILogger = LogUtil.getLogger(ChessPiecesManager_CatAndMouse);
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
		public function ChessPiecesManager_CatAndMouse()
		{
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
			//@see the game rule of "Cat And Mouse",over step number of 10,the mouse win.
			if(chessBoardModel.stepNumber>=10)
			{
				GameConfig.gameStateManager.computerWin();
			}
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------

	}

}

