package com.lookbackon.ds.graph.searcher
{
	import com.lookbackon.ds.graph.Edge;
	import com.lookbackon.ds.GraphBoard;
	import com.lookbackon.ds.graph.WeightedEdge;

	import mx.collections.ArrayCollection;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------

	/**
	 * BFSsearcher.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jun 1, 2011 6:17:22 PM
	 */
	public class BFSsearcher extends SearcherBase
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		//----------------------------------
		//  CONSTANTS
		//----------------------------------

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
		public function BFSsearcher(graph:GraphBoard)
		{
			super(graph);
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		/**
		 * @inheritDoc
		 */
		override public function search(src:int, dst:int):Boolean
		{
			var queue:Array /* of Edge */=[];
			queue.push(new Edge(src, src));

			var visited:Array /* of Boolean */=new Array(graphRef_.size);
			visited[src]=true;

			var route:Array /* of int */=new Array(graphRef_.size);

			while (queue.length > 0)
			{
				var next:Edge=queue.shift();
				route[next.dst]=next.src;

				if (next.dst == dst)
				{
					src_=src;
					dst_=dst;
					route_=route;
					found_=true;
					return true;
				}

				var dsts:Array=graphRef_.edge(next.dst);
				for each (var e:Edge in dsts)
				{
					if (!visited[e.dst])
					{
						queue.push(e);
						visited[e.dst]=true;
					}
				}
			}

			return false;
		}

		/**
		 * @inheritDoc
		 */
		override public function searchAll(src:int, dst:int, visited:ArrayCollection):void
		{
			var nodes:Array=new Array();
			if (!(graphRef_.edge(src) is Array))
			{
				return;
			}
			for (var i:int=0; i < graphRef_.edge(src).length; i++)
			{
				nodes.push((graphRef_.edge(src)[i] as WeightedEdge).dst);
			}
			//trace("nodes:",nodes);
			for (var node:* in nodes)
			{
				//trace("~node:",node,"nodes[node]",nodes[node]);
				if (visited.contains(nodes[node]))
				{
					continue;
				}
				if (int(nodes[node]) == dst)
				{
					visited.addItem(nodes[node]);
					//restore this path.
					saveToAllSimplePaths(visited);
					visited.removeItemAt(visited.length - 1);
					break;
				}
			}
			// in breadth-first, recursion needs to come after visiting adjacent nodes
			for (var node2:* in nodes)
			{
				//trace("~~node:",node,"nodes[node]",nodes[node]);
				if (visited.contains(nodes[node2]) || int(nodes[node2]) == dst)
				{
					continue;
				}
				visited.addItem(nodes[node2]);
				searchAll(nodes[node2], dst, visited);
				visited.removeItemAt(visited.length - 1);
			}
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
