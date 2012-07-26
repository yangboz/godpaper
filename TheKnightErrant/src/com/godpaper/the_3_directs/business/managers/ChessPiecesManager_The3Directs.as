package com.godpaper.the_3_directs.business.managers
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.business.managers.ChessPiecesManagerDefault;
	import com.godpaper.as3.configs.GameConfig;
	import com.godpaper.as3.model.ChessGasketsModel;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.utils.LogUtil;
	import com.godpaper.as3.views.components.ChessGasket;
	
	import mx.logging.ILogger;
	
	
	/**
	 * T3dChessPieceManager.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Feb 25, 2011 12:38:06 PM
	 */   	 
	public class ChessPiecesManager_The3Directs extends ChessPiecesManagerDefault
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(ChessPiecesManager_The3Directs);
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
		public function ChessPiecesManager_The3Directs()
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
			//clean up firstly.
			super.currentRemovedPieces.length = 0;
			
			//Apply your chess game rule here.
			var targetGasket:ChessGasket = 
				chessGaketsModel.gaskets.gett(conductVO.nextPosition.x,conductVO.nextPosition.y) as ChessGasket;
			if(targetGasket)
			{
//				targetGasket.skin.alpha = 1;
//				if(GameConfig.gameStateManager.isBlueSide)
//				{
//					targetGasket.skin["solidColor"]["color"] = 0x0000FF;
//				}else
//				{
//					targetGasket.skin["solidColor"]["color"] = 0xFF0000;
//				}
			}else
			{
				LOG.fatal("targetGasket not found!!!");
			}
			//super call here.
			super.applyMove(conductVO);
		}
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		override protected function blueSideHandler():void
		{
			
		}
		
		override protected function redSideHandler():void
		{
			
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}
	
}
