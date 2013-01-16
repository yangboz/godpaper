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

import mx.logging.ILogger;

import org.spicefactory.lib.task.TaskGroup;
import org.spicefactory.lib.task.enum.TaskState;

/**
 * A TaskGroup implementation that executes its child Tasks sequentially.
 * When the last child Task has completed its operation this TaskGroup will fire its
 * <code>COMPLETE</code> event. If the TaskGroup gets cancelled or suspended the currently active child
 * task will also be cancelled or suspended in turn.
 * If a child Task throws an <code>ERROR</code> event and the <code>ignoreChildErrors</code> property
 * of this TaskGroup is set to false, then the TaskGroup will fire an <code>ERROR</code> event
 * and will not execute its remaining child tasks.
 * If the <code>autoStart</code> property of this TaskGroup is set to true, the TaskGroup
 * will automatically be started if a child task gets added to an empty chain.
 * 
 * @author Jens Halm
 */	
public class SequentialTaskGroup extends TaskGroup {
		
	private var currentIndex : Number;
	
	private static var logger:ILogger;
	

	/**
	 * Creates a new TaskGroup.
	 * 
	 * @param name an optional name for log output
	 */	
	public function SequentialTaskGroup (name:String = null) {
		super();
		if (logger == null) {
//			logger = LogContext.getLogger("org.spicefactory.lib.task.SequentialTaskGroup");
			logger = LogUtil.getLogger(SequentialTaskGroup);
		}
		setName((name == null) ? "[SequentialTaskGroup]" : name);
	}
	
	/**
	 * @private
	 */
	protected override function handleRemovedTask (t : Task, index : uint) : void {
		if (index <= currentIndex) currentIndex--;
	}
	
	/**
	 * @private
	 */
	protected override function handleRemoveAll () : void {
		currentIndex = 0;
	}
	
	/**
	 * @private
	 */
	protected override function doStart () : void {
		currentIndex = 0;
		nextTask();
	}
	
	/**
	 * @private
	 */
	protected override function handleTaskComplete (t:Task) : void {
		currentIndex++;
		if (state == TaskState.ACTIVE) {
			// Chain is already active so we must start the next task immediately
			nextTask();
		} else if (state == TaskState.SUSPENDED && allTasks.getSize() > currentIndex) {
			// Add the new task to the activeTasks List so it will be started when resuming the TaskGroup
			activeTasks.append(allTasks.get(currentIndex));
		}
	}
	
	private function nextTask () : void {
		if (allTasks.getSize() == currentIndex) {
			logger.info("Completed all tasks");
			complete();
		} else {
			var t:Task = Task(allTasks.get(currentIndex));
			logger.info("Starting next task: " + t);
			startTask(t);
		}
	}		
		
}
	
}