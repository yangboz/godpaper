/**
 *  GODPAPER Confidential,Copyright 2012. All rights reserved.
 *
 *  Permission is hereby granted, free of charge, to any person obtaining
 *  a copy of this software and associated documentation files (the "Software"),
 *  to deal in the Software without restriction, including without limitation
 *  the rights to use, copy, modify, merge, publish, distribute, sub-license,
 *  and/or sell copies of the Software, and to permit persons to whom the
 *  Software is furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included
 *  in all copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 *  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 *  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
 *  IN THE SOFTWARE.
 */
package src.com.godpaper.barebone.business.fsm.states.game
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
	import src.com.godpaper.barebone.business.factory.YourChessFactory;
	import com.lookbackon.AI.FSM.IAgent;
	import com.masterbaboon.AdvancedMath;
	
	import flash.geom.Point;
	
	/**
	 * YourComputerState.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Oct 10, 2012 1:44:35 PM
	 */   	 
	public class YourComputerState extends ComputerState
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
		public function YourComputerState(agent:IAgent, resource:Object, description:String=null)
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
//			YourChessFactory.dataProvider = ChessFacotryHelper_ColorLines.randomColorfulPieces();
			//mark indicators
			//FIXME: with invalid implmementation.
			var mark:String = "Next: ";
			for(var i:int=0;i<YourChessFactory.dataProvider.length;i++)
			{
				mark = mark.concat(YourChessFactory.dataProvider[i].color," , ");
			}
			//			Application.application.nextColorsLabel.text = mark;
			//According to the color lines rule,just append 3 pieces on the board.
			var task:SequenceTask = new SequenceTask();
			var createChessPieceTask:CreateChessPieceTask = new  CreateChessPieceTask(YourChessFactory);
			var createChessVoTask:CreateChessVoTask = new CreateChessVoTask(YourChessFactory);
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