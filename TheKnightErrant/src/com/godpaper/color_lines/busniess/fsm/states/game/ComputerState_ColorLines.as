package com.godpaper.color_lines.busniess.fsm.states.game
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.adobe.cairngorm.task.SequenceTask;
	import com.godpaper.as3.business.fsm.states.game.ComputerState;
	import com.godpaper.as3.configs.GameConfig;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.tasks.CreateChessPieceTask;
	import com.godpaper.as3.tasks.CreateChessVoTask;
	import com.godpaper.as3.utils.MathUtil;
	import com.godpaper.as3.views.components.ChessPiece;
	import com.godpaper.color_lines.busniess.factory.ChessFacotryHelper_ColorLines;
	import com.godpaper.color_lines.busniess.factory.ChessFactory_ColorLines;
	import com.godpaper.color_lines.busniess.managers.ChessPiecesManager_ColorLines;
	import com.godpaper.as3.model.vos.ColorPositionVO;
	import com.lookbackon.AI.FSM.IAgent;
	import com.masterbaboon.AdvancedMath;
	
	import flash.geom.Point;
	
	/**
	 * ColorLinesComputerState.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created May 13, 2011 2:38:12 PM
	 */   	 
	public class ComputerState_ColorLines extends ComputerState
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		
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
		public function ComputerState_ColorLines(agent:IAgent, resource:Object, description:String=null)
		{
			//TODO: implement function
			super(agent, resource, description);
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		override public function update(time:Number=0):void
		{
			//None special algorithm searching here.
			var blue0:ChessPiece = chessPiecesModel.blues[0];
			var conductVO:ConductVO = new ConductVO();
			conductVO.target = blue0;
			conductVO.previousPosition = blue0.position;
			conductVO.nextPosition = blue0.position;
			GameConfig.chessPieceManager.applyMove(conductVO);
			//reset this number of pieces and colors.
			ChessFactory_ColorLines.dataProvider = ChessFacotryHelper_ColorLines.randomColorfulPieces();
			//mark indicators
			//FIXME: with invalid implmementation.
			var mark:String = "Next: ";
			for(var i:int=0;i<ChessFactory_ColorLines.dataProvider.length;i++)
			{
				mark = mark.concat(ChessFactory_ColorLines.dataProvider[i].color," , ");
			}
//			Application.application.nextColorsLabel.text = mark;
			//According to the color lines rule,just append 3 pieces on the board.
			var task:SequenceTask = new SequenceTask();
			var createChessPieceTask:CreateChessPieceTask = new  CreateChessPieceTask(ChessFactory_ColorLines);
			var createChessVoTask:CreateChessVoTask = new CreateChessVoTask(ChessFactory_ColorLines);
			task.addChild(createChessPieceTask);
			task.addChild(createChessVoTask);
			task.start();
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
