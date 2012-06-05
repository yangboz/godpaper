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
import org.spicefactory.lib.task.TaskGroup;
import org.spicefactory.lib.task.enum.TaskState;

/**
 * A TaskGroup implementation that executes its child Tasks concurrently.
 * If a TaskGroup is started all the Tasks that were added to it will be started immediately.
 * If a Taks gets added to a running TaskGroup, that Task will be started immediately.
 * When all child Tasks have completed their operation this TaskGroup will fire its
 * <code>COMPLETE</code> event. If a TaskGroup gets cancelled or suspended all child
 * tasks that are still running will also be cancelled or suspended in turn.
 * If a child Task throws an <code>ERROR</code> event and the <code>ignoreChildErrors</code> property
 * of this TaskGroup is set to false, then all child tasks that are still running will be cancelled
 * and the TaskGroup will fire an <code>ERROR</code> event.
 * 
 * @author Jens Halm
 */
public class ConcurrentTaskGroup extends TaskGroup {
	
		
	/**
	 * Creates a new TaskGroup.
	 * 
	 * @param name an optional name for log output
	 */
	public function ConcurrentTaskGroup (name:String = null) {
		super();
		setName((name == null) ? "[ConcurrentTaskGroup]" : name);
	}
	
	/**
	 * @private
	 */
	protected override function handleAddedTask (t : Task) : void {
		if (state == TaskState.ACTIVE) {
			// Group is already active so we must start the new task immediately
			startTask(t);
		} else if (state == TaskState.SUSPENDED) {
			// Add the new task to the activeTasks List so it will be started when resuming the TaskGroup
			activeTasks.append(t);
		}
	}

	/**
	 * @private
	 */	
	protected override function doStart () : void {
		if (allTasks.isEmpty()) {
			complete();
			return;
		}
		var startingTasks:Array = allTasks.toArray();
		for each (var t1:Task in startingTasks) {
			/* activeTasks Array needs to be completely filled before any Task is started
			   to avoid errors in case it contains Tasks that complete immediately (fixes SLA-22) */
			activeTasks.append(t1);
		}
		for each (var t2:Task in startingTasks) {
			startTask(t2);
		}
	}
	
	/**
	 * @private
	 */
	protected override function handleTaskComplete (t:Task) : void {
		// if TaskGroup is suspended wait for resume call before firing COMPLETE event
		if (activeTasks.isEmpty() && state == TaskState.ACTIVE) complete();
	}		
		
}
	
}