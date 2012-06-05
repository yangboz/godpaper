/*
 * Copyright 2007 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
 
package org.spicefactory.lib.task.util {

import org.spicefactory.lib.task.Task;

/**
 * A Task implementation that delegates the actual execution of the operation.
 * This may be useful if you want to integrate existing classes that cannot be retrofitted
 * to be subclasses of <code>Task</code>, but need to act as children of a <code>TaskGroup</code>.
 * 
 * @author Jens Halm
 */
public class DelegateTask extends Task {
		
	
	private var startFunction:Function;
	private var cancelFunction:Function;
	private var skipFunction:Function;
	private var suspendFunction:Function;
	private var resumeFunction:Function;
	
	
	/**
	 * Creates a new instance. The properties <code>cancelable</code>, <code>suspendable</code>
	 * and <code>finishable</code> will initially be set to <code>false</code> until
	 * you set one of the corresponding delegate functions (like <code>setCancelFunction</code>).
	 * 
	 * @param startFunction the function that gets executed when the Task is started
	 * @param name an optioanal name for log output
	 * @param isRestartable whether this DelegateTask is restartable
	 * @param timeout an optional timeout in milliseconds
	 */
	public function DelegateTask (startFunction:Function, name:String = null, 
			isRestartable : Boolean = true, timeout : uint = 0) {
		super();
		if (name != null) setName(name);
		this.startFunction = startFunction;
		setRestartable(isRestartable);
		setCancelable(false);
		setSuspendable(false);
		setSkippable(false);
		setTimeout(timeout);
	}
	
	/**
	 * Instruct the DelegateTask to execute the specified Function when it gets cancelled.
	 * This method will automatically set the <code>cancelable</code> property to true.
	 * 
	 * @param cancelFunction the Function to execute when this Task gets cancelled
	 */
	public function setCancelFunction (cancelFunction:Function) : void {
		this.cancelFunction = cancelFunction;
		setCancelable(true);
	}

	/**
	 * Instruct the DelegateTask to execute the specified Function when its <code>finish</code>
	 * method gets executed.
	 * This method will automatically set the <code>skippable</code> property to true.
	 * 
	 * @param skipFunction the Function to execute when the <code>skip</code>
	 * method of this Task gets executed
	 */	
	public function setSkipFunction (skipFunction:Function) : void {
		this.skipFunction = skipFunction;
		setSkippable(true);
	}
	
	/**
	 * Instruct the DelegateTask to execute the specified Functions when it gets suspended
	 * and resumed.
	 * This method will automatically set the <code>suspendable</code> property to true.
	 * 
	 * @param suspendFunction the Function to execute when this Task is suspended
	 * @param resumeFunction the Function to execute when this Task is resumed
	 */
	public function setSupendFunctions (suspendFunction:Function, resumeFunction:Function) : void {
		this.suspendFunction = suspendFunction;
		this.resumeFunction = resumeFunction;
		setSuspendable(true);
	}

	/**
	 * @private
	 */
	protected override function doStart () : void {
		if (startFunction != null) {
			startFunction(this);
		}		
	}
	
	/**
	 * @private
	 */
	protected override function doCancel () : void {
		if (cancelFunction != null) {
			cancelFunction(this);
		}		
	}
	
	/**
	 * @private
	 */
	protected override function doSkip () : void {
		if (skipFunction != null) {
			skipFunction(this);
		}		
	}
	
	/**
	 * Signals that this Task has completed. 
	 * If this method executes successfully
	 * the <code>COMPLETE</code> event will be fired.
	 * 
	 * @return true if the Task successfully switched its internal state, false if otherwise
	 */
	public function markComplete () : Boolean {
		return complete();
	}

	/**
	 * Signals an error condition and cancels the Task.
     * If this method executes successfully the <code>ERROR</code> event will be fired.
     * 
     * @param message the error description
	 * @return true if the Task successfully switched its internal state, false if otherwise
	 */	
	public function markError (message:String) : Boolean {
		return error(message);
	}		
		
}
	
}