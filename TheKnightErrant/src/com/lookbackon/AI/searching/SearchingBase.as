package com.lookbackon.AI.searching
{
	import com.godpaper.as3.configs.GameConfig;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.core.FlexGlobals;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.model.vos.PositionVO;
	import com.godpaper.as3.utils.FilterUtil;
	import com.godpaper.as3.utils.SortUtil;
	import com.godpaper.as3.views.components.ChessPiece;
	import com.lookbackon.AI.evaluation.IEvaluation;
	import com.lookbackon.AI.evaluation.linear.LinearEvaluation;
	import com.lookbackon.ds.BitBoard;
	
	import flash.geom.Point;
	
	import org.generalrelativity.thread.process.AbstractProcess;

	/**
	* This essay is a detailed explanation of one of the most important
	* data structures ever created for Game Artificial Intelligence. </p>
	* The minimax tree is at the heart of almost every board game program in existence.</p>
	*
	* @author Knight.zhou
	*/
	public class SearchingBase extends AbstractProcess implements ISearching
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//param alpha the alpha value which hold the best MAX value found;
		// At MAX level, before evaluating each child path, 
		// compare the returned value with of the previous path with the beta value. 
		// If the value is greater than it abort the search for the current node;
		protected var alpha:int;
		//param beta the beta value which hold the best MIN value found;
		// At MIN level, before evaluating each child path, 
		// compare the returned value with of the previous path with the alpha value. 
		// If the value is lesser than it abort the search for the current node.
		protected var beta:int;
		//searching depth.
		protected var depth:int;
		//conductVO's collection;
		protected var tempMove:ConductVO;
		protected var tempCapture:ConductVO; //Notice:null capture move should handled.
		protected var bestMove:ConductVO;
		//
		protected var tempValue:int;
		protected var bestValue:int;
		//
		protected var positionEvaluated:int;
		//
		protected var gamePosition:PositionVO;
		//Default Evaluation functions.
		private var _evaluation:IEvaluation=new LinearEvaluation(); //Notice:this is all kinds of evaluation method entry,should be test.
		//
		private var _orderingMoves:Vector.<ConductVO>;
		//flag wheater this process done.
		private var _processDone:Boolean;
		//
		private var _moves:Vector.<ConductVO>;
		//Add this variables for save loops and time cost at the green thread run.
		private var _movesHasGenerated:Boolean = false;
		protected var generatedMoves:Vector.<ConductVO> = new Vector.<ConductVO>();
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		public const MAX_SEARCH_DEPTH:int=5;

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		/**
		 * To sum up this in one sentence: </p>
		 * Computers play strategy games by generating
		 * all possible continuations up to a (more or less) fixed depth
		 * and evaluating the resulting positions, </p>
		 * which allows them to choose the best of these continuations. </p>
		 *
		 */
		public function SearchingBase(gamePosition:PositionVO, isSelfManaging:Boolean=false)
		{
			//TODO: implement function
			this.gamePosition=gamePosition;
			//init ordering moves.
			this.orderingMoves=this.moves.sort(SortUtil.sortOnMoves).reverse();
			for (var m:int=0; m < this.moves.length; m++)
			{
//				trace("move's celled:",this.moves[m].target.chessVO.moves.celled);
			}
			for (var om:int=0; om < this.moves.length; om++)
			{
//				trace("orderingMove's celled:",this.orderingMoves[om].target.chessVO.moves.celled);
			}
			//pluge to death.
			if(this.orderingMoves.length<1)
			{
				//
				GameConfig.gameStateManager.humanWin();
				//
				this.processDone = true;
			}else
			{
				//temporary define first move from ording moves for hard-code test purpose.
				this.tempMove=this.orderingMoves[0];
				this.bestMove=this.orderingMoves[0];
			}
			//default execute run,to be overrided.
//			this.run();
			//
			super(isSelfManaging);
		}

		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		//----------------------------------
		//  moves(native)
		//----------------------------------
		/**
		 * @return all legal moves.
		 */
//		[Deprecated(replacement="com.lookbackon.AI.searching.SearchingBase.orderingMoves")]
		public function get moves():Vector.<ConductVO>
		{
			var _moves:Vector.<ConductVO> = generateMoves(FlexGlobals.chessPiecesModel.blues);
			//filter suicide moves.
			_moves = _moves.filter(FilterUtil.onSuicide);
			//TBC
			return _moves;
		}

		//----------------------------------
		//  orderingMoves(native)
		//----------------------------------
		/**
		 * <b>Ordering Moves To Speed Up Search</b></p>
		 * As we will see next time, search efficiency depends on the order in which moves are searched.</br>
		 * The gains and losses related to good or poor move ordering are not trivial: </br>
		 * a good ordering, defined as one which will cause a large number of cutoffs,
		 * will result in a search tree about the square root of
		 * the size of the tree associated with the worst possible ordering!</br>
		 * Unfortunately, it turns out that the best possible ordering is simply defined by trying the best move first.  </br>
		 * And of course, if you knew which moves are best, you wouldn't be searching in the first place.  </br>
		 * Still, there are ways to "guess" which moves are more likely to be good than others.  </br>
		 * For example, you might start with captures,
		 * pawn promotions (which dramatically change material balance on the board),
		 * or checks (which often allow few legal responses); </br>
		 * follow with moves which caused recent cutoffs at the same depth in the tree (so-called "killer moves"),</br>
		 * and then look at the rest.  </br>
		 * This is the justification for iterative deepening alphabeta, which we will discuss in detail next month,</br>
		 *  as well as the history table we talked about last time. </br>
		 * Note that these techniques do not constitute forward pruning: </br>
		 * all moves will be examined eventually; those which appear bad are only delayed, not eliminated from consideration.</br>
		 * A final note: in chess, some moves may be illegal because they leave the King in check.  </br>
		 * However, such an occurrence is quite rare,
		 * and it turns out that validating moves during generation would cost a tremendous amount of effort.  </br>
		 * It is more efficient to delay the check until the move is actually searched: </br>
		 * for example, if capturing the King would be a valid reply to Move X,
		 * then Move X is illegal and search should be terminated.  </br>
		 * Of course, if search is cutoff before the move has to be examined, validation never has to take place. </br>
		 *
		 * Move ordering techniques can be divided in three classes:  </br>
		 * <b>results of a previous search,</b>  </br>
		 * <b>dynamic move ordering</b>  </br>
		 * <b>and static move ordering.</b>  </br>
		 *
		 * @see http://www.gamedev.net/reference/articles/article1126.asp
		 * @see http://chessprogramming.wikispaces.com/Move+Ordering
		 *
		 * @return ordering legal moves,prototype is Vector.
		 *
		 */
		public function get orderingMoves():Vector.<ConductVO>
		{
			//TODO:ordering moves by order.
			return _orderingMoves;
		}

		public function set orderingMoves(value:Vector.<ConductVO>):void
		{
			_orderingMoves=value;
		}

		//----------------------------------
		//  captures(native)
		//----------------------------------
		/**
		 * This function generates all possible captures and stores them in the vector.</br>
		 * It returns the vector of the legal captures for Quiescene searching.</br>
		 *
		 * @return all legal captures.
		 */
		public function get captures():Vector.<ConductVO>
		{
			return orderingMoves.filter(FilterUtil.onCaptures);
		}

		//----------------------------------
		//  evaluation(native)
		//----------------------------------
		public function get evaluation():IEvaluation
		{
			return _evaluation;
		}

		public function set evaluation(value:IEvaluation):void
		{
			_evaluation=value;
		}
		//----------------------------------
		//  processDone(native)
		//----------------------------------
		public function get processDone():Boolean
		{
			return _processDone;
		}

		public function set processDone(value:Boolean):void
		{
			_processDone = value;
			if(value)
			{
				//after execute all kinds of searching algorithm,always apply move.
				if(this.bestMove)
				{
					this.applyMove(this.bestMove);
				}
			}
		}
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  generateMoves(native)
		//----------------------------------
		/**
		 * This function generates all possible moves and stores them in the vector.</br>
		 * It returns the vector of the legal moves.</br>
		 * While is checking,defend moves with high priority.</br>
		 * @param pieces chess pieces collection.
		 * @return all possible moves.
		 *
		 */
		final public function generateMoves(pieces:Vector.<ChessPiece>):Vector.<ConductVO>
		{
			if(!_movesHasGenerated)
			{
//				var resultAC:Vector.<ConductVO>=new Vector.<ConductVO>();
				for (var i:int=0; i < pieces.length; i++)
				{
					var cp:ChessPiece=pieces[i];
					var moves:BitBoard = cp.chessVO.moves;
					//
					for (var c:int=0; c < moves.column; c++)
					{
						for (var r:int=0; r < moves.row; r++)
						{
							if ( moves.getBitt(r, c) )
							{
								var conductVO:ConductVO=new ConductVO();
								conductVO.target=cp;
								conductVO.previousPosition=conductVO.target.position;
								conductVO.nextPosition=new Point(c, r);
								//append the doMoveValidation filters.
								//Why to do this functions?
								//cuz many type of chess,after the pre-generated chess vo(moves)
								//should be modified by some rule and limit.
								if(GameConfig.chessPieceManager.doMoveValidation(conductVO))
								{
									generatedMoves.push(conductVO);
								}
								//							trace("anew ",conductVO.dump());
							}
						}
					}
				}
			}
			//set this flag true.
			_movesHasGenerated = true;
			//
			return generatedMoves;
		}

		//----------------------------------
		//  makeMove(native)
		//----------------------------------
		/**
		 * Obviously,the struct move must contain all information necessary to support this operations.</p>
		 * As always,the structures are passed by reference,</p>
		 * in this case it is not only a speed question:</p>
		 * the position will be modified by this functions.</p>
		 * @param conductVO
		 * @return modified gameposition
		 *
		 */
		final public function makeMove(conductVO:ConductVO):void
		{
			GameConfig.chessPieceManager.makeMove(conductVO);
		}

		//----------------------------------
		//  unmakeMove(native)
		//----------------------------------
		/**
		 * Unmake previous move,for all kinds of searching tree algorithms.
		 */
		final public function unmakeMove(conductVO:ConductVO):void
		{
			GameConfig.chessPieceManager.unmakeMove(conductVO);
		}

		//----------------------------------
		//  applyMove(native)
		//----------------------------------
		final public function applyMove(conductVO:ConductVO):void
		{
			GameConfig.chessPieceManager.applyMove(conductVO);
		}

		//----------------------------------
		//  noneMove(native)
		//----------------------------------
		final public function noneMove():int
		{
			return GameConfig.chessPieceManager.noneMove();
		}

		//----------------------------------
		//  willNoneMove(native)
		//----------------------------------
		final public function willNoneMove(gamePosition:PositionVO):Boolean
		{
			return GameConfig.chessPieceManager.willNoneMove(gamePosition);
		}

		//----------------------------------
		//  doEvaluation(virtual)
		//----------------------------------
		/**
		 * The evaluation function will return positive values if the position is good for red and negative values.</br>
		 * if the position is bad for red in the MinMax formulation.</br>
		 * Many things could be said about evaluation functions,</br>
		 * for me,the two main objectives in designing a evaluation function are speed and accuracy.</br>
		 * The faster your evaluation function is,the better is.</br>
		 * and the more accurate its evaluation is,the beeter.</br>
		 * Obviously,these two things are somewhat at odds:</br>
		 * an accurate evaluation function probably is slower than a 'quick-and-dirty' one.</br>
		 * The evaluation function I'm taking about here is a heuristic one -not a exact one.</br>
		 * @see http://www.fierz.ch/strategy1.htm
		 * @param conductVO the current condutVO value.
		 * @param gamePosition the current game board positon info.
		 * @return evaluation result
		 *
		 */
		//virtual functions.
		virtual public function doEvaluation(conductVO:ConductVO, gamePosition:PositionVO):int
		{
			//delegate to evaluation proxy to do evaluation(); 
			return evaluation.doEvaluation(conductVO, gamePosition);
		}
		/**
		 *@inheritDoc
		 */		
		//virtual functions.
		override public function run():void
		{
			//TODO:implement functions.
		}
		/**
		 *@inheritDoc
		 */
		//return thread calculate precentage.
		override public function get percentage():Number
		{
			return processDone ? 1 : 0.33;
		}
	}
}

