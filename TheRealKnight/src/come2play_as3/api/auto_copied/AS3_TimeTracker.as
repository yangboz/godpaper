package come2play_as3.api.auto_copied
{
	import come2play_as3.api.auto_copied.AS3_GATracker;
	
	public class AS3_TimeTracker
	{
		private var buckets:Array;
		private var catagoryNamePrefix:String;
		public function AS3_TimeTracker(catagoryNamePrefix:String,buckets:Array=null)
		{
			this.buckets = buckets!=null?buckets:[100,200,300,400,500,1000,1500,2000,2500,5000,10000];
			this.catagoryNamePrefix = catagoryNamePrefix;	
		}
		
		public function track(timeInMiliSeconds:int,action:String = "default"):void{
			var lastBucket:int = 0;
			for each(var testTime:int in buckets){
				if(timeInMiliSeconds < testTime)	break;
				lastBucket = testTime 
			}	
			var buketName:String = lastBucket == testTime?testTime+"+":lastBucket+" - "+(testTime-1);
			AS3_GATracker.COME2PLAY_TRACKER.trackEvent(catagoryNamePrefix+" TimeTacker",action,"Bucket : "+buketName,timeInMiliSeconds);
		}

	}
}