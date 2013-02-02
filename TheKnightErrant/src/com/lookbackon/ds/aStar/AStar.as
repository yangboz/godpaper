package com.lookbackon.ds.aStar
{
	import com.lookbackon.ds.AStarNodeBoard;
	
	import org.generalrelativity.thread.process.AbstractProcess;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------

	/**
	 * In computer science, A* (pronounced "A star") is a computer algorithm that is widely used in pathfinding and graph traversal,
	 * the process of plotting an efficiently traversable path between points, called nodes.
	 * Noted for its performance and accuracy, it enjoys widespread use.
	 * Peter Hart, Nils Nilsson and Bertram Raphael first described the algorithm in 1968.[1]
	 * It is an extension of Edsger Dijkstra's 1959 algorithm. A* achieves better performance (with respect to time) by using heuristics.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created May 13, 2011 1:34:05 PM
	 * @see http://www.policyalmanac.org/games/aStarTutorial.htm
	 * @see http://theory.stanford.edu/~amitp/GameProgramming/AStarComparison.html
	 */   	 
	public class AStar extends AbstractProcess
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var _open:Array;
		private var _closed:Array;
		private var _grid:AStarNodeBoard;
		private var _endNode:AStarNode;
		private var _startNode:AStarNode;
		private var _path:Array;
		//		private var _heuristic:Function = manhattan;
		private var _heuristic:Function = euclidian;
		//		private var _heuristic:Function = diagonal;
		private var _straightCost:Number = 1;
//		private var _diagCost:Number = Math.SQRT2;
		private var _diagCost:Number = 2;
		//flag whether this process done.
		private var _processDone:Boolean;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------

		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		public function get path():Array
		{
			return _path;
		}
		//
		public function get visited():Array
		{
			return _closed.concat(_open);
		}
		//
		public function get heuristic():Function
		{
			return _heuristic;
		}
		public function set heuristic(value:Function):void
		{
			_heuristic = value;
		}
		//
		/**
		 * @return AStarBitBoard data source.
		 */		
		public function get grid():AStarNodeBoard
		{
			return _grid;
		}
		/**
		 * @param value AStarBitBoard data source.
		 */		
		public function set grid(value:AStarNodeBoard):void
		{
			_grid = value;
			//preparde data
			_open = new Array();
			_closed = new Array();
			
			_startNode = _grid.startNode;
			_endNode = _grid.endNode;
			
			_startNode.g = 0;
			_startNode.h = _heuristic(_startNode);
			_startNode.f = _startNode.g + _startNode.h;
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
		}
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
		public function AStar(isSelfManaging:Boolean=false)
		{
			//default execute run,to be overrided.
			//			this.run();
			super(isSelfManaging);
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		//Heuristic funcs
		/**
		 * The standard heuristic for a square grid is the Manhattan distance.  
		 * On a square grid that allows 4 directions of movement, use Manhattan distance (L1).
		 * @param node AStarNode carried some node info.
		 * @return Manhattan distance
		 * @see http://theory.stanford.edu/~amitp/GameProgramming/Heuristics.html
		 */		
		public function manhattan(node:AStarNode):Number
		{
			return Math.abs(node.x - _endNode.x) * _straightCost + Math.abs(node.y + _endNode.y) * _straightCost;
		}
		//
		/**
		 * The standard heuristic for a square grid is the Euclidean distance.  
		 * On a square grid that allows any direction of movement, you might or might not want Euclidean distance (L2). 
		 * If A* is finding paths on the grid but you are allowing movement not on the grid, you may want to consider other representations of the map.
		 * @param node AStarNode carried some node info.
		 * @return Euclidean distance
		 * @see http://theory.stanford.edu/~amitp/GameProgramming/Heuristics.html
		 */
		public function euclidian(node:AStarNode):Number
		{
			var dx:Number = node.x - _endNode.x;
			var dy:Number = node.y - _endNode.y;
			return Math.sqrt(dx * dx + dy * dy) * _straightCost;
		}
		//
		/**
		 * The standard heuristic for a square grid is the Diagonal distance.  
		 * On a square grid that allows 8 directions of movement, use Diagonal distance (L∞).
		 * @param node AStarNode carried some node info.
		 * @return Diagonal distance
		 * @see http://theory.stanford.edu/~amitp/GameProgramming/Heuristics.html
		 */
		public function diagonal(node:AStarNode):Number
		{
			var dx:Number = Math.abs(node.x - _endNode.x);
			var dy:Number = Math.abs(node.y - _endNode.y);
			var diag:Number = Math.min(dx, dy);
			var straight:Number = dx + dy;
			return _diagCost * diag + _straightCost * (straight - 2 * diag);
		}
		/**
		 *@inheritDoc
		 */		
		//virtual functions.
		/**
		 * Like all informed search algorithms, it first searches the routes that appear to be most likely to lead towards the goal.
		 * @return current step goal searching result.
		 *
		 */		
		override public function run():void
		{
			//ready to search.
			this.search();
		}
		/**
		 *@inheritDoc
		 */
		//return thread calculate precentage.
		override public function get percentage():Number
		{
			return processDone ? 1 : 0.33;
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
		//
		private function search():Boolean
		{	
			var node:AStarNode = _startNode;
			while(node != _endNode)
			{
				var startX:int = Math.max(0, node.x - 1);
				var endX:int = Math.min(_grid.column - 1, node.x + 1);
				var startY:int = Math.max(0, node.y - 1);
				var endY:int = Math.min(_grid.row - 1, node.y + 1);
				
				for(var i:int = startX; i <= endX; i++)
				{
					for(var j:int = startY; j <= endY; j++)
					{
						var test:AStarNode = _grid.getNode(i, j);
						if(test == node || 
							!test.walkable ||
							!_grid.getNode(node.x, test.y).walkable ||
							!_grid.getNode(test.x, node.y).walkable)
						{
							continue;
						}
						
						var cost:Number = _straightCost;
						if(!((node.x == test.x) || (node.y == test.y)))
						{
							cost = _diagCost;
						}
						var g:Number = node.g + cost * test.costMultiplier;
						var h:Number = _heuristic(test);
						var f:Number = g + h;
						if(isOpen(test) || isClosed(test))
						{
							if(test.f > f)
							{
								test.f = f;
								test.g = g;
								test.h = h;
								test.parent = node;
							}
						}
						else
						{
							test.f = f;
							test.g = g;
							test.h = h;
							test.parent = node;
							_open.push(test);
						}
					}
				}
				for(var o:int = 0; o < _open.length; o++)
				{
				}
				_closed.push(node);
				if(_open.length == 0)
				{
					//trace("no path found @ AStar search!");
					this.processDone = true;
					return false;
				}
				_open.sortOn("f", Array.NUMERIC);
				node = _open.shift() as AStarNode;
			}
			//
			buildPath();
			this.processDone = true;
			return true;
		}
		//
		private function buildPath():void
		{
			_path = new Array();
			var node:AStarNode = _endNode;
			_path.push(node);
			while(node != _startNode)
			{
				node = node.parent;
				_path.unshift(node);
			}
		}
		//
		private function isOpen(node:AStarNode):Boolean
		{
			for(var i:int = 0; i < _open.length; i++)
			{
				if(_open[i] == node)
				{
					return true;
				}
			}
			return false;
		}
		//
		private function isClosed(node:AStarNode):Boolean
		{
			for(var i:int = 0; i < _closed.length; i++)
			{
				if(_closed[i] == node)
				{
					return true;
				}
			}
			return false;
		}
	}

}

