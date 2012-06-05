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
 
package org.spicefactory.lib.task.events {
	
import flash.events.Event;

/**
 * Event that fires when a Task changes its internal state.
 * 
 * @author Jens Halm
 */
public class TaskEvent extends Event {

	
	/**
	 * Constant for the type of event fired when a Task is started.
	 * 
	 * @eventType start
	 */
	public static const START : String = "start";

	/**
	 * Constant for the type of event fired when a Task is suspended.
	 * 
	 * @eventType suspend
	 */
	public static const SUSPEND : String = "suspend";
	
	/**
	 * Constant for the type of event fired when a Task is resumed.
	 * 
	 * @eventType resume
	 */
	public static const RESUME : String = "resume";

	/**
	 * Constant for the type of event fired when a Task is completed.
	 * 
	 * @eventType complete
	 */	
	public static const COMPLETE : String = "complete";
	
	/**
	 * Constant for the type of event fired when a Task is cancelled.
	 * 
	 * @eventType cancel
	 */
	public static const CANCEL : String = "cancel";
	
	
	/**
	 * Creates a new event instance.
	 * 
	 * @param type the type of this event
	 */
	public function TaskEvent (type:String) {
		super(type);
	}	
	
	
	/**
	 * @private
	 */
	public override function clone () : Event {
		return new TaskEvent(type);
	}	
		
}
	
}