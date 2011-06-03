package com.lookbackon.ds.graph.searcher
{
	import com.lookbackon.ds.graph.Edge;
	import com.lookbackon.ds.GraphBoard;
	import com.lookbackon.ds.graph.PriorityEdgeQueueDsc;
	import com.lookbackon.ds.graph.WeightedEdge;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------

	/**
	 * DIJKSTRAsearcher.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jun 1, 2011 6:18:28 PM
	 */
	public class DIJKSTRAsearcher extends SearcherBase
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
		public function DIJKSTRAsearcher(graph:GraphBoard)
		{
			super(graph);
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		override public function search(src:int, dst:int):Boolean
		{
			var pq:PriorityEdgeQueueDsc=new PriorityEdgeQueueDsc();
			pq.insert(new Edge(src, src), 0);

			var route:Array /* of int */=new Array(graphRef_.size);
			var weight:Array /* of int */=new Array(graphRef_.size);

			while (pq.length > 0)
			{
				var next:Edge=pq.popObj() as Edge;
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
				for each (var e:WeightedEdge in dsts)
				{
					if (route[e.dst] === undefined)
					{
						var w:int=(weight[next] >> 0) + e.weight;
						weight[e.dst]=w;
						pq.insert(e, w);
					}
				}
			}

			return false;
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
