package com.lookbackon.ds
{
	import com.godpaper.as3.errors.DefaultErrors;
	import com.lookbackon.ds.aStar.AStarNode;
	
	import de.polygonal.ds.BitVector;

	/**
	 * <strong>Pros and Cons of Using BitBoard Flags:</strong></p>
	 * <strong>Pros:</strong></p>
	 * Efficient: Very small storage space to hold a lot of information.</p>
	 * Efficient: Ultra-fast (actually fastest possible) for making programmatic decisions,
	 * especially when looking for combinations of attributes or options.</p>
	 * Efficient: Concise storage means fast data transfer.</p>
	 * Extensible:  New code does not "break" old code.  </p>
	 * Additional (new) data can be packed into the same variable without causing backward compatibility problems.</p>
	 * Extensible:  New data does not require new database schema or changed record layouts.  </p>
	 * Only the program code changes.</p>
	 * <strong>Cons:</strong></p>
	 * Idiomatic.  Not all programmers understand what's going on.  </p>
	 * Possible increased documentation requirements.</p>
	 * @see http://blog.lookbackon.com/?p=371
	 * @author Knight.zhou
	 * @history 05/16/2011 added the implementation of IAStar;
	 */	
	public class BitBoard extends BitVector implements IBitBoard,IAStar
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var _column:int;
		private var _row:int;
		//extened variables for IAStar.
		private var _startNode:AStarNode;
		private var _endNode:AStarNode;
		private var _nodes:Array;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		/**
		 *
		 * @param column the number column of bit board.
		 * @param row the number row of bit board.
		 *
		 */
		public function BitBoard(column:int,row:int)
		{
			this._column  = column;
			this._row = row;
			//TODO: implement function
			super(column*row);
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
		//  Properties
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  column(read-only)
		//----------------------------------
		public function get column():int
		{
			return _column;
		}
		//----------------------------------
		//  row(read-only)
		//----------------------------------
		public function get row():int
		{
			return _row;
		}
		//----------------------------------
		//  IAStar
		//----------------------------------
		/**
		 * Returns the end node.
		 */
		public function get endNode():AStarNode
		{
			return _endNode;
		}
		/**
		 * Returns the start node.
		 */
		public function get startNode():AStarNode
		{
			return _startNode;
		}
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  and(IBitBoard)
		//----------------------------------
		public function and(value:BitBoard):BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			for(var h:int=0;h<_row;h++)
			{
				for(var w:int=0;w<_column;w++)
				{
					bb.setBitt(h,w,Boolean((value.getBitt(h,w)&this.getBitt(h,w))));
				}
			}
			return bb;
		}
		//----------------------------------
		//  not(IBitBoard)
		//----------------------------------
		public function not():BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			for(var h:int=0;h<_row;h++)
			{
				for(var w:int=0;w<_column;w++)
				{
					bb.setBitt(h,w,!Boolean(this.getBitt(h,w)));
				}
			}
			return bb;
		}
		//----------------------------------
		//  or(IBitBoard)
		//----------------------------------
		public function or(value:BitBoard):BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			for(var h:int=0;h<_row;h++)
			{
				for(var w:int=0;w<_column;w++)
				{
					bb.setBitt(h,w,Boolean((value.getBitt(h,w)|this.getBitt(h,w))));
				}
			}
			return bb;
		}
		//----------------------------------
		//  xor(IBitBoard)
		//----------------------------------
		public function xor(value:BitBoard):BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			for(var h:int=0;h<_row;h++)
			{
				for(var w:int=0;w<_column;w++)
				{
					bb.setBitt(h,w,Boolean((value.getBitt(h,w)^this.getBitt(h,w))));
				}
			}
			return bb;
		}
		//----------------------------------
		//  rotate45=(IBitBoard)
		//----------------------------------
		/**
		 * notice:this function is suitable for which board column equals to row.
		 * @return Fliped rows with cols such as clockwise rotatation 45 degree.
		 */	
		public function rotate45():BitBoard
		{
			//TODO:
			return new BitBoard(0,0);
		}
		//----------------------------------
		//  rotate90=(IBitBoard)
		//----------------------------------
		/**
		 * @return Fliped rows with cols such as clockwise rotatation 90 degree.
		 */		
		public function rotate90():BitBoard
		{
			var bb:BitBoard = new BitBoard(_row,_column);
			for(var w:int=0;w<_row;w++)
			{
				for(var h:int=0;h<_column;h++)
				{
					bb.setBitt(h,w,Boolean(this.getBitt(w,h)));
				}
			}
			return bb;
		}
		//----------------------------------
		//  reverse(IBitBoard)
		//----------------------------------
		/**
		 * @return reversed rows with cols such as mirror rotatation 180 degree.
		 */		
		public function reverse():BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			for(var w:int=0;w<_column;w++)
			{
				for(var h:int=0;h<_row;h++)
				{
					bb.setBitt(h,w,Boolean(this.getBitt(_row-h-1,w)));
				}
			}
			return bb;
		}
		//----------------------------------
		//  getBitt
		//----------------------------------
		/**
		 * Gets a bit from a given row and column.
		 * @param row the row number.
		 * @param column the column number.
		 * @return the index bool value.
		 *
		 */		
		public function getBitt(row:int,column:int):int
		{
			return this.getBit(row*_column+column);
		}
		/**
		 * Sets a bit at a given row and column.
		 * @param row the row number.
		 * @param column the column number.
		 * @param b the index bool value.
		 *
		 */
		//----------------------------------
		//  setBitt
		//----------------------------------
		public function setBitt(row:int,column:int,b:Boolean):void
		{
			var index:int = (row*_column+column);
			if(index>=0&&index<=_column*_row)
			{
				this.setBit(index,b);
				//esp for IAStar.
				this.setWalkable(column,row,b);
			}else
			{
				return;//Maybe handle this illegal operation.
				throw new DefaultErrors(DefaultErrors.INVALID_CHESS_VO);
			}
		}
		//----------------------------------
		//  toString
		//----------------------------------
		/**
		 * @inheritDoc
		 */		
		override public function toString() : String
		{
			return "[BitBoard, size=" + (_column*_row) + "]";
		}
		//----------------------------------
		//  clone
		//----------------------------------
		public function clone():BitBoard
		{
			var bb:BitBoard = new BitBoard(this.column,this.row);
			for(var h:int=0;h<_row;h++)
			{
				for(var w:int=0;w<_column;w++)
				{
					bb.setBitt(h,w,Boolean(this.getBitt(h,w)));
				}
			}
			return bb;
		}
		//----------------------------------
		//  Utilities
		//----------------------------------
		//----------------------------------
		//  celled
		//----------------------------------
		/**
		 *
		 * @return total cell be filled or cell-free.
		 *
		 */		
		public function get celled():int
		{
			var _celled:int = 0;
			for(var h:int=0;h<_row;h++)
			{
				for(var w:int=0;w<_column;w++)
				{
					if(this.getBitt(h,w))
					{
						_celled++;
					}
				}
			}
			return _celled;
		}
		//----------------------------------
		//  isEmpty
		//----------------------------------
		/**
		 * whether or not bitboard is empty;
		 */		
		public function get isEmpty():Boolean
		{
			for(var h:int=0;h<_row;h++)
			{
				for(var w:int=0;w<_column;w++)
				{
					if(this.getBitt(h,w))
					{
						return false;
					}
				}
			}
			return true;
		}
		//----------------------------------
		//  getRows
		//----------------------------------
		public function getRows(rowIndex:int):Array
		{
			var result:Array = [];
			for(var col:int=0;col<this.column;col++)
			{
				result.push(this.getBitt(rowIndex,col));
			}
			return result;
		}
		//----------------------------------
		//  getCols
		//----------------------------------
		public function getCols(colIndex:int):Array
		{
			var result:Array = [];
			for(var row:int=0;row<this.row;row++)
			{
				result.push(this.getBitt(row,colIndex));
			}
			return result;
		}
		//----------------------------------
		//  dump
		//----------------------------------
		/**
		 * Dump out a string representing the current object.
		 *
		 * @return A "human-readable" string representing the current object.
		 */	
		public function dump():String
		{
			var result:String = "[BitBoard, size=";
			result = result.concat((_column*_row).toString(),"\n","{");
			//
			for(var h:int=0;h<_row;h++)
			{
				result = result.concat("\n","\t");
				for(var w:int=0;w<_column;w++)
				{
					result = result.concat("[",this.getBit(this._column*h+w).toString(),"]");
				}
			}
			result = result.concat("\n","}","]");
			return result;
		}
		//----------------------------------
		//  IAStar
		//----------------------------------
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
	}
}

