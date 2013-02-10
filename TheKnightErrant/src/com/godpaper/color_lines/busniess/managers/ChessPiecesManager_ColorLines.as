package com.godpaper.color_lines.busniess.managers
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
	import com.godpaper.as3.core.IChessGasket;
	import com.godpaper.as3.core.IChessPiece;
	import com.godpaper.as3.core.IChessVO;
	import com.godpaper.as3.model.ChessBoardModel;
	import com.godpaper.as3.model.ChessGasketsModel;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.utils.LogUtil;
	import com.godpaper.as3.views.components.ChessGasket;
	import com.godpaper.as3.views.components.ChessPiece;
	import com.lookbackon.ds.AStarNodeBoard;
	import com.lookbackon.ds.BitBoard;
	import com.lookbackon.ds.NumberBoard;
	import com.lookbackon.ds.aStar.AStar;
	import com.lookbackon.ds.aStar.AStarNode;
	
	import de.polygonal.ds.Array2;
	
	import flash.events.Event;
	
	import mx.logging.ILogger;
	
	import org.generalrelativity.thread.GreenThread;
	import org.generalrelativity.thread.IRunnable;

	/**
	 * ColorLinesChessPiecesManager.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Feb 25, 2011 12:38:06 PM
	 */
	public class ChessPiecesManager_ColorLines extends ChessPiecesManagerDefault
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//
		private var processes:Vector.<IRunnable>;
		private var greenThread:GreenThread;
		//
		private var aStar:AStar=new AStar();
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger=LogUtil.getLogger(ChessPiecesManager_ColorLines);

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
		public function ChessPiecesManager_ColorLines()
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
			//clean up firstly.
			super.currentRemovedPieces.length=0;
			//super call here.
			super.applyMove(conductVO);
		}

		/**
		 * @inheritDoc
		 */
		override public function doMoveValidation(conductVO:ConductVO):Boolean
		{
			var chessVO:IChessVO=conductVO.target.chessVO;
			var preMoves:BitBoard=chessVO.occupies.xor(chessVO.occupies.and(chessPiecesModel.allPieces));
			trace("preMoves:", preMoves.dump());
			var astarMoves:AStarNodeBoard=preMoves.not() as AStarNodeBoard;
			trace("astarMoves:", astarMoves.toString());
			var column:int=conductVO.nextPosition.x;
			var row:int=conductVO.nextPosition.y;
			//setStartNode for aStar searching
			astarMoves.setStartNode(conductVO.previousPosition.x, conductVO.previousPosition.y);
			//for start
			astarMoves.setWalkable(conductVO.previousPosition.x, conductVO.previousPosition.y, true);
			//
			if (!chessPiecesModel.allPieces.getBitt(row, column)) //avoid obstacle/fraise
			{
				astarMoves.setEndNode(column, row);
			}
			if (astarMoves.endNode)
			{
				trace("startNode:", astarMoves.startNode.toString());
				trace("endNode:", astarMoves.endNode.toString());
				aStar.grid=astarMoves;
				aStar.heuristic=aStar.diagonal;
//				aStar.heuristic=aStar.euclidian;
//				aStar.heuristic = aStar.manhattan;
				//using this flash green thread algorithm to avoid script time limition only 15s.
//				processes=new Vector.<IRunnable>();
//				processes.push(aStar);
				aStar.run();
				if (aStar.path)
				{
					for (var p:int=0; p < aStar.path.length; p++)
					{
						trace("found path#", p, ":(", aStar.path[p].x, ",", aStar.path[p].y, ")");
					}
//					colorLines(aStar.path);
					return true;
//					chessVO.moves.setBitt(conductVO.nextPosition.y, conductVO.nextPosition.x, true);
				}
//						var frameRate:int = FlexGlobals.topLevelApplication.stage.frameRate;
//				var frameRate:int=24;
//				greenThread=new GreenThread(processes, frameRate);
					//
					//			greenThread.addEventListener(GreenThreadEvent.PROCESS_TIMEOUT, function(event:GreenThreadEvent):void
					//			{
					//				LOG.error(event.toString());
					//			});
					//			greenThread.addEventListener(GreenThread.CYCLE, function(event:Event):void
					//			{
					//				LOG.debug(event.toString());
					//			});
					//			greenThread.addEventListener(GreenThreadEvent.PROCESS_COMPLETE, function(event:GreenThreadEvent):void
					//			{
					//				LOG.info(event.toString());
					//			});
//						greenThread.addEventListener(Event.COMPLETE, function(event:Event):void
//						{
//							LOG.info(event.toString());
//						});
					//
//						greenThread.open();
			}
			//reset start flag
			astarMoves.setWalkable(column, row, false);
			//
			return false;
		}

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		/**
		 * Finds the next node on the path and eases to it.
		 */
		protected function colorLines(path:Array):void
		{
			for (var i:int=0; i < path.length; i++)
			{
				var nodeX:int=(path[i] as AStarNode).x;
				var nodeY:int=(path[i] as AStarNode).y;
				//
				var cGasket:ChessGasket=chessGaketsModel.gaskets.gett(nodeX, nodeY) as ChessGasket;
//				cGasket.filters=[new GlowFilter()];
			}
		}
		//
		override protected function redSideHandler():void
		{
			var cBoard:Array2=chessBoardModel.status.board;
			var connex:Array=chessBoardModel.numerical.getConnex(cBoard, BoardConfig.numConnex,null);
			LOG.debug("current board connex:{0}@blueSideHandler", connex);
			//horizontally.
			if (connex[0].length)
			{
				LOG.debug("Computer connex[0]:", connex[0]);
				if ((connex[0][0].length == BoardConfig.numConnex))
				{
					//Apply TwoHitOne rules here.

				}
			}
			//
			//Apply your chess game rule here.
			//rank,file,diagonal connection.
			//vertically.
			//			trace("mnm:",mnm.toString());
			//			trace("mnm horizontal labels:",mnm.horizontalLabels);
			//			trace("mnm vertical labels:",mnm.verticalLabels);
			//			trace("mnm forward daigonal labels:",mnm.forwardDiagonalLabels);
			//			trace("mnm backward daigonal labels:",mnm.backwardDiagonalLabels);
			//			trace("mnm num of win places:",mnm.numOfWinPlaces);
			//side flag indentify
			//vertically.
			if (connex[1].length)
			{
				trace("connex[1]", connex[1]);
					//if the same color label?
					//TODO
					//					for (var v:int=0; v < connex[1].length; v++)
					//					{
					//						if ((connex[1][v] as Array).every(isSameColor))
					//						{
					//							trace("vertical unique group:", connex[1][v]);
					//							for (var vv:int=0; vv < connex[1][v].length; vv++)
					//							{
					//								if (-1 == super.currentRemovedPieces.indexOf(connex[1][v][vv]))
					//								{
					//									trace("before:", ChessPiecesModel.getInstance().pieces);
					//									trace("before:", ChessPiecesModel.getInstance().allPieces.dump());
					//									super.currentRemovedPieces.push(connex[1][v][vv]);
					//									//
					//									trace("currentRemovedPieces:", connex[1][v][vv]);
					//									trace("after:", ChessPiecesModel.getInstance().pieces);
					//									trace("after:", ChessPiecesModel.getInstance().allPieces.dump());
					//								}
					//							}
					//						}
					//					}
			}
			//diagonally.
			//forward.
			if (connex[2].length)
			{
				trace("connex[2]", connex[2]);
					//				super.currentRemovedPieces.push(connex[2]);
			}
			//backward.
			if (connex[3].length)
			{
				trace("connex[3]", connex[3]);
					//				super.currentRemovedPieces.push(connex[3]);
			}
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		//Custom array filter funcs
		private function isNotNull(element:*, index:int, array:Array):Boolean
		{
			return (element != null);
		}

		//Array every callback functions
		private function isSameColor(element:*, index:int, arr:Array):Boolean
		{
			var cp:ChessPiece=element as ChessPiece;
			if (index < arr.length - 1)
			{
//				return (cp.swfLoader.source == (arr[index + 1] as ChessPiece).swfLoader.source);
			}
			return true;
		}

		//
		private function isSameGroup(element:*, index:int, arr:Array):Boolean
		{
			var group:Array=element as Array;
			if (index < arr.length - 1)
			{
				return (group[0] == (arr[index + 1] as Array)[0]);
			}
			return true;
		}
	}

}

