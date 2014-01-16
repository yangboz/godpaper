// ActionScript file
package jp.dip.hael.gameai.graph
{
	import flash.utils.getTimer;
	
	import jp.dip.hael.gameai.graph.searcher.BFS;
	import jp.dip.hael.gameai.graph.searcher.Dijkstra;
	

	/**
	 * @private
	 */
	public class GraphTest
	{
		public function GraphTest()
		{
			var g:GraphEx = new GraphEx();
			g.addNode(new Node(1));
			g.addNode(new Node(2));
			g.addNode(new Node(3));
			g.addNode(new Node(4));
			g.addNode(new Node(5));
			g.addNode(new Node(6));
			g.addEdge(new WeightedEdge(5, 2, 19));
			g.addEdge(new WeightedEdge(5, 6, 30));
			g.addEdge(new WeightedEdge(1, 5, 29));
			g.addEdge(new WeightedEdge(1, 6, 10));
			g.addEdge(new WeightedEdge(3, 5,  8));
			g.addEdge(new WeightedEdge(6, 4, 11));
			g.addEdge(new WeightedEdge(4, 3, 37));
			g.addEdge(new WeightedEdge(2, 3, 31));
			
			var d:Dijkstra = new Dijkstra(g);
			var t:int = getTimer();
			for(var i:int = 0; i < 1000; i++){
				d.search(5, 3);
			}
			trace(d.path);
			trace(getTimer() - t);
//			for each(var e:Edge in d.pathRef){
//				trace(e.src + "->" + e.dst);
//			}
			var b:BFS = new BFS(g);
			t = getTimer();
			for(i = 0; i < 1000; i++){
				b.search(5, 3);
			}
			trace(getTimer() - t);
//			for each(var e:Edge in b.pathRef){
//				trace(e.src + "->" + e.dst);
//			}
			
			
//			var pq:PriorityQueueDsc = new PriorityQueueDsc();
//			t = getTimer();
//			for(i = 0; i < 10000; i++){
//				pq.insert(i, Rand.intRange(0, 100));
//			}
//			trace(getTimer() - t);
//			var pq2:PriorityQueueDsc2 = new PriorityQueueDsc2();
//			t = getTimer();
//			for(i = 0; i < 10000; i++){
//				pq2.insert(i, Rand.intRange(0, 100));
//			}
//			trace(getTimer() - t);
		}

	}
}