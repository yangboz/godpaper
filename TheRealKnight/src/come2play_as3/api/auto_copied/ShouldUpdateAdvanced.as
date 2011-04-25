package come2play_as3.api.auto_copied
{	
	public final class ShouldUpdateAdvanced extends ShouldUpdate
	{
		private var freeCount:int;
	    private var currCount:int;
	
	    public function ShouldUpdateAdvanced(everySeconds:int, freeCount:int) {
	        super(1000*everySeconds, false);
	        this.freeCount = freeCount;
	    }
	    override public function shouldUpdate():Boolean {
	        if (super.shouldUpdate()) {
	            currCount = 1;
	            return true;
	        } else {
	            return ++currCount<=freeCount;
	        }
	    }
	}
}