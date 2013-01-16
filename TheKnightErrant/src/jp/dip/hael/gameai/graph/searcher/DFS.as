package jp.dip.hael.gameai.graph.searcher
{
	import jp.dip.hael.gameai.graph.Edge;
	import jp.dip.hael.gameai.graph.GraphEx;
	/**
	 * 
	 * @author Knight-errant
	 * 
	 */	
	public class DFS extends Searcher
	{
		public function DFS(graph:GraphEx)
		{
			super(graph);
		}
		
		override public function search(src:int, dst:int) : Boolean
		{
			var queue:Array /* of Edge */ = [];
			queue.push(new Edge(src, src));
			
			var visited:Array /* of Boolean */ = new Array(graphRef_.size);
			visited[src] = true;
			
			var route:Array /* of int */ = new Array(graphRef_.size);
			
			while(queue.length > 0){
				var next:Edge = queue.pop();
				route[next.dst] = next.src;
				
				if(next.dst == dst){
					src_ = src;
					dst_ = dst;
					route_ = route;
					found_ = true;
					return true;
				}
				
				var dsts:Array = graphRef_.edge(next.dst);
				for each(var e:Edge in dsts){
					if(!visited[e.dst]){
						queue.push(e);
						visited[e.dst] = true;
					}
				}
			}
			
			return false;
		}
	}
}