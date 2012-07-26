package com.lookbackon.ds
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.lookbackon.ds.aStar.AStarNode;
	
	
	/**
	 * It is a similar of bitboard struct,and every cell representation a star node. 	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Aug 29, 2011 5:04:38 PM
	 * @see http://www.fzibi.com/cchess/bitboards.htm
	 * @see http://en.wikipedia.org/wiki/A*_search_algorithm
	 */   	 
	public class AStarNodeBoard implements IAStar
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//extened variables for IAStar.
		private var _startNode:AStarNode;
		private var _endNode:AStarNode;
		private var _nodes:Array;
		private var _column:int;
		private var _row:int;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		public function get row():int
		{
			return _row;
		}
		
		public function set row(value:int):void
		{
			_row = value;
		}
		//
		public function get column():int
		{
			return _column;
		}
		
		public function set column(value:int):void
		{
			_column = value;
		}
		//
		public function get endNode():AStarNode
		{
			return _endNode;
		}
		//
		public function get startNode():AStarNode
		{
			return _startNode;
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
		public function AStarNodeBoard(column:int,row:int)
		{
			this._column  = column;
			this._row = row;
			//extended variables for IAStar.
			_nodes = new Array();
			//
			for(var i:int = 0; i < this.column; i++)
			{
				_nodes[i] = new Array();
				for(var j:int = 0; j < this.row; j++)
				{
					_nodes[i][j] = new AStarNode(i, j);
				}
			}
		}
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		/**
		 * Returns the node at the given coords.
		 * @param x The x coord.
		 * @param y The y coord.
		 */
		public function getNode(x:int, y:int):AStarNode
		{
			return _nodes[x][y] as AStarNode;
		}
		/**
		 * Sets the node at the given coords as the end node.
		 * @param x The x coord.
		 * @param y The y coord.
		 */
		public function setEndNode(x:int, y:int):void
		{
			_endNode = _nodes[x][y] as AStarNode;
		}
		
		/**
		 * Sets the node at the given coords as the start node.
		 * @param x The x coord.
		 * @param y The y coord.
		 */
		public function setStartNode(x:int, y:int):void
		{
			_startNode = _nodes[x][y] as AStarNode;
		}
		
		/**
		 * Sets the node at the given coords as walkable or not.
		 * @param x The x coord.
		 * @param y The y coord.
		 */
		public function setWalkable(x:int, y:int, value:Boolean):void
		{
			_nodes[x][y].walkable = value;
		}
		//
		public function toString():String
		{
			return "AStarNodeBoard->col:"+this.column+",row:"+this.row;
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