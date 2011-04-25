package come2play_as3.api.auto_copied
{	
	public final class MyInterval 
	{
		private var timeout_id:Object = null;
		public var name:String;
		public function MyInterval(name:String)	{
			this.name = name;
		}
		public function toString():String {
			return name;
		}
		public function start(func:Function, milliseconds:int):void {
			clear();
			timeout_id = ErrorHandler.myInterval(name, func, milliseconds);
		}
		public function clear():void {
			if (timeout_id!=null) {
				ErrorHandler.myClearInterval(name, timeout_id);
				timeout_id = null;
			}	
		}
	}
}