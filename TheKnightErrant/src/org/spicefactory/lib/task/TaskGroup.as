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
 
package org.spicefactory.lib.task {
import com.godpaper.as3.utils.LogUtil;

import flash.errors.IllegalOperationError;
import flash.events.ErrorEvent;

import mx.logging.ILogger;

import org.spicefactory.lib.errors.IllegalStateError;
import org.spicefactory.lib.task.enum.TaskState;
import org.spicefactory.lib.util.collection.ArrayList;
import org.spicefactory.lib.util.collection.List;

/**
 * Abstract base class for <code>SequentialTaskGroup</code> and <code>ConcurrentTaskGroup</code>.
 * Manages multiple child tasks and is itself a subclass of Task (Composite Design Pattern)
 * so that it can be nested within other TaskGroups.
 * 
 * @author Jens Halm
 */
public class TaskGroup extends Task {
		
	/**
	 * @private
	 */
	protected var allTasks : List;
	
	/**
	 * @private
	 */
	protected var activeTasks : List;
	
	private var _autoStart : Boolean;
	private var _ignoreChildErrors : Boolean;
	
	// if we operate on the tasks of this group in a way that those tasks throw events
	// application code should NOT be able to alter the state of this group in their event handlers
	// since this would lead to unmanagable recursions and conflicting inner state changes
	private var locked:Boolean;
	
	private var _pendingCancelation:Boolean;
	
	
	private static var logger:ILogger;
	
	
	/**
	 * @private
	 */
	public function TaskGroup () {
		super();
		if (Object(this).constructor == TaskGroup) {
			throw new IllegalOperationError("TaskGroup is abstract");
		}
		if (logger == null) {
//			logger = LogUtil.getLogger("org.spicefactory.lib.task.TaskGroup");
			logger = LogUtil.getLogger(TaskGroup);
		}
		allTasks = new ArrayList();
		activeTasks = new ArrayList();
		_ignoreChildErrors = false;
		_autoStart = false;
		locked = false;
		_pendingCancelation = false;
	}

	/**
	 * @private
	 */
	public override function get cancelable () : Boolean {
		if (!super.cancelable) return false;
		for (var i : Number = 0; i < allTasks.getSize(); i++) {
			var t : Task = Task(allTasks.get(i));
			if (!t.cancelable) return false;
		}
		return true;
	}

	/**
	 * @private
	 */	
	public override function get restartable () : Boolean {
		if (!super.restartable) return false;
		for (var i : Number = 0; i < allTasks.getSize(); i++) {
			var t : Task = Task(allTasks.get(i));
			if (!t.restartable) return false;
		}
		return true;
	}

	/**
	 * @private
	 */	
	public override function get suspendable () : Boolean {
		if (!super.suspendable) return false;
		for (var i : Number = 0; i < allTasks.getSize(); i++) {
			var t : Task = Task(allTasks.get(i));
			if (!t.suspendable) return false;
		}
		return true;
	}
	
	/**
	 * @private
	 */	
	public override function get skippable () : Boolean {
		if (!super.skippable) return false;
		for (var i : Number = 0; i < allTasks.getSize(); i++) {
			var t : Task = Task(allTasks.get(i));
			if (!t.skippable) return false;
		}
		return true;
	}
	
	/**
	 * @private
	 */
	internal function get pendingCancelation () : Boolean {
		return _pendingCancelation;
	}

	/**
	 * Indicates whether this <code>TaskGroup</code> starts automatically when
	 * the first child is added. This option may be useful for queueing tasks that 
	 * must not run concurrently but should be executed as soon as possible.
	 */
	public function get autoStart () : Boolean {
		return _autoStart;
	}
	
	public function set autoStart (autoStart : Boolean) : void {
		_autoStart = autoStart;
		if (_autoStart && state == TaskState.INACTIVE && !allTasks.isEmpty()) {
			start();
		}
	}
	
	/**
	 * Indicates whether <code>ERROR</code> events of child tasks should be ignored or if they 
	 * should stop the whole group.
	 * 
	 */
	public function get ignoreChildErrors () : Boolean {
		return _ignoreChildErrors;
	}
	
	public function set ignoreChildErrors (ignore : Boolean) : void {
		_ignoreChildErrors = ignore;
	}
	
	
	public function set timeout (value:uint) : void {
		setTimeout(value);
	}
	
	
	/**
	 * Adds the specified task to this TaskGroup.
	 * 
	 * @param task the Task to be added to this TaskGroup
	 * @return true if the Task was successfully added to this TaskGroup
	 */
	public function addTask (task : Task) : Boolean {
		logger.debug("Adding task: " + task);
		if (task.state == TaskState.FINISHED) {
			logger.warn("Attempt to add Task '" + task + "' to a TaskGroup which is not restartable");
			return false;
		}
		if (task.state != TaskState.INACTIVE) {
			logger.error("Attempt to add an already active Task '" + task + "' to a TaskGroup");
			return false;
		} 
		if (task.parent != null) {
			logger.error("Cannot add Task '" + task + "': Task is already member of another TaskGroup");
			return false;
		}
		task.setParent(this);
		allTasks.append(task);
		handleAddedTask(task);
		if (autoStart && state == TaskState.INACTIVE) {
			start();
		}
		return true;
	}
	
	/**
	 * Removes the specified task from this TaskGroup.
	 * 
	 * @param task the Task to be removed from this TaskGroup
	 * @return false if the Task was successfully removed from this TaskGroup
	 */
	public function removeTask (task : Task) : Boolean {
		var wasActive : Boolean = removeActiveTask(task);
		var index : Number = allTasks.indexOf(task);
		if (!allTasks.remove(task)) {
			return false;
		}
		task.setParent(null);
		handleRemovedTask(task, index);
		if (wasActive && (state == TaskState.ACTIVE || state == TaskState.SUSPENDED)) {
			handleTaskComplete(task);
		}
		return true;
	}
	
	/**
	 * Removes all tasks from this TaskGroup.
	 */
	public function removeAllTasks () : void {
		for (var i:uint = 0; i < allTasks.getSize(); i++) {
			var t:Task = Task(allTasks.get(i));
			t.setParent(null);
		}
		allTasks.removeAll();
		activeTasks.removeAll();
		if (state == TaskState.ACTIVE || state == TaskState.SUSPENDED) {
			handleRemoveAll();
			if (state == TaskState.ACTIVE) complete();
		}		
	}
	
	/**
	 * Method hook for subclasses that gets called when a child Task was added to this TaskGroup.
	 * 
	 * @param task the Task that was added to this TaskGroup
	 */
	protected function handleAddedTask (t : Task) : void {
		/* template method */
	}

	/**
	 * Method hook for subclasses that gets called when a child Task was removed from this TaskGroup.
	 * 
	 * @param task the Task that was removed from this TaskGroup
	 * @param index the zero-based index of the removed Task
	 */	
	protected function handleRemovedTask (task : Task, index : uint) : void {
		/* template method */
	}
	
	/**
	 * Method hook for subclasses that gets called when all child tasks have been removed from
	 * this TaskGroup.
	 */
	protected function handleRemoveAll () : void {
		/* template method */
	}
	
	/**
	 * The number of tasks added to this TaskGroup.
	 */
	public function get size () : uint {
		return allTasks.getSize();
	}
	
	/**
	 * Returns the Task at the specified index.
	 * 
	 * @param index the zero-based index of the Task to return.
	 * @return the Task at the specified index
	 */
	public function getTask (index : uint) : Task {
		return Task(allTasks.get(index));
	}
	
	// start, cancel, suspend, resume
	private function handleTaskError (t : Task, action : String) : void {
		logger.error("Unable to " + action + " Task '" + t + "': Task will be removed from this TaskGroup");
		removeTask(t);
	}
	
	private function swallowError (event:ErrorEvent) : void {
		/* just need to listen to avoid error popups for children without listeners */
	}
	
	/**
	 * Starts the specified child Task.
	 * 
	 * @param task the Task that should be started
	 */
	protected function startTask (task : Task) : void {
		if (!activeTasks.contains(task)) activeTasks.append(task);
		task.addEventListener(ErrorEvent.ERROR, swallowError, false, 0, true);
		if (!task.startInternal()) {
			handleTaskError(task, "start");
		}
	}

	/**
	 * @private
	 */	
	internal function completeChild (t:Task, skip:Boolean) : void {
		checkLock();
		if (!removeActiveTask(t)) {
			logger.error("Task '" + t + "' threw COMPLETE event but was not active in this TaskGroup");
			return;
		}
		if (state != TaskState.ACTIVE) {
			logger.error("Task '" + t + "' threw COMPLETE event while TaskGroup was in illegal state: " + state);
			return;
		}
		if (skip) {
			runProtected(t.fireSkipEvent);
		} else {
			runProtected(t.fireCompleteEvent);
		}
		handleTaskComplete(t);
		if (autoStart || !t.restartable) removeTask(t);
	}

	/**
	 * @private
	 */	
	internal function cancelChild (t:Task) : void {
		checkLock();
		if (!removeActiveTask(t)) {
			logger.error("Task '" + t + "' threw CANCEL event but was not active in this TaskGroup");
			return;
		}
		if (state != TaskState.ACTIVE && state != TaskState.SUSPENDED) {
			logger.error("Task '" + t + "' threw CANCEL event while TaskGroup was in illegal state: " + state);
			return;
		}
		runProtected(t.fireCancelEvent);
		handleTaskComplete(t);
		if (autoStart || !t.restartable) removeTask(t);
	}

	/**
	 * @private
	 */	
	internal function errorChild (t:Task, message:String) : void {
		checkLock();
		if (!removeActiveTask(t, true)) {
			logger.error("Task '" + t + "' threw ERROR event but was not active in this TaskGroup");
			return;
		}
		if (state != TaskState.ACTIVE) {
			logger.error("Task '" + t + "' threw ERROR event while TaskGroup was in illegal state: " + state);
			t.removeEventListener(ErrorEvent.ERROR, swallowError);
			return;
		}
		runProtected(t.fireErrorEvent, [message]);
		t.removeEventListener(ErrorEvent.ERROR, swallowError);
		if (ignoreChildErrors) {
			handleTaskComplete(t);
		} else {
			error(message);
		}
		if (autoStart || !t.restartable) removeTask(t);
	}
	
	private function removeActiveTask (t : Task, keepListener:Boolean = false) : Boolean {
		if (!activeTasks.remove(t)) return false;
		if (!keepListener) t.removeEventListener(ErrorEvent.ERROR, swallowError);
		return true;
	}	
	
	
	private function runProtected (method:Function, params:Array = null) : void {
		locked = true;
		try {
			method.apply(null, params);
		} catch (e:Error) {
			/* swallow, we must continue even if some event listener threw an Error */
		}
		locked = false;
	}
		
	
	/**
	 * Method hook for subclasses that gets called when a child Task has completed its operation.
	 * 
	 * @param task the Task that has completed its operation
	 */
	protected function handleTaskComplete (task : Task) : void {
		/* default implementation does nothing */ 
	}
	
	private function checkLock () : void {
		if (locked) {
			var message:String = "You cannot alter the state of a TaskGroup or a sibling Task " 
					+ " in an event handler of one of its children";
			logger.error(message);
			throw new IllegalStateError(message);
		}
	}
	
	/**
	 * @private
	 */
	public override function suspend () : Boolean {
		checkLock();
		return super.suspend();
	}
	
	/**
	 * @private
	 */
	public override function resume () : Boolean {
		checkLock();
		return super.resume();
	}

	/**
	 * @private
	 */	
	public override function cancel () : Boolean {
		checkLock();
		return super.cancel();
	}
	
	/**
	 * @private
	 */
	public override function skip () : Boolean {
		checkLock();
		return super.skip();
	}
	
	/**
	 * @private
	 */
	protected override function doSuspend () : void {
		locked = true;
		try {
			for (var i:Number = 0; i < activeTasks.getSize(); i++) {
				var t:Task = Task(activeTasks.get(i));
				if (t.state != TaskState.SUSPENDED && !t.suspend()) {
					handleTaskError(t, "suspend");
				}
			}
		} finally {
			locked = false;
		}
	}
	
	/**
	 * @private
	 */
	protected override function doResume () : void {
		if (activeTasks.isEmpty()) {
			// Some active tasks were removed while TaskGroup was suspended
			complete();
			return;
		}
		locked = true;
		try {
			for (var i:Number = 0; i < activeTasks.getSize(); i++) {
				var t:Task = Task(activeTasks.get(i));
				if (t.state == TaskState.INACTIVE) {
					// Task was added to TaskGroup while TaskGroup was suspended
					startTask(t);
				} else if (!t.resume()) {
					handleTaskError(t, "resume");
				}
			}
		} finally {
			locked = false;
		}
	}
	
	/**
	 * @private
	 */
	protected override function doCancel () : void {
		locked = true;
		_pendingCancelation = true;
		try {
			for (var i:Number = 0; i < activeTasks.getSize(); i++) {
				var t:Task = Task(activeTasks.get(i));
				if (!t.cancel()) {
					handleTaskError(t, "cancel");
				}
			}
		} finally {
			locked = false;
			_pendingCancelation = false;
			activeTasks.removeAll();
		}
	}
	
	/**
	 * @private
	 */
	protected override function doSkip () : void {
		locked = true;
		_pendingCancelation = true;
		try {
			for (var i:Number = 0; i < activeTasks.getSize(); i++) {
				var t:Task = Task(activeTasks.get(i));
				if (!t.skip()) {
					handleTaskError(t, "finish");
				}
			}
		} finally {
			locked = false;
			_pendingCancelation = false;
			activeTasks.removeAll();
		}
	}
	
	/**
	 * @private
	 */
	protected override function doError (message:String) : void {
		doCancel();
	}	
	
	/**
	 * @private
	 */
	protected override function doTimeout () : void {
		doCancel();
	}	
		
		
}
	
}