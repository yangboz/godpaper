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
 
package org.spicefactory.lib.task.enum {
	
/**
 * Enumeration for the internal state of Task instances.
 * 
 * @author Jens Halm
 */
public class TaskState {

	
	/**
	 * The state of the Task before it has been started for the first time or
	 * (for restartable Tasks) also after it has completed its execution.
	 * Only Task instances with this internal state can be started.
	 */
	public static const INACTIVE : TaskState = new TaskState("INACTIVE");

	/**
	 * The state of a running Task.
	 */
	public static const ACTIVE : TaskState = new TaskState("ACTIVE");
	
	/**
	 * The state of a suspended Task.
	 */
	public static const SUSPENDED : TaskState = new TaskState("SUSPENDED");
	
	/**
	 * The state of a non-restartable Task that has completed its execution.
	 */
	public static const FINISHED : TaskState = new TaskState("FINISHED");
	
	
	private var name : String;
	
	/**
	 * @private
	 */
	public function TaskState (name : String) {
		this.name = name;
	}
	
	/**
	 * @private
	 */
	public function toString () : String {
		return name;
	}		
		
}
	
}