package come2play_as3.api.auto_copied
{
	import flash.utils.getTimer;
	
/**
 * Important: a logger is never garbage-collected!!!
 * After you created a logger, it is put in a static array,
 * and when getTraces is called, all the traces from all the loggers
 * are combined into a single time-line.
 * 
 * IMPORTANT for AS2:
 * We use static Loggers:
 * static var LOG:Logger = new Logger(...)
 * Therefore, to prevent init cycles, the class Logger must not use any other class
 * (e.g., JSON or StaticFunctions!)
 * It creates crazy weird bugs in AS2 (but not in AS3)
 */ 
public final class Logger
{
	public static var TURN_OFF_ALL:Boolean = false;
	
	public static var ALL_LOGGERS:Array = [];
	public static var MAX_LOGGERS_NUM:int = 500;
		
	// Be careful that the traces will not grow too big to send to the java (limit of 1MB, enforced in Bytes2Object)
	public static var MAX_TRACES:Object = {};
	
	
	private var name:String;
	private var maxTraces:int;
	private var traces:Array/*LoggerLine*/ = [];
	public function Logger(name:String, maxTraces:int) {
		this.name = name;
		this.maxTraces = MAX_TRACES[name]!=null ? int(MAX_TRACES[name]) : maxTraces;
		ALL_LOGGERS.push(this);
		if (ALL_LOGGERS.length>MAX_LOGGERS_NUM) throw new Error("Passed MAX_LOGGERS_NUM! ALL_LOGGERS="+ALL_LOGGERS);
	}
	public function toString():String { return "Logger "+name; }
	
	public static var MAX_TRACE_LEN:int = 10000;	//10KB
	public static var MAX_HUGE_LEN:int 	= 500000;	//500KB
	
	// the game traces are a single huge traceline
	public function hugeLog(...args):void {
		limitedLog(MAX_HUGE_LEN,args);		
	}
	public function log(...args):void {
		limitedLog(MAX_TRACE_LEN,args);
	}
	public function limitedLog(maxTraceLen:int, obj:Object):void {
		if (TURN_OFF_ALL || maxTraces<=0) return;
			 
		var traceLine:LoggerLine = new LoggerLine(maxTraceLen,name,obj);
		limitedPush(traces, traceLine , maxTraces); // we discard old traces
	}
	public static function limitedPush(arr:Array, element:Object, maxSize:int):void {
		if (arr.length>=maxSize) arr.shift(); // we discard old elements (in a queue-like manner)
		arr.push(element);
	}	
	public function getMyTraces():Array/*LoggerLine*/ {
		return traces;
	}
}
}