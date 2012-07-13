package jp.dip.hael.gameai.util
{
	/**
	 * 降順のPriorityQueue
	 */
	public class PriorityQueueDsc
	{
		public function get length():int { return priList_.length; }
		
		public function PriorityQueueDsc()
		{
			objList_ = [];
			priList_ = [];
		}
		
		public function insert(obj:Object, priority:int):void
		{
			var l:int = priList_.length;
			for(var i:int = 0; i < l; i++){
				if(priority >= priList_[i]){
					priList_.splice(i, 0, priority);
					objList_.splice(i, 0, obj);
					break;
				}
			}
			if(i == l){
				priList_.push(priority);
				objList_.push(obj);
			}
		}
		
		public function pop():Array
		{
			return [objList_.pop(), priList_.pop()];
		}
		
		public function popObj():Object
		{
			priList_.pop();
			return objList_.pop();
		}
		
		public function popPriority():int
		{
			objList_.pop();
			return priList_.pop();
		}
		
		
		private var objList_:Array /* of Object */;
		private var priList_:Array /* of int */;
	}
}