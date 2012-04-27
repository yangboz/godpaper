/**
 *  Copyright (c) 2007 - 2009 Adobe
 *  All rights reserved.
 *
 *  Permission is hereby granted, free of charge, to any person obtaining
 *  a copy of this software and associated documentation files (the "Software"),
 *  to deal in the Software without restriction, including without limitation
 *  the rights to use, copy, modify, merge, publish, distribute, sublicense,
 *  and/or sell copies of the Software, and to permit persons to whom the
 *  Software is furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included
 *  in all copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 *  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 *  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
 *  IN THE SOFTWARE.
 */
package com.adobe.cairngorm.task
{
	import flash.events.EventDispatcher;
	
	import mx.events.StateChangeEvent;
	
	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;
	//---------------------------------------------------------------------------
	//
	//  Meta-data
	//
	//---------------------------------------------------------------------------

	//----------------------------------
	//  Events
	//----------------------------------

	[Event(name="currentStateChange", type="mx.events.StateChangeEvent")]
	[Event(name="taskStart", type="com.adobe.cairngorm.task.TaskEvent")]
	[Event(name="taskComplete", type="com.adobe.cairngorm.task.TaskEvent")]
	[Event(name="taskFault", type="com.adobe.cairngorm.task.TaskEvent")]

	/**
	 * Base-class for a tasks that perform some processing and can be placed
	 * inside task groups.
	 * <p/>
	 * The abstract <code>performTask()</code> method must be implemented by
	 * concrete sub-classes, and the <code>complete()</code> or
	 * <code>fault()</code> methods invoked to indicate that the processing has
	 * completed or failed.
	 * <p/>
	 * The <code>progress</code> method may optionally be invoked to provide
	 * fine-grained progress updates. The base-class will dispatch an initial and
	 * final progress event for 0% complete and 100% complete, assuming the task
	 * completes successfully.
	 */
	public class Task extends EventDispatcher implements ITask
	{
		private static const LOG:Logger=LogContext.getLogger(Task);

		//------------------------------------------------------------------------
		//
		//  Implementation : ITask
		//
		//------------------------------------------------------------------------

		//-------------------------------
		//  Simple bindables
		//-------------------------------

//		[Bindable]
		private var _enabled:Boolean=true;

		public function get enabled():Boolean
		{
			return _enabled;
		}

		public function set enabled(value:Boolean):void
		{
			_enabled = value;
		}


//		[Bindable]
		private var _label:String;

		public function get label():String
		{
			return _label;
		}

		public function set label(value:String):void
		{
			_label = value;
		}


		//-------------------------------
		//  currentState
		//-------------------------------

		private var _currentState:String=TaskState.UNSTARTED;

//		[Bindable("currentStateChange")]
		public function get currentState():String
		{
			return _currentState;
		}

		private function setCurrentState(value:String):void
		{
			var event:StateChangeEvent=new StateChangeEvent(StateChangeEvent.CURRENT_STATE_CHANGE, false, false, _currentState, value);

			_currentState=value;

			dispatchEvent(event);
		}

		//------------------------------------------------------------------------
		//
		//  Public methods
		//
		//------------------------------------------------------------------------

		public function start():void
		{
			if (LOG.isDebugEnabled())
			{
				LOG.debug("Starting task-item: label={0}", label);
			}

			dispatchEvent(TaskEvent.createStartEvent(this));
			setCurrentState(TaskState.RUNNING);
			performTask(); // Template Method design pattern
		}

		//------------------------------------------------------------------------
		//
		//  Abstract methods
		//
		//------------------------------------------------------------------------

		/**
		 * This abstract template method must be implemented by a concrete
		 * sub-class to perform the task associated with the task. The task
		 * may be synchronous or asynchronous. When the task is completed, the
		 * <code>complete()</code> method must be called, unless a fault has
		 * occurred, in which case the <code>fault()</code> method must be called
		 * instead.
		 */
		protected function performTask():void
		{
			throw new Error("abstract function call");
		}

		//------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//------------------------------------------------------------------------

		/**
		 * This should be called by a concrete sub-class to indicate that the
		 * task has been completed. It should only be called once and subsequent
		 * calls are ignored.
		 */
		protected function complete():void
		{
			if (_currentState != TaskState.RUNNING)
				return;

			if (LOG.isDebugEnabled())
			{
				LOG.debug("Completed task-item: label={0}", label);
			}

			setCurrentState(TaskState.COMPLETED);

			dispatchEvent(TaskEvent.createCompleteEvent(this));
		}

		/**
		 * This should be called by a concrete sub-class to indicate that the task
		 * has been halted due to a fault. It should only be called once and
		 * subsequent calls are ignored.
		 *
		 * @param message
		 *    an optional message describing the cause of the fault
		 */
		protected function fault(message:String=null):void
		{
			if (_currentState != TaskState.RUNNING)
				return;

			if (LOG.isErrorEnabled())
			{
				LOG.error("Fault processing task-item: label={0}, message={1}", label, message);
			}

			setCurrentState(TaskState.FAULT);

			dispatchEvent(TaskEvent.createFaultEvent(this, message));
		}
	}
}