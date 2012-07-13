package jp.dip.hael.gameai.graph.searcher
{
	import jp.dip.hael.gameai.graph.GraphEx;
	import jp.dip.hael.gameai.graph.Edge;
	import jp.dip.hael.gameai.graph.WeightedEdge;
	import jp.dip.hael.gameai.util.PriorityQueueDsc;

	public class Dijkstra extends Searcher
	{
		public function Dijkstra(graph:GraphEx)
		{
			super(graph);
		}
		
		
		public override function search(src:int, dst:int):Boolean
		{
			var pq:PriorityQueueDsc = new PriorityQueueDsc();
			pq.insert(new Edge(src, src), 0);
			
			var route:Array /* of int */ = new Array(graphRef_.size);
			var weight:Array /* of int */ = new Array(graphRef_.size);
			
			while(pq.length > 0){
				var next:Edge = pq.popObj() as Edge;
				route[next.dst] = next.src;
				
				if(next.dst == dst){
					src_ = src;
					dst_ = dst;
					route_ = route;
					found_ = true;
					return true;
				}
				
				var dsts:Array = graphRef_.edge(next.dst);
				for each(var e:WeightedEdge in dsts){
					if(route[e.dst] === undefined){
						var w:int = (weight[next]>>0) + e.weight;
						weight[e.dst] = w;
						pq.insert(e, w);
					}
				}
			}
			
			return false;
		}
		
	}
}