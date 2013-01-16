package com.lookbackon.ds.graph.searcher
{
	import com.lookbackon.ds.graph.Edge;
	import com.lookbackon.ds.GraphBoard;

	import mx.collections.ArrayCollection;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------

	/**
	 * SearcherBase.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jun 1, 2011 6:11:43 PM
	 */
	public class SearcherBase
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		protected var graphRef_:GraphBoard;
		protected var path_:Array /* of int */;
		protected var route_:Array /* of int */;
		protected var src_:int, dst_:int;
		protected var found_:Boolean;

		//----------------------------------
		//  CONSTANTS
		//----------------------------------

		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		/**
		 * Reference to route found by search that succeeds
		 */
		public function get pathRef():Array /* of Edge */
		{
			if (found_)
			{
				path_=route2path(route_, src_, dst_);
				found_=false;
			}
			return path_;
		}

		/**
		 * Copy of route found by search that succeeds
		 */
		public function get path():Array /* of Edge */
		{
			return pathRef.slice();
		}

		/**
		 * @return all simple paths from src to dst;
		 */
		private var _allSimplePaths:ArrayCollection;

		public function get allSimplePaths():ArrayCollection
		{
			return _allSimplePaths;
		}

		public function set allSimplePaths(value:ArrayCollection):void
		{
			_allSimplePaths=value;
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
		/**
		 * Constructor
		 *
		 * @param graph Graph to be searched
		 */
		public function SearcherBase(graph:GraphBoard)
		{
			graphRef_=graph;
			path_=[];
			route_=[];
			found_=false;
			allSimplePaths=new ArrayCollection();
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		/**
		 * Search execution
		 *
		 * @param src Starting point
		 * @param dst Terminal point
		 * @return When it exists, it is true, and a pertinent route is false when not existing.
		 */
		public function search(src:int, dst:int):Boolean
		{
			return false;
		}

		/**
		 * @param src Starting point
		 * @param dst Terminal point
		 * @param visited, A linked list of visited node.
		 * @return all simple path(s) between origin and terminal;
		 */
		public function searchAll(src:int, dst:int, visited:ArrayCollection):void
		{
			//
		}

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		/**
		 * restore founded all simple path(s);
		 * @param visited
		 *
		 */
		protected function saveToAllSimplePaths(visited:ArrayCollection):void
		{
			trace("foundSimplePath(s)@BFS:[", visited, "]");
			var tempArray:Array=[];
			for (var i:int=0; i < visited.length; i++)
			{
				tempArray.push(visited.getItemAt(i));
			}
			allSimplePaths.addItem(tempArray);
		}

		/**
		 * @private
		 * It will lack it later.
		 */
		protected function route2path(route:Array, src:int, dst:int):Array
		{
			var path:Array=[];
			var s:int=-1, d:int=dst;
			while (s != src)
			{
				s=route[d];
				path.push(new Edge(s, d));
				d=s;
			}
			return path.reverse();
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}

}
