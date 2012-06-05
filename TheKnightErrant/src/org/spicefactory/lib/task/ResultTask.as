package org.spicefactory.lib.task {
	
import flash.errors.IllegalOperationError;

/**
 * Abstract base class for asynchronous operations that produce a result.
 * This may be a loading operation or a remote service invocation.
 * 
 * <p>With the optional <code>propertyName</code> parameter of the constructor you 
 * can specify a property that will be set in the value of the data property.
 * Since the data property of any Task is recursive (if it wasn't set for a particular Task it uses the
 * value of its parent TaskGroup), you can use an object that was set as the data property
 * on a containing TaskGroup to collect values of different ResultTasks. This way you don't have
 * to keep references to all individual Tasks just to retrieve the result after the asynchronous
 * operation is finished.</p>
 * 
 * <p>In the following example a simple value object will be used to collect the loaded
 * text and XML of two loader tasks:</p>
 * 
 * <code><pre>
 * public class LoaderResult {
 * 
 *     public var text:String;
 *     public var xml:XML;
 *     
 * }
 * 
 * var group:TaskGroup = new SequentialTaskGroup();
 * group.data = new LoaderResult();
 * group.addTask(new TextLoaderTask("test.txt", "text"));
 * group.addTask(new XmlLoaderTask("test.xml", "xml"));
 * group.addEventListener(TaskEvent.COMPLETE, onComplete);
 * // error handling omitted
 * group.start();
 * 
 * private function onComplete (event:TaskEvent) : void {
 *     var t:Task = event.target as Task;
 *     var result:LoaderResult = t.data as LoaderResult;
 *     trace("loaded text: " result.text);
 *     trace("loaded XML: " result.xml);
 * }
 * </pre></code>
 * 
 * <p>Note that the two loader tasks of the above example (<code>TextLoaderTask</code> and
 * <code>XmlLoaderTask</code>) are not part of the Spicelib (yet). They are just used for
 * illustration purposes. This example only works if the constructor of these two classes
 * passes the second argument to the constructor of the superclass (<code>ResultTask</code>).
 * Instead of a concrete class like <code>LoaderResult</code> in the
 * example above you can also use a simple <code>Dictionary</code> as the data property.</p>
 * 
 * @author Jens Halm
 */
public class ResultTask extends Task {
	
	
	private var _result:*;
	private var _propertyName:String;
	
	
	/**
	 * Creates a new ResultTask instance. The optional <code>propertyName</code> parameter
	 * can be used to specify a property that will be set on the value of the data property
	 * of this Task or one of its parents.
	 */
	function ResultTask (propertyName:String = null) {
		_propertyName = propertyName;
	} 
	
	
	/**
	 * The result produced by this Task. If the Task has not completed yet,
	 * was cancelled or finished with an error this property is undefined.
	 */
	public function get result () : * {
		return _result;
	}

	/**
	 * @private
	 */
	public override function start() : Boolean {
		var originalResult:* = _result;
		handleResultValue(undefined);
		if (super.start()) {
			return true;
		} else {
			handleResultValue(originalResult);
			return false;
		}
	}

	
	/**
	 * Sets the result produced by this Task and signals that this Task has completed. 
	 * Subclasses should call this method
	 * when the asynchronous operation has completed. If this method executes successfully
	 * the <code>COMPLETE</code> event will be fired.
	 * 
	 * <p>This method should be used instead of the <code>complete</code> method from
	 * the Task superclass.</p>
	 * 
	 * @return true if the Task successfully switched its internal state, false if otherwise
	 */
	protected function setResult (result:*) : Boolean {
		handleResultValue(result);
		if (super.complete()) {
			return true;
		} else {
			handleResultValue(undefined);
			return false;
		}
	}
	
	
	private function handleResultValue (value:*) : void {
		_result = value;
		if (_propertyName != null) {
			var c:* = data;
			if (c != null) {
				c[_propertyName] = value;
			}
		}
	}

	/**
	 * @private
	 */
	protected override function complete () : Boolean {
		throw new IllegalOperationError("Use setResult() instead of complete() for ResultTasks");
	}
	
	
}

}
