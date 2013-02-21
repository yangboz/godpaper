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
package the_chess_jam.src.com.godpaper.the_chess_jam.business.managers
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.business.managers.ChessPiecesManagerDefault;
	import com.godpaper.as3.configs.GameConfig;
	import com.godpaper.as3.configs.IndicatorConfig;
	import com.godpaper.as3.configs.PieceConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.core.FlexGlobals;
	import com.godpaper.as3.model.ChessGasketsModel;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.plugins.playerIO.PlayerIoPlugin;
	import com.godpaper.as3.utils.LogUtil;
	import com.godpaper.as3.views.components.ChessGasket;
	import com.godpaper.as3.views.components.ChessPiece;
	import chinese_chess_jam.src.com.godpaper.chinese_chess_jam.consts.PiecesConstants_ChineseChessJam;
	
	import flash.geom.Point;
	
	import mx.logging.ILogger;
	
	import playerio.Message;
	
	
	/**
	 * ChessPiecesManager_TheChessJam.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Sep 18, 2012 3:07:17 PM
	 */   	 
	public class ChessPiecesManager_TheChessJam extends ChessPiecesManagerDefault
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private const LOG:ILogger=LogUtil.getLogger(ChessPiecesManager_TheChessJam);
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		//playerIoPlugin.
		public function get playerIoPlugin():PlayerIoPlugin
		{
			//Refresh game room with tables.
			var playerIoPlugin:PlayerIoPlugin = (FlexGlobals.topLevelApplication.pluginProvider as PlayerIoPlugin);
			return playerIoPlugin;
		}
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
			//			if (cGasket.numChildren >= 1)
			if (cGasket.chessPiece)
			{
				//TODO:chess piece eat off.
				//				var removedPiece:ChessPiece=cGasket.getElementAt(0) as ChessPiece;
				//				var removedPiece:ChessPiece=cGasket.getChildAt(0) as ChessPiece;
				var removedPiece:ChessPiece = cGasket.chessPiece as ChessPiece;
				LOG.info("Eat Off@{0} target:{1}", cGasket.position.toString(), removedPiece.toString());
				//
				currentRemovedPieces.push(removedPiece);
				//Checkmate condition
				//				if (ChessPiece(cGasket.getElementAt(0)).label == PiecesConstants_ChineseChessJam.BLUE_MARSHAL.label)
				//				if (ChessPiece(cGasket.getChildAt(0)).label == PiecesConstants_ChineseChessJam.BLUE_MARSHAL.label)	
				if (removedPiece.label == PiecesConstants_ChineseChessJam.BLUE_MARSHAL.label)	
				{
					//conduct service transform
					if(GameConfig.playMode==GameConfig.HUMAN_VS_HUMAN)
					{
						if(FlexGlobals.userModel.moves.indexOf(conductVO.brevity)==-1)//Default index 0
						{
							//Default flag RED,Notice: the flag already has turnned
							FlexGlobals.conductService.transforBrevity("win",null);
						}
					}
					return GameConfig.gameStateManager.humanWin();
				}
				//				if (ChessPiece(cGasket.getElementAt(0)).label == PiecesConstants_ChineseChessJam.RED_MARSHAL.label)
				//				if (ChessPiece(cGasket.getChildAt(0)).label == PiecesConstants_ChineseChessJam.RED_MARSHAL.label)
				if (removedPiece.label == PiecesConstants_ChineseChessJam.RED_MARSHAL.label)	
				{
					//conduct service transform
					if(GameConfig.playMode==GameConfig.HUMAN_VS_HUMAN)
					{
						if(FlexGlobals.userModel.moves.indexOf(conductVO.brevity)==-1)//Default index 0
						{
							//Default flag RED,Notice: the flag already has turnned
							FlexGlobals.conductService.transforBrevity("win",null);
						}
					}
					return GameConfig.gameStateManager.computerWin();
				}
			}
			//
			super.applyMove(conductVO);
		}
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function ChessPiecesManager_TheChessJam()
		{
			super();
			//Signal listen
			if(this.playerIoPlugin)
			{
				//Notice:the signal difference between addOnce() and add() 
				this.playerIoPlugin.signal_piece_placed.add(onChessPiecePlaced);
				//
				this.playerIoPlugin.signal_player_win.add(onPlayerWin);
				this.playerIoPlugin.signal_game_tie.add(onGameTie);
				this.playerIoPlugin.signal_game_reset.add(onGameReset);
			}
		}   
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		//
		private function onChessPiecePlaced(m:Message, x:int, y:int, state:String, turn:int):void
		{
			LOG.info("Player: State {0},Moved to {1},{2},Turn to {3}", state,x,y,turn);
			//place the piece comes from other player's action broadcasting.
			var startX:int = int(String(x).charAt(0));
			var startY:int = int(String(x).charAt(1));
			var endX:int = int(String(y).charAt(0));
			var endY:int = int(String(y).charAt(1));
			var conductVO:ConductVO = new ConductVO();
			conductVO.nextPosition = new Point(endX,endY);
			//
			if(FlexGlobals.userModel.hosterRoleIndex != turn)
				//				if(state=="circle")//"cross","circle"
			{
				//Find red chess piece by gasket position.
				var target:ChessPiece = (FlexGlobals.chessGasketsModel.gaskets.gett(startX,startY) as ChessGasket).chessPiece as ChessPiece;
				conductVO.target = target;
				//Save stage to user model.
				FlexGlobals.userModel.state = state;
				FlexGlobals.userModel.moves.push(conductVO.brevity);
				//Make chess piece move.
				this.applyMove(conductVO);
				//The opponent player can move piece again.
				IndicatorConfig.waiting = false;
			}else
			{
				IndicatorConfig.waiting = true;//Waiting for the player can move piece again.
			}
		}
		//
		private function onGameTie():void
		{
			LOG.info("Game tie!");
		}
		//
		private function onGameReset():void
		{
			LOG.info("Game reset!");
		}
		//
		private function onPlayerWin(m:Message, winner:int, winnerName:String):void
		{
			LOG.info("Winner is: {0},{1}", winner,winnerName);
		}
	}
	
}