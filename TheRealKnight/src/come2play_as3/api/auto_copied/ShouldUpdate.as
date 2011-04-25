package come2play_as3.api.auto_copied
{	
	public class ShouldUpdate
	{
	    private var updatedOn:TimeMeasure = new TimeMeasure();
	    private var everyMilliSec:int;
		public function ShouldUpdate(milli:int, doNow:Boolean) {
	        everyMilliSec = milli;
	        if (!doNow) updatedOn.setTime();
	    }
	    public function toString():String {
	        return "ShouldUpdate updatedOn="+ (updatedOn)+" everyMilliSec="+everyMilliSec;
	    }	
	    public function shouldUpdate():Boolean {
	        if (!havePassed(everyMilliSec)) return false;
	        updatedOn.setTime();
	        return true;
	    }
	    public function havePassed(milli:int):Boolean {
	        return updatedOn.havePassed(milli);
	    }
	}
}