package com.lookbackon.ds.aStar
{
	import com.lookbackon.ds.BitBoard;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * In computer science, A* (pronounced "A star" ( listen)) is a computer algorithm that is widely used in pathfinding and graph traversal, 
	 * the process of plotting an efficiently traversable path between points, called nodes. 
	 * Noted for its performance and accuracy, it enjoys widespread use. 
	 * Peter Hart, Nils Nilsson and Bertram Raphael first described the algorithm in 1968.[1] 
	 * It is an extension of Edsger Dijkstra's 1959 algorithm. A* achieves better performance (with respect to time) by using heuristics.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created May 13, 2011 1:34:05 PM
	 * @see http://www.policyalmanac.org/games/aStarTutorial.htm
	 */   	 
	public class AStar
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var _open:Array;
		private var _closed:Array;
		private var _grid:BitBoard;
		private var _endNode:AStarNode;
		private var _startNode:AStarNode;
		private var _path:Array;
		//		private var _heuristic:Function = manhattan;
		private var _heuristic:Function = euclidian;
		//		private var _heuristic:Function = diagonal;
		private var _straightCost:Number = 1;
		private var _diagCost:Number = Math.SQRT2;
		//		private var _diagCost:Number = 2;
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
		public function AStar()
		{
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		/**
		 * 
		 * @param AStarBitBoard data source.
		 * @return AStarBitBoard path finding result
		 * 
		 */		
		public function findPath(grid:BitBoard):Boolean
		{
			_grid = grid;
			_open = new Array();
			_closed = new Array();
			
			_startNode = _grid.startNode;
			_endNode = _grid.endNode;
			
			_startNode.g = 0;
			_startNode.h = _heuristic(_startNode);
			_startNode.f = _startNode.g + _startNode.h;
			
			return search();
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
		/**
		 * Like all informed search algorithms, it first searches the routes that appear to be most likely to lead towards the goal. 
		 * @return current step goal searching result.
		 * 
		 */		
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
					trace("no path found @ AStar search!");
					return false;
				}
				_open.sortOn("f", Array.NUMERIC);
				node = _open.shift() as AStarNode;
			}
			buildPath();
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
		//
		private function manhattan(node:AStarNode):Number
		{
			return Math.abs(node.x - _endNode.x) * _straightCost + Math.abs(node.y + _endNode.y) * _straightCost;
		}
		//
		private function euclidian(node:AStarNode):Number
		{
			var dx:Number = node.x - _endNode.x;
			var dy:Number = node.y - _endNode.y;
			return Math.sqrt(dx * dx + dy * dy) * _straightCost;
		}
		//
		private function diagonal(node:AStarNode):Number
		{
			var dx:Number = Math.abs(node.x - _endNode.x);
			var dy:Number = Math.abs(node.y - _endNode.y);
			var diag:Number = Math.min(dx, dy);
			var straight:Number = dx + dy;
			return _diagCost * diag + _straightCost * (straight - 2 * diag);
		}
		
	}
	
}