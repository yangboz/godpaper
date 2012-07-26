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
package com.godpaper.two_hit_one.buiness.managers
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
	import com.godpaper.as3.model.ChessBoardModel;
	import com.godpaper.as3.model.ChessGasketsModel;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.core.FlexGlobals;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.model.vos.PositionVO;
	import com.godpaper.as3.utils.FilterUtil;
	import com.godpaper.as3.utils.LogUtil;
	import com.godpaper.as3.views.components.ChessGasket;
	import com.godpaper.as3.views.components.ChessPiece;
	import com.lookbackon.ds.BitBoard;
	
	import de.polygonal.ds.Array2;
	
	import flash.geom.Point;
	
	import mx.logging.ILogger;
	
	/**
	 * The chess piece manager(TwoHitOne) manage chess piece move's validation/makeMove/unMakeMove.</br>
	 * Also a way for the originator to be responsible for saving and restoring its states.</br>   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created May 14, 2012 2:06:30 PM
	 */   	 
	public class ChessPieceManager_TwoHitOne extends ChessPiecesManagerDefault
	{		
		//--------------------------------------------------------------------------
		//
		// Variables
		//
		//--------------------------------------------------------------------------
		private var chessPieceModel:ChessPiecesModel = FlexGlobals.chessPiecesModel;
		private var chessBoardModel:ChessBoardModel = FlexGlobals.chessBoardModel;
		//----------------------------------
		// CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(ChessPieceManager_TwoHitOne);
		//--------------------------------------------------------------------------
		//
		// Public properties
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		// Protected properties
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		public function ChessPieceManager_TwoHitOne()
		{
			super();
		}
		//--------------------------------------------------------------------------
		//
		// Public methods
		//
		//--------------------------------------------------------------------------
		/**
		 * @inheritDoc
		 * @see http://www.godpaper.com/godpaper/index.php/%E5%85%AD%E5%AD%90%E6%A3%8B
		 */
		override public function applyMove(conductVO:ConductVO):void
		{
			//TODO:simply this game rule by bitboard magic and algorithem.
			//clean up firstly.
			super.currentRemovedPieces.length = 0;
			//super call here.
			super.applyMove(conductVO);
		}
		//--------------------------------------------------------------------------
		//
		// Protected methods
		//
		//--------------------------------------------------------------------------
		//
		override protected function blueSideHandler():void
		{
			var cBoard:Array2=chessBoardModel.status.board;
			var connex:Array=chessBoardModel.numercal.getConnex(cBoard,BoardConfig.numConnex,blueMatchPattern);
			LOG.debug("current board connex:{0}@blueSideHandler", connex);
			//horizontally.
			if(connex[0].length)
			{
				LOG.debug("Computer connex[0]:", connex[0]);
				if ( (connex[0][0].length == BoardConfig.numConnex))
				{
					//Apply TwoHitOne rules here.
					
				}
			}
		}
		//
		override protected function redSideHandler():void
		{
			var cBoard:Array2=chessBoardModel.status.board;
			var connex:Array=chessBoardModel.numercal.getConnex(cBoard,BoardConfig.numConnex,redMatchPattern);
			LOG.debug("current board connex:{0}@redSideHandler", connex);
			//horizontally.
			if(connex[0].length)
			{
				LOG.debug("Huamn connex[0]:", connex[0]);
				// trace(connex[0][0].length,(cBoard.getRow(0).length-1),BoardConfig.numConnex);
				if ( (connex[0][0].length == BoardConfig.numConnex))
				{
					//Apply TwoHitOne rules here.
					
				}
			}
		}
		//--------------------------------------------------------------------------
		//
		// Private methods
		//
		//--------------------------------------------------------------------------
		//BBR,BRB
		//@see http://www.godpaper.com/godpaper/index.php/%E5%85%AD%E5%AD%90%E6%A3%8B#.E6.B8.B8.E6.88.8F.E8.A7.84.E5.88.99
		private function blueMatchPattern(data:Array):Array
		{
			var result:Array = [];
			for(var i:int=0;i<data.length;i++)
			{
				var sumOfFlags:Number = 0;
				for(var j:int=0;j<BoardConfig.numConnex;j++)
				{
					sumOfFlags += data[i][j].flag;
				}
				if(sumOfFlags==1)
				{
					LOG.debug(data[i]);
					result.push(data[i]);
				}
			}
			LOG.debug("blue sum of flags result:",result);
			//
			return result;
		}
		//RRB,RBR
		//@see http://www.godpaper.com/godpaper/index.php/%E5%85%AD%E5%AD%90%E6%A3%8B#.E6.B8.B8.E6.88.8F.E8.A7.84.E5.88.99
		private function redMatchPattern(data:Array):Array
		{
			var result:Array = [];
			for(var i:int=0;i<data.length;i++)
			{
				var sumOfFlags:Number = 0;
				for(var j:int=0;j<BoardConfig.numConnex;j++)
				{
					sumOfFlags += data[i][j].flag;
				}
				if(sumOfFlags==2)
				{
					LOG.debug(data[i]);
					result.push(data[i]);
				}
			}
			LOG.debug("red sum of flags result:",result);
			//
			return result;
		}
	}
	
}