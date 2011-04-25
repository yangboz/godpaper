package come2play_as3.api.auto_copied
{
	import flash.utils.getTimer;
	
public final class TimeMeasure
{
	private var happenedOn:int = -1;
	// I added happenedOnDate to check how accurate getTimer is (compared to new Date)
	// because I had weird jumps (around 30 seconds), that cannot be explained...
	// Now we understand that the flash simply freezes sometimes (but getTimer is very accurate
	///*<InAS3>*/private var happenedOnDate:Date = null;/*</InAS3>*/
	
	public function setTime():void {
		happenedOn = getTimer();
		///*<InAS3>*/happenedOnDate = new Date();/*</InAS3>*/
	}
	public function isTimeSet():Boolean {
		return happenedOn!=-1;
	}
	public function clearTime():void {
		happenedOn = -1;
		///*<InAS3>*/happenedOnDate = null;/*</InAS3>*/		
	}
	public function milliPassed():int {
		StaticFunctions.assert(happenedOn!=-1,"TimeMeasure: happenedOn was not set!", [this]);
		return getTimer()-happenedOn;
	}
	public function havePassed(milli:int):Boolean {
		return milli<=milliPassed();		
	}
	public function toString():String {
		return "[TimeMeasure: happenedOn="+happenedOn+" now="+getTimer()+
			///*<InAS3>*/" happenedOnDate="+happenedOnDate+" nowDate="+(new Date())+/*</InAS3>*/
			"]";
	}
}
}