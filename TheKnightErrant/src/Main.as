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
package
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	/**
	 * Main.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.0+
	 * Created Apr 12, 2012 9:38:56 AM
	 */   	 
	public class Main extends Sprite
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
		public function Main()
		{
			super();
			//
			this.addEventListener(Event.ADDED_TO_STAGE,addToStageHandler);
		}     	
		private function addToStageHandler(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,addToStageHandler);
			//
			preinitializeHandler();
			initializeHandler();
			creationCompleteHandler();
			applicationCompleteHandler();
		}
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		/**
		 * Foot sprint dump,optional for logging the end of turn messages.
		 */		
		public function dumpFootSprint():void
		{
			
		}
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		//		application1_preinitializeHandler
		/**
		 * All kinds of view components initialization here.
		 *
		 * @param event
		 *
		 */		
		protected function preinitializeHandler(event:FlexEvent):void
		{
			//config initialization here.
			//				BoardConfig.xLines = 9;
			//				BoardConfig.yLines = 10;
			//				BoardConfig.xOffset = 50;
			//				BoardConfig.yOffset = 50;
		}
		//application1_initializeHandler
		/**
		 * Game initialization here.
		 *
		 * @param event
		 *
		 */		
		protected function initializeHandler(event:FlexEvent):void
		{
			//number of tollgate tips would be matched with tollgates!
			//				GameConfig.tollgates = [RandomWalk,ShortSighted,AttackFalse,AttackFalse,MiniMax];
			//				GameConfig.tollgateTips = ["baby intelligence","fellow intelligence","man intelligence","guru intelligence"];
			//				GameConfig.turnFlag = CcjConstants.FLAG_RED;
		}
		//  application1_creationCompleteHandler
		/**
		 * View(chess pieces/gaskets) components initialization here.
		 *
		 * @param event
		 *
		 */		
		protected function creationCompleteHandler(event:FlexEvent):void
		{
			//			//create chess gaskets.
			//			//create chess piece
			//			//create chess pieces' chessVO;
			//			//create chess pieces' omenVO;
			//			this.startUpSequenceTask.start();
			//			//init data struct.@see ChessPieceModel dump info.
			//			this.dumpFootSprint();
			//Add version control context menu.
			VersionController.getInstance(this);
		}
		//  application1_applicationCompleteHandler
		/**
		 * Game application start up here.
		 *
		 * @param event
		 *
		 */		
		protected function applicationCompleteHandler(event:FlexEvent):void
		{
			//GameManager start.
			GameConfig.gameStateManager.start();
			//
			LOG.info("redPieces:{0}", ChessPiecesModel.getInstance().redPieces.dump());
			LOG.info("bluePieces:{0}", ChessPiecesModel.getInstance().bluePieces.dump());
			LOG.info("allPieces:{0}", ChessPiecesModel.getInstance().allPieces.dump());
			//
			LOG.info("allPieces rotate90:{0}", ChessPiecesModel.getInstance().allPieces.rotate90().dump());
			LOG.info("allPieces rotate90.bitCount:{0}", ChessPiecesModel.getInstance().allPieces.bitCount);
			LOG.info("allPieces rotate90.cellCount:{0}", ChessPiecesModel.getInstance().allPieces.cellCount);
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}
	
}