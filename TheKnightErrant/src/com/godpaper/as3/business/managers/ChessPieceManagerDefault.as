package com.godpaper.as3.business.managers
{
	import com.adobe.cairngorm.task.ParallelTask;
	import com.adobe.cairngorm.task.TaskEvent;
	import com.godpaper.as3.configs.BoardConfig;
	import com.godpaper.as3.configs.GameConfig;
	import com.godpaper.as3.configs.IndicatorConfig;
	import com.godpaper.as3.configs.PieceConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.core.IChessPiece;
	import com.godpaper.as3.core.IChessPieceManager;
	import com.godpaper.as3.errors.DefaultErrors;
	import com.godpaper.as3.model.ChessGasketsModel;
	import com.godpaper.as3.model.ChessPiecesMemento;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.model.vos.PositionVO;
	import com.godpaper.as3.model.vos.ZobristKeyVO;
	import com.godpaper.as3.tasks.UpdateChessPiecesTask;
	import com.godpaper.as3.tasks.UpdatePiecesBitboardTask;
	import com.godpaper.as3.tasks.UpdatePiecesChessVoTask;
	import com.godpaper.as3.tasks.UpdatePiecesOmenVoTask;
	import com.godpaper.as3.tasks.UpdatePiecesPositionTask;
	import com.godpaper.as3.tasks.UpdateZobristKeysTask;
	import com.godpaper.as3.utils.LogUtil;
	import com.godpaper.starling.views.components.ChessGasket;
	import com.godpaper.starling.views.components.ChessPiece;
	import com.lookbackon.ds.BitBoard;
	
	import de.polygonal.math.PM_PRNG;
	
	import mx.logging.ILogger;

	/**
	 * The default chess piece manager, manage chess piece move's validation/makeMove/unMakeMove.</br>
	 * Also a way for the originator to be responsible for saving and restoring its states.</br>
	 * @author Knight.zhou
	 * @history 2010-12-02 using memento design pattern to implment make/unmake functions.
	 * @history 2011-07-20 add default the side handlers at make move function.
	 */
	public class ChessPieceManagerDefault implements IChessPieceManager
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var pmPRNG:PM_PRNG=new PM_PRNG();
		//But the real trick is if we do the XOR operation again we get the initial number back.
		//a ^ b = c
		//c ^ b = a
//		private  var _crossOverValue:int;//and we using _crossOverValue for store the value "b";
		private var _zKey:ZobristKeyVO; //current chess piece's zobrist key value object.
		//
		private var chessPiecesModel:ChessPiecesModel=ChessPiecesModel.getInstance();
		//
		private var _eatOffs:Vector.<ChessPiece>=new Vector.<ChessPiece>();
		//
//		private  var _memento:ChessPiecesMemento;
		private var _conduct:ConductVO;
		//
		private var _previousMementos:Array=[];
		private var _nextMementos:Array=[];
		//flag is checked.
//		[Bindable]
		private var _isChecking:Boolean=false;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private const LOG:ILogger=LogUtil.getLogger(ChessPieceManagerDefault);

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  memento
		//----------------------------------
		/**
		 *
		 * @return
		 */
		public function get memento():ChessPiecesMemento
		{
			return new ChessPiecesMemento(_conduct);
		}

		/**
		 *
		 * @param value
		 */
		public function set memento(value:ChessPiecesMemento):void
		{
			_conduct=value.conduct;
			//trigger man of update tasks.
			updateTasksProcess();
		}

		//----------------------------------
		//  previousMementos
		//----------------------------------
		/**
		 * @return chess pieces' move history.
		 */
		public function get previousMementos():Array
		{
			return _previousMementos;
		}

		//----------------------------------
		//  eatOffs
		//----------------------------------
		/**
		 * return the eaten chess pieces.
		 */
		public function get eatOffs():Vector.<ChessPiece>
		{
			return _eatOffs;
		}

		/**
		 * @param value the eated off pieces.
		 */
		public function set eatOffs(value:Vector.<ChessPiece>):void
		{
			_eatOffs=value;
		}

		//----------------------------------
		//  isChecking
		//----------------------------------
		//
		public function set isChecking(value:Boolean):void
		{
			_isChecking=value;
		}

		/**
		 * return isChecking value.
		 */
		public function get isChecking():Boolean
		{
			return _isChecking;
		}

		//generation.
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		/**
		 *
		 * @param conductVO the conduct value object of moving chess piece.
		 * @return current chess piece's move validation result.
		 *
		 */
		public function doMoveValidation(conductVO:ConductVO):Boolean
		{
			var result:Boolean=true;
			//begin:
//			var beginTime:uint = new Date().getMilliseconds();
//			LOG.info("move validate begin at:{0}",beginTime);
			//chess piece change state(view).
//			conductVO.target.agent.getFSM().changeState(conductVO.target.attackState);
			//TODO:chess piece move (logic) check.
			//
			result=Boolean(conductVO.target.chessVO.moves.getBitt(conductVO.nextPosition.y, conductVO.nextPosition.x));
//			LOG.info("doMoveValidation result:{0}",result);
			//end
//			var endTime:uint = new Date().getMilliseconds();
//			LOG.info("move validate end at:{0}||duration:{1}",endTime,endTime-beginTime);
			return result;
		}

		/**
		 * <b>Make Move</b> is a function inside a chess program to update the internal chess position
		 * and its Board representation as well as associated </br>
		 * or dependent state variables and data by a move made on the internal board,
		 * such as zobrist keys to index the transposition table. </br>
		 * That usually happens inside the Search algorithm, </br>
		 * where the move acts like an edge connecting two nodes of a search tree,
		 * a parent and a child node. </br>
		 * Dependent on the design of the data structures
		 * and the used search algorithms there are different approaches
		 * with respect to randomly accessing aspects of nodes
		 * and restoring the position while unmaking the move.
		 *
		 * @see http://chessprogramming.wikispaces.com/Make+Move
		 * @param conductVO the conduct value object of moving chess piece.
		 *
		 */
		public function makeMove(conductVO:ConductVO):void
		{
			LOG.info("Begin makeMove:{0}", conductVO.brevity);
			//update conduct
			_conduct=conductVO;
			_conduct.crossValue=pmPRNG.nextInt();
			LOG.debug("crossOverValue:{0}", conductVO.crossValue.toString());
			//update mememto
			var memento:ChessPiecesMemento=new ChessPiecesMemento(conductVO);
			_nextMementos=[];
			_previousMementos.push(memento);
			GameConfig.chessPieceManager.memento=memento;
			//
			LOG.info("End makeMove:{0}", conductVO.brevity);
			//clean up firstly.
			currentRemovedPieces.length = 0;
			//relatived side handlers.
			if(GameConfig.gameStateManager.isBlueSide)
			{
				this.blueSideHandler();
			}
			if(GameConfig.gameStateManager.isRedSide)
			{
				this.redSideHandler();	
			}
			if(GameConfig.gameStateManager.isGreenSide)
			{
				this.greenSideHandler();	
			}
		}

		/**
		 *
		 * <b>Unmake Move</b> is a function inside a chess program to update the internal chess position
		 * and its Board representation as well as associated or dependent state variables
		 * and data by a move unmade on the internal board. </br>
		 * In unmake move, reversible aspects of a position can be incrementally updated by the inverse
		 * or own inverse operation of Make Move. </br>
		 * Irreversible aspects of a position, such as ep state,
		 * castling rights and the halfmove clock are either restored from a stack (LIFO), </br>
		 * or simply kept in arrays indexed by current search or game ply. </br>
		 * Alternatively, one may capacitate the move with all the necessary information
		 * to recover those irreversible aspects of a position as well.
		 *
		 * @see http://chessprogramming.wikispaces.com/Unmake+Move
		 *
		 * @param conductVO the conduct value object of moving chess piece.
		 *
		 */
		public function unmakeMove(conductVO:ConductVO):void
		{
			var reversedConductVO:ConductVO=conductVO.reverse();
			LOG.info("Begin unmakeMove:{0}", reversedConductVO.brevity);
			//reverse conductVO to unmakeMove.
			var eattenPiece:IChessPiece;
			if (null != conductVO.eatOff)
			{
				//thrown out the eatten piece;
				eattenPiece=eatOffs.pop() as IChessPiece;
				//roll back the eatting piece;
				var cGasket:ChessGasket=ChessGasketsModel.getInstance().gaskets.gett(eattenPiece.position.x, eattenPiece.position.y);
//				cGasket.addElement(eattenPiece);
				cGasket.chessPiece=eattenPiece;
			}
			//TODO:un-update functions.
			//roll back bitboard
			if (null != eattenPiece)
			{
				BitBoard(chessPiecesModel[eattenPiece.type]).setBitt(cGasket.position.y, cGasket.position.x, true);
			}
			//
			LOG.debug(chessPiecesModel.allPieces.dump());
			//roll back pieces data.
			if (GameConfig.turnFlag == DefaultConstants.FLAG_RED)
			{
				chessPiecesModel.blues.push(eattenPiece);
			}
			else
			{
				chessPiecesModel.reds.push(eattenPiece);
			}
			//update mememto(unmake)
			var mememto:ChessPiecesMemento;
			if (_previousMementos.length > 0)
			{
				mememto=_previousMementos.pop();
				mememto.conduct=mememto.conduct.reverse();
				_nextMementos.push(mememto);
				this.memento=mememto;
			}
			//
			LOG.info("End unmakeMove:{0}", reversedConductVO.brevity);
			//update mememto(remake)
//			if(_nextMementos.length > 0) {
//				memento = _nextMementos.pop();
//				_previousMementos.push(memento);
//				ChessPieceManager.memento = mememto;
//			}
		}
		//Add this variable to simplify store current be removed piece with index.
		//Notice:before using this variable,should clean up it.
		protected var currentRemovedPieces:Vector.<ChessPiece> = new Vector.<ChessPiece>();
		//
		protected function get currentRemovedPieceIndexs():Vector.<int>
		{
			var _currentRemovedPieceIndexs:Vector.<int> = new Vector.<int>();
			for each( var piece:ChessPiece in currentRemovedPieces)
			{
				_currentRemovedPieceIndexs.push(this.calculatePieceIndex(piece));
			}
			return _currentRemovedPieceIndexs;
		}
		/**
		 * Apply make move data and piece entity change behaviors,to be overrided.
		 * @param conductVO
		 */
		public function applyMove(conductVO:ConductVO):void
		{
			//TODO:with roll back function support.
			//TODO:implement currentRemovedPieces,currentRemovedPieceIndexs.

			//clean bits at current removed pieces.
			for each( var piece:ChessPiece in currentRemovedPieces)
			{
				BitBoard(ChessPiecesModel.getInstance()[piece.type]).setBitt(piece.position.y, piece.position.x, false);
			}	
			//clean this bit at pieces.
			for each( var index:int in currentRemovedPieceIndexs)
			{
				//remove pieces data.
				if (GameConfig.turnFlag == DefaultConstants.FLAG_RED)
				{
					//clean this bit at bluePieces.
					//notice array splice without copy
//					chessPiecesModel.blues = 
					chessPiecesModel.blues.splice(index, 1);
				}
				else
				{
					//clean this bit at redPieces.
					//notice array splice without copy
//					chessPiecesModel.reds = 
					chessPiecesModel.reds.splice(index, 1);
				}
			}
			//remove element from gasket.
			for each( var piecee:ChessPiece in currentRemovedPieces)
			{
				var cGasket:ChessGasket=ChessGasketsModel.getInstance().gaskets.gett(piecee.position.x,piecee.position.y) as ChessGasket;
				//cGasket.removeElementAt(0);
				cGasket.chessPiece=null;
			}
			//finally trigger make move.
			this.makeMove(conductVO);
		}

		//pluge to death.	
		/**
		 * Plugin to death,results to human or computer win.</br>
		 * return the game status code.
		 */
		public function noneMove():int
		{
			if (GameConfig.turnFlag == DefaultConstants.FLAG_BLUE)
			{
				GameConfig.gameStateManager.humanWin();
			}
			else
			{
				GameConfig.gameStateManager.computerWin();
			}
			return -1;
		}

		/**
		 *
		 * @param gamePosition
		 * @return
		 */
		public function willNoneMove(gamePosition:PositionVO):Boolean
		{
			//TODO:check handler function implementation.
			return false;
		}

		//notice:why not using ArrayCollection.getItemIndex(object)?
		//cuz our chess piece's position property always change here.
		/**
		 *
		 * @param chessPiece
		 * @return
		 * @throws CcjErrors
		 */
		public function calculatePieceIndex(chessPiece:ChessPiece):int
		{
			for (var i:int=0; i < chessPiecesModel.reds.length; i++)
			{
				if (chessPiece.uid == ChessPiece(chessPiecesModel.reds[i]).uid)
				{
					return i;
				}
			}
			for (var j:int=0; j < chessPiecesModel.blues.length; j++)
			{
				if (chessPiece.uid == ChessPiece(chessPiecesModel.blues[j]).uid)
				{
					return j;
				}
			}
			throw new DefaultErrors(DefaultErrors.INVALID_CHESS_PIECE_INDEX);
			return -1;
		}

		/**
		 * @see Main.application1_creationCompleteHandler.createGasket().
		 * @param legalMoves current chess piece's legal moves.
		 *
		 */
		public function indicateGasketsMove(legalMoves:BitBoard):void
		{
			//@see Main.application1_creationCompleteHandler.createGasket().
			for (var v:int=0; v < BoardConfig.yLines; v++)
			{
				for (var h:int=0; h < BoardConfig.xLines; h++)
				{
					if (legalMoves.getBitt(v, h))
					{
						if(ChessGasketsModel.getInstance().gaskets.gett(h, v))
						{
//							(ChessGasketsModel.getInstance().gaskets.gett(h, v)as ChessGasket).setStyle("backgroundColor", 0xff0000);
						}
					}
					else
					{
						if(ChessGasketsModel.getInstance().gaskets.gett(h, v))
						{
//							(ChessGasketsModel.getInstance().gaskets.gett(h, v) as ChessGasket).clearStyle("backgroundColor");
//							(ChessGasketsModel.getInstance().gaskets.gett(h, v) as ChessGasket).filters=[];
						}
					}
				}
			}
		}
		
		/**
		 * @see Main.application1_creationCompleteHandler.createGasket().
		 * @param legalMoves current chess piece's legal moves.
		 *
		 */
		public function indicateGasketsCapture(legalCaptures:BitBoard):void
		{
			//@see Main.application1_creationCompleteHandler.createGasket().
			for (var v:int=0; v < BoardConfig.yLines; v++)
			{
				for (var h:int=0; h < BoardConfig.xLines; h++)
				{
					if (legalCaptures.getBitt(v, h))
					{
						if(ChessGasketsModel.getInstance().gaskets.gett(h, v))
						{
//							(ChessGasketsModel.getInstance().gaskets.gett(h, v) as ChessGasket).filters=[new GlowFilter()];
						}	
					}
				}
			}
		}

		/**
		 *
		 * @param pieces execute check mate's chess pieces.
		 * @param marshal blues'/reds' marshal bitboard.
		 * @return the result of check pattern,if neccessary.
		 *
		 */
		public function indicateCheck(pieces:Vector.<ChessPiece>, marshal:BitBoard):Boolean
		{
			//TODO:should check kill itself logic.
			var totalCaptures:BitBoard=new BitBoard(BoardConfig.xLines, BoardConfig.yLines);
			for (var i:int=0; i < pieces.length; i++)
			{
				totalCaptures=pieces[i].chessVO.captures.or(totalCaptures);
			}
			LOG.debug("totalCaptures:{0}", totalCaptures.dump());
			if (!totalCaptures.and(marshal).isEmpty)
			{
				IndicatorConfig.check=true;
				//update is checking flag.
				LOG.info("___isChecking___true");
				_isChecking=true;
				//
				return true;
			}
			//
			return false;
		}

		/**
		 *
		 * @param gamePosition the current blue/red game position.
		 * @return whether or not blue/red check mated.
		 *
		 */
		public function indicateCheckmate(gamePosition:PositionVO):Boolean
		{
			var checkmated:Boolean;
			if (gamePosition.color == DefaultConstants.FLAG_BLUE)
			{
				checkmated=ChessPiecesModel.getInstance().BLUE_MARSHAL.isEmpty;
			}
			else
			{
				checkmated=ChessPiecesModel.getInstance().RED_MARSHAL.isEmpty;
			}
			return checkmated;
		}

		//update-relatived tasks here.
		//FIXME:cairngorm3 task can not restart,but parsley can do it.
		protected function updateTasksProcess():void
		{
			var task:ParallelTask=new ParallelTask();
			//
			//update bitboard.
			//update allPieces.
			//update allPieces' chessVO.
			//update allPieces' omenVO.
			//update ZobristKeys
			//buffer here,after update all data,then refresh view.
			task.addChild(new UpdatePiecesBitboardTask(memento.conduct));
			task.addChild(new UpdatePiecesPositionTask(memento.conduct));
			task.addChild(new UpdateZobristKeysTask(memento.conduct));
			//
			task.addChild(new UpdatePiecesChessVoTask(PieceConfig.factory));
			//
			task.addChild(new UpdatePiecesOmenVoTask());
			//
			task.addChild(new UpdateChessPiecesTask(memento.conduct));
			//
			task.addEventListener(TaskEvent.TASK_COMPLETE, function(event:TaskEvent):void
			{
				//Trigger in-turn system .
				if (GameConfig.gameStateManager.isRunning)
				{
					if (GameConfig.turnFlag == DefaultConstants.FLAG_RED)
					{
						GameConfig.gameStateManager.isComputerTurnNow();
					}
					else
					{
						GameConfig.gameStateManager.isHumanTurnNow();
					}
				}
			});
			//
			task.start();
		}
		
		//
		virtual protected function blueSideHandler():void
		{
			//TODO:implement functions.
		}
		//
		virtual protected function redSideHandler():void
		{
			//TODO:implement functions.
		}
		//
		virtual protected function greenSideHandler():void
		{
			//TODO:implement functions.
		}
	}

}


