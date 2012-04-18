package com.lookbackon.AI.searching
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.configs.GameConfig;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.model.vos.PositionVO;
	
	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;

	/**
	 * About ShortSightedAI(鼠目寸光)</br>
	 * Cannot see beyond one's nose; </br>
	 * This essay is a detailed explanation of one of the most important
	 * data structures ever created for Game Artificial Intelligence. </br>
	 * The minimax tree is at the heart of almost every board game program in existence.</br>
	 *
	 * @author Knight.zhou
	 */	
	public class ShortSighted extends SearchingBase
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:Logger = LogContext.getLogger(ShortSighted);
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
		/**
		 * ShortSightedAI(鼠目寸光)
		 * 优先选择当前一步最佳着法
		 * @param gamePosition
		 * @inheritDoc
		 */		
		public function ShortSighted(gamePosition:PositionVO) 
		{
			super(gamePosition);
		}	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		override public function run():void
		{
			//Why named it "ShortSightedAI"？ 
			//cuz this gameAI just only scan the next step and then judgement it.
			//Maybe it is the right choice for the current game status. 
			//
			if(orderingMoves.length<=0)
			{
				//pluge to death.
				GameConfig.gameStateManager.humanWin();
			}else
			{
				var pValue:int=-1;
				bestMove = tempMove;//set default bestMove.
				for(var i:int=0;i<orderingMoves.length;i++)
				{
					positionEvaluated = doEvaluation(orderingMoves[i],gamePosition);
					if(positionEvaluated>pValue)
					{
						bestMove = orderingMoves[i];
						pValue = positionEvaluated;
					}
				}
				LOG.debug("bestMove:{0}",bestMove.dump());
				LOG.debug("max position value:{0}",pValue);
				//
				this.processDone = true;
			}
		}
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}	

}


