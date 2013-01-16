package jp.dip.hael.gameai.graph.searcher
{
	import jp.dip.hael.gameai.graph.Edge;
	
	/**
	 * 降順のPriorityQueue
	 */
	public class PriorityEdgeQueueDsc
	{
		public function get length():int { return priList_.length; }
		
		public function PriorityEdgeQueueDsc()
		{
			edgList_ = [];
			priList_ = [];
		}
		
		public function insert(edg:Edge, priority:int):void
		{
			var l:int = priList_.length;
			for(var i:int = 0; i < l; i++){
				if(priority >= priList_[i]){
					priList_.splice(i, 0, priority);
					edgList_.splice(i, 0, edg);
					break;
				}
			}
			if(i == l){
				priList_.push(priority);
				edgList_.push(edg);
			}
		}
		
		public function pop():Array
		{
			return [edgList_.pop(), priList_.pop()];
		}
		
		public function popObj():Edge
		{
			priList_.pop();
			return edgList_.pop();
		}
		
		public function popPriority():int
		{
			edgList_.pop();
			return priList_.pop();
		}
		
		
		private var edgList_:Array /* of Edge*/;
		private var priList_:Array /* of int */;
	}
}