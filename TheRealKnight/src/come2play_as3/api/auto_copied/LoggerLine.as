package come2play_as3.api.auto_copied
{
	import flash.utils.getTimer;
	
	public final class LoggerLine
	{
		private static var CURR_TRACE_ID:int = 0;
		public static var LINE_INDENT:int = 0;
		
		public var maxLen:int;
		public var traceId:int;
		public var traceTime:int;
		public var loggerName:String;
		public var obj:Object;
		public var indent:int;
		
		public function LoggerLine(maxLen:int, loggerName:String,obj:Object) {
			traceId = ++CURR_TRACE_ID;
			traceTime = getTimer();
			indent = LINE_INDENT;
			this.maxLen = maxLen;
			this.loggerName = loggerName;
			this.obj = obj;
		}
	}
}