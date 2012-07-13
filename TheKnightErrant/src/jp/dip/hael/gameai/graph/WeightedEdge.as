package jp.dip.hael.gameai.graph
{
	public class WeightedEdge extends Edge
	{
		public var weight:int;
		
		public function WeightedEdge(src:int, dst:int, weight:int = 1)
		{
			this.weight = weight;
			super(src, dst);
		}
		
		/**
		 * Prints out all elements (for debug/demo purposes).
		 * 
		 * @return A human-readable representation of the structure.
		 */		
		override public function dump():String
		{
			var s:String = "GraphEdge";
			s += "["+this.src + "--"+this.weight+"-->"+this.dst+"]";
			return s;
		}
		
	}
}