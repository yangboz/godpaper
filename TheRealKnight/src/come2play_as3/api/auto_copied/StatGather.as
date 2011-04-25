package come2play_as3.api.auto_copied
{
	public final class StatGather
	{		
		private var count:int = 0;
		private var sum:int = 0;
		private var max:int = int.MIN_VALUE;
		private var min:int = int.MAX_VALUE;
		private var bucketSize:int;
		private var bucketsNum:int;
		private var buckets:Array/*int*/ = [];
		public function StatGather(bucketSize:int, bucketsNum:int) {
			this.bucketSize = bucketSize;
			this.bucketsNum = bucketsNum;
			for (var i:int=0; i<bucketsNum; i++)
				buckets[i] = 0;
		}
		public function add(stat:int):void {
			count++;
			sum += stat;
			max = Math.max(stat,max);
			min = Math.min(stat,min);
			var bucketIndex:int = Math.max(0,Math.min(bucketsNum-1,int(stat/bucketSize)));
			buckets[bucketIndex]++;
		}
		public function getBucketPercent(index:int):int { 
			return int(buckets[index]*100/count); 
		}
		public function getBuckets():String {
			var res:Array = [];
			for (var i:int=0; i<bucketsNum; i++)
				res.push( getBucketPercent(i) + "%" ); 
			return res.join(" "); 
		}
		public function getBucketsNum():int { return bucketsNum; }
		public function getBucketSize():int { return bucketSize; }
		public function getMax():int { return max; }
		public function getMin():int { return min; }
		public function getCount():int { return count; }
		public function getSum():int { return sum; }
		public function getAvg():Number { return Number(sum)/Number(count); }
		public function getAvgStr():String { 
			// 2 digits after the point
			var res:int = int(Number(sum)/Number(count)*100); 
			return ""+(res/100); 
		}
		public function toString():String {
			return "avg="+getAvgStr()+" min="+min+" max="+max+" count="+count+" bucketSize="+bucketSize+" buckets="+buckets.join(", ");
		}
	}
}