package jp.dip.hael.gameai.graph
{
	public class Edge
	{
		public var src:int;
		public var dst:int;
		public function Edge(src:int=-1,dst:int=-1)
		{
			this.src = src;
			this.dst = dst;
		}
		/**
		 * Prints out all elements (for debug/demo purposes).
		 * 
		 * @return A human-readable representation of the structure.
		 */		
		public function dump():String
		{
			var s:String = "GraphEdge";
			s += "["+this.src + "---->"+this.dst+"]";
			return s;
		}
	}
}