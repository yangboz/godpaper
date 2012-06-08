package com.godpaper.as3.utils
{
	import flash.utils.getQualifiedClassName;
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.logging.targets.TraceTarget;
	
	/**
	 * Use a simple utility method to retrieve the logger
	 * for a particular class, instead of passing
	 * in the qualified class name as a string.
	 *
	 * just like:(Declare Loggers as Static Constants)
	 * private static const LOG:ILogger = LogUtil.getLogger(MyClass);
	 *
	 * Format Log Statements Consistently:
	 * LOG.error("Something bad has happened: event={0}, message={1}", event.type, message);
	 *
	 * Parameterize Log Statements:
	 * LOG.error("Something bad has happened: event={0}, message={1}", event.type, message);
	 *
	 * Use Log Levels to Indicate Severity:
	 * LOG.error("The service has failed and no data is available.");
	 *
	 * Use Log Filters for Focus:
	 * target.filters = [ "my.important.package.MyClass" ];
	 * target.level = LogEventLevel.INFO;
	 *
	 * Include Categories to Show Class Names:
	 * target.includeCategory = true;
	 *
	 * More references:
	 * http://blogs.adobe.com/tomsugden/2009/08/
	 *
	 * @author Knight.zhou
	 */
	public class LogUtil {
		
		//Variables(should be only one instance!)
		private static var _traceTarget:TraceTarget = new TraceTarget();
		/**
		 * With the utility method approach,
		 * the class name can be refactored
		 * without needing to edit the string.
		 * Here is an implementation for the LogUtil.getLogger() method:
		 *
		 * @param class category
		 * @return ILogger
		 *
		 */
		public static function getLogger(c:Class):ILogger {
			var className:String =getQualifiedClassName(c).replace("::", ".");
			//Customize the Log
			_traceTarget.includeLevel = true;
//			_traceTarget.includeDate = true;
			_traceTarget.includeCategory = true;
			_traceTarget.includeTime = true;
			_traceTarget.includeMemory = true;
			_traceTarget.fieldSeparator = "->";
//			_traceTarget.filters = ["com.godpaper.starling.views.scenes.GameScene"];
			Log.addTarget(_traceTarget);
			//
			return Log.getLogger(className);
		}
	}
}