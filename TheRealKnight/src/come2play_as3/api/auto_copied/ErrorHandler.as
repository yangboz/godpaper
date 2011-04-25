package come2play_as3.api.auto_copied
{
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
		
public final class ErrorHandler
{
	public function toString():String { // we put in the traces new ErrorHandler()
		return getOngoingTimers();
	}
	public static function getOngoingTimers():String {
		var res:Array = [];
		res.push("My stack traces:");	
		res.push( getStackTraces() );
		res.push("\n");
					
		res.push("My ongoingIntervals:");
		for each (var arr1:Array in ongoingIntervals) {
			res.push( "\t"+JSON.stringify(arr1) );
		}
		res.push("\n");
		res.push("My ongoingTimeouts:\n");
		for each (var arr2:Array in ongoingTimeouts) {
			res.push( "\t"+JSON.stringify(arr2) );
		}
		res.push("\n");		
		return res.join("\n");
	}
	public static function getStackTraces():String {
		return "\t"+my_stack_trace.join(",\n\t");
	}
	
	
	// returns the bug_id (or -1 if we already reported an error)
	private static var ErrorReport_LOG:Logger = new Logger("ErrorReport",10);	
	public static var SHOULD_SHOW_ERRORS:Boolean = false; // because in the game we do not want to show an error a msg.
	public static var SHOW_ERROR_FUNC:Function/*function(bug_id:int,errMessage:String):void*/ = null;
	public static var didReportError:Boolean = false; // we report only 1 error (usually 1 error leads to others)
	// If the container has a bug, then it adds the traces of the game, reports to ASP, and send to java. 
	// If the game has a bug, then it sends DoAllFoundHacker (which cause the container to send a bug report)  
	public static var SEND_BUG_REPORT:Function = null;
	public static function alwaysTraceAndSendReport(errStr:String, args:Object,userGeneratedBug:Boolean=false):int {
		ErrorReport_LOG.log([errStr, args]);
		if ((didReportError) && (!userGeneratedBug)) return -1;
		didReportError = true;
		
		AS3_GATracker.COME2PLAY_TRACKER.trackEvent("BugReports",StaticFunctions.getRevision(),errStr,getTimer());
		
		var bug_id:int = StaticFunctions.random(1, 10000000);	
		
		try {	
			var err:Error = new Error();
			var stackTraces:String = AS3_vs_AS2.myGetStackTrace(err); // null in the release version
			if (stackTraces!=null) ErrorReport_LOG.log(["Catching point stack trace=",err]);
							
			ErrorReport_LOG.log(["sendReport SEND_BUG_REPORT=",SEND_BUG_REPORT]);
			
			var errMessage:String = 
				(stackTraces==null ? "" : "AAAA (with stack trace) ")+ // so I will easily find them in our "errors page"
				"Revision="+StaticFunctions.getRevision()+": "+
				errStr;
			
			if (SEND_BUG_REPORT!=null)
				SEND_BUG_REPORT(bug_id, errMessage);	
				
			// we should show the error after we call sendMultipartImage (so we send the image without the error window)
			StaticFunctions.setClipboard(errMessage);
			if (SHOW_ERROR_FUNC!=null) {
				SHOW_ERROR_FUNC(bug_id,errMessage);
			} else {				
				if (SHOULD_SHOW_ERRORS) AS3_vs_AS2.showError(errMessage);
			}		
		} catch (err:Error) {
			AS3_vs_AS2.showError("!!!!!ERROR!!!! in sendReport:"+AS3_vs_AS2.error2String(err));
		}			
		return bug_id;
	}
	
	/**
	 * Error handling should be done in one central place.
	 * In flash however there is a lot of asynchronous code in:
	 *  setTimeout
	 *  setInterval
	 *  addEventListener and removeEventListener
	 *  and if you have code on keyframes.
	 * Use the methods here below instead of the AS3 version, because	 
	 * all these methods should be wrapped with catch clauses.
	 * 
	 * If your code has try&catch, then in the catch use handleError.
	 * 
	 */ 
	private static var ongoingIntervals:Dictionary = new Dictionary();//also printed in traces
	private static var ongoingTimeouts:Dictionary = new Dictionary();//also printed in traces	
	public static function myTimeout(zoneName:String, func:Function, milliseconds:int):Object {
		var timeout_id:Object;
		var newFunc:Function = 
				function (...args):void { 
					modifyOngoing(false, true, zoneName, timeout_id, "myTimeout ticked",milliseconds);
					func.apply(null,args);
				};
		timeout_id = AS3_vs_AS2.unwrappedSetTimeout(zoneName, newFunc, milliseconds);
		modifyOngoing(true, true, zoneName, timeout_id, "myTimeout set", milliseconds);
		return timeout_id;			
	}
	public static function myInterval(zoneName:String, func:Function, milliseconds:int):Object {
		var interval_id:Object = AS3_vs_AS2.unwrappedSetInterval(zoneName, func, milliseconds);
		modifyOngoing(true, false, zoneName, interval_id, "myInterval set", milliseconds);
		return interval_id;		
	}
	public static function myClearTimeout(zoneName:String, id:Object):void {
		modifyOngoing(false, true, zoneName, id, "myTimeout cleared", -1);
		AS3_vs_AS2.unwrappedClearTimeout(zoneName, id);			
	}
	public static function myClearInterval(zoneName:String, id:Object):void {
		modifyOngoing(false, false, zoneName, id, "myInterval cleared", -1);
		AS3_vs_AS2.unwrappedClearInterval(zoneName, id);			
	}		
	private static var LOG:Logger = new Logger("myTimeouts",10);
	private static function modifyOngoing(isAdd:Boolean, isTimeout:Boolean, zoneName:String, id:Object, reason:String, milliseconds:int):void {
		var arr:Object = isTimeout ? ongoingTimeouts : ongoingIntervals;
		if (isAdd) {
			StaticFunctions.assert(arr[id]==null, "Internal error! already added id=",[id]);
			arr[id] = [zoneName, milliseconds];
		} else {
			var info:Array = arr[id];
			StaticFunctions.assert(info!=null && info[0]==zoneName, "there is no such zoneName!",["reason=",reason, " zoneName=",zoneName," info=", info]);
			milliseconds = info[1];
			delete arr[id];
		}			
		LOG.log([reason, zoneName, id, milliseconds]);
	}
				
	/**
	 * Flash freezing:
	 * Sometimes flash freezes for a long time.
	 * We discovered it usually happens when the flash is not in focus, 
	 * and it freezes usually for 20-60 seconds.
	 * 
	 * We discovered everyone can do it by pressing on the "X" close symbol on the browser, and not releasing,
	 * then finally releasing outside the "X" area (thus not closing the window).
	 * Another way to freeze the flash is calling a javascript with an "alert" (or a popup blocker that displays some message).
	 * Maybe there are other ways to freeze the flash... (I suspect that an overloaded computer or long garbage-collection cycle might also cause it)
	 * 
	 * When the flash freezes, there are unpredictable errors in different places, 
	 * e.g., disconnecting from java, transaction that took too long, an entry that stayed too long in AS3_TimedMap, long round trip times, etc.
	 * Therefore, we decided to immediately report this error, when we see that the flash "froze",
	 * and it's easiest to detect it in the entry point of all our functions: 
	 * 	in catchErrors
	 * We make sure that logMemoryInterval ticks every 5 seconds, and MAX_FREEZE_TIME_MILLI is more than twice that number.
	 */
	public static function startLogMemoryInterval():void {
		myInterval("logMemoryInterval",AS3_vs_AS2.logMemory,MEM_INTERVAL_MILLI);
		LAST_CATCH_ERRORS_ON = getTimer();
	}
	public static var IGNORE_FREEZE_BUG:Boolean = false;
	public static var FREEZE_CALLBACK:Function/*function (deltaMilli:int):void*/ = null; 
	public static var MEM_INTERVAL_MILLI:int = 5*1000; //5 secs
	public static var FREEZING_BUCKETS_MILLI:int = 10*1000; // must be more than 2*MEM_INTERVAL_MILLI 
	private static var FREEZE_COUNT:int = 0;
	public static var LAST_FROZE_ON:int = 0; 
	// see also ServerConnection.MAX_FREEZE_MILLI_AFTER_JAVA_CONNECT
	public static var MAX_FREEZE_TIME_MILLI:int = 70*1000; // 70 seconds of freezing might even be too much!
	public static var IGNORE_FREEZE_LONGER_THAN:int = 5*60*1000; // more than 5 minutes freeze is probably because the computer went into sleep mode.
	
	public static var LAST_CATCH_ERRORS_ON:int = -1; 
	
	private static var my_stack_trace:Array = [];
	public static function wrapWithCatch(zoneName:String, func:Function):Function {
		var longerName:String = zoneName; //Extra stack traces are not needed because we use zoneName for all events:  +(my_stack_trace.length==0 ? "" : " with first stacktrace: {\n"+my_stack_trace[0]+"\n}");
		return function (...args):void { 
			catchErrors(longerName,func,args);
		};
	}
	public static var DO_AFTER_CATCH:Function = null;
	public static var ZONE_LOGGER_SIZE:int = 6;
	public static var ANALYTICS_COUNT_MAX:int = 3;
	public static var ANALYTICS_BUCKET_MAX:int = 6;
	private static var ZONE_LOGGERS:Object/*String->Logger*/ = {};
	private static var Freeze_LOG:Logger = new Logger("FreezeLog",10);	
	public static function catchErrors(zoneName:String, func:Function, args:Array):Object {
		Profiler.started("catchErrors");
		
		var res:Object = null;		
		
		var toInsert:Object = [zoneName,"t:",getTimer(),"args=",args]; // I couldn't find a way to get the function name (describeType(func) only returns that the method is a closure)
		my_stack_trace.push(toInsert);
		var indentLevel:int = my_stack_trace.length;
		var logger:Logger = ZONE_LOGGERS[zoneName];
		if (logger==null) {
			logger = new Logger("CATCH-"+zoneName,ZONE_LOGGER_SIZE);
			ZONE_LOGGERS[zoneName] = logger;
		}
		logger.log("ENTERED");
		LoggerLine.LINE_INDENT = indentLevel;
		
		if (LAST_CATCH_ERRORS_ON>=0) {
			var now:int = getTimer();
			var lastCatch:int = LAST_CATCH_ERRORS_ON;
			LAST_CATCH_ERRORS_ON = now; // I assign before alwaysTraceAndSendReport to prevent recursive calls.
			var delta:int = now - lastCatch;
			if (delta > FREEZING_BUCKETS_MILLI) {
				// gather freezing statistics
				FREEZE_COUNT++;
				Freeze_LOG.log("Flash Freeze no. ",FREEZE_COUNT," for ",int(delta/1000)," seconds");
				LAST_FROZE_ON = now;
				if (FREEZE_COUNT<=10) {
					var bucket:int = Math.min(ANALYTICS_BUCKET_MAX, delta/FREEZING_BUCKETS_MILLI);
					var countStr:String = FREEZE_COUNT>=ANALYTICS_COUNT_MAX ? ""+ANALYTICS_COUNT_MAX+"+" : ""+FREEZE_COUNT;
					AS3_GATracker.trackWarning("Flash froze", "Flash Freeze no. "+countStr+" for "+(bucket*10)+
							(bucket==ANALYTICS_BUCKET_MAX ? "+" : "")+
							" seconds",now);
				}
								
				if (FREEZE_CALLBACK!=null) FREEZE_CALLBACK(delta);
				
				if (delta > MAX_FREEZE_TIME_MILLI) {
					// the flash froze!
					if (delta<IGNORE_FREEZE_LONGER_THAN) {
						// regular freeze
						if(!IGNORE_FREEZE_BUG)	alwaysTraceAndSendReport("The flash froze!", ["LAST_CATCH_ERRORS_ON=",lastCatch," now=",now]);
					} else {
						// the computer probably went into sleep mode
						didReportError = true; 	
					}
				}
			}
		}
		
		var wasError:Boolean = false;			
		try {		
			res = Profiler.measure(zoneName, func, args); 
		} catch (err:Error) { handleError(err, args); }
		// some actions need to be done after all other actions complete (e.g., sending messages to java)
		try {
			if (DO_AFTER_CATCH!=null && indentLevel==1) {
				Profiler.measure("DoAfterCatch",DO_AFTER_CATCH,[]);
				//DO_AFTER_CATCH();				
			} 	
		} catch (err:Error) { handleError(err, args); }
		LoggerLine.LINE_INDENT = indentLevel-1;
		logger.log("EXITED");
			
		var poped:Object = my_stack_trace.pop(); 
			// I tried to do the pop inside a "finally" clause (to handle correctly cases with exceptions), 
			//but I got "undefined" errors:
			//		undefined
			//			at come2play_as3.util::General$/stackTrace()
			//			at come2play_as3.util::General$/catchErrors() 
		if (!didReportError && toInsert!=poped) 
			alwaysTraceAndSendReport("BAD stack behaviour (multithreaded flash?)", ["my_stack_trace=",my_stack_trace, "toInsert=",toInsert, "poped=",poped]);
			
		Profiler.ended("catchErrors");
		return res;				
	}
	public static function handleError(err:Error, obj:Object):void {
		alwaysTraceAndSendReport("handleError: "+AS3_vs_AS2.error2String(err),[" catching-arguments=",obj]);
	}		
}
}