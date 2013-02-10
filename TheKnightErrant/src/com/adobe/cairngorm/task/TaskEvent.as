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
    import flash.events.Event;

    /**
     * An event that occurs while processing a task.
     */
    public class TaskEvent extends Event
    {
        //------------------------------------------------------------------------
        //
        //  Constants
        //
        //------------------------------------------------------------------------

        //-------------------------------
        //  Event Types : ITask
        //-------------------------------

        public static const TASK_START:String = "taskStart";

        public static const TASK_COMPLETE:String = "taskComplete";

        public static const TASK_FAULT:String = "taskFault";

        //-------------------------------
        //  Event Types : ITaskGroup
        //-------------------------------

        public static const TASK_PROGRESS:String = "taskProgress";

        public static const CHILD_START:String = "childStart";

        public static const CHILD_COMPLETE:String = "childComplete";

        public static const CHILD_FAULT:String = "childFault";

        //------------------------------------------------------------------------
        //
        //  Constructor
        //
        //------------------------------------------------------------------------

        public function TaskEvent(type:String, task:ITask)
        {
            super(type);
            _task = task;
        }

        //------------------------------------------------------------------------
        //
        //  Static Factory Methods
        //
        //------------------------------------------------------------------------

        //-------------------------------
        //  ITask Events
        //-------------------------------

        public static function createStartEvent(task:ITask):TaskEvent
        {
            return new TaskEvent(TASK_START, task);
        }

        public static function createCompleteEvent(task:ITask):TaskEvent
        {
            return new TaskEvent(TASK_COMPLETE, task);
        }

        public static function createFaultEvent(task:ITask, message:String = null):TaskEvent
        {
            var event:TaskEvent = new TaskEvent(TASK_FAULT, task);
            event._message = message;
            return event;
        }

        //-------------------------------
        //  ITaskGroup Events
        //-------------------------------

        public static function createProgressEvent(task:ITask, processed:uint,
                                                   size:uint):TaskEvent
        {
            var event:TaskEvent = new TaskEvent(TASK_PROGRESS, task);
            event._processed = processed;
            event._size = size;
            return event;
        }

        public static function createChildStartEvent(task:ITask):TaskEvent
        {
            return new TaskEvent(CHILD_START, task);
        }

        public static function createChildCompleteEvent(task:ITask):TaskEvent
        {
            return new TaskEvent(CHILD_COMPLETE, task);
        }

        public static function createChildFaultEvent(task:ITask, message:String = null):TaskEvent
        {
            var event:TaskEvent = new TaskEvent(CHILD_FAULT, task);
            event._message = message;
            return event;
        }

        //------------------------------------------------------------------------
        //
        //  Properties
        //
        //------------------------------------------------------------------------

        //-------------------------------
        //  taskItem
        //-------------------------------

        private var _task:ITask;

        /**
         * The task that the event applies to.
         */
        public function get task():ITask
        {
            return _task;
        }

        //-------------------------------
        //  processed
        //-------------------------------

        private var _processed:uint;

        public function get processed():uint
        {
            return _processed;
        }

        //-------------------------------
        //  size
        //-------------------------------

        private var _size:uint;

        public function get size():uint
        {
            return _size;
        }

        //-------------------------------
        //  message
        //-------------------------------

        private var _message:String;

        /**
         * The message desribing the cause of a taskFault event.
         */
        public function get message():String
        {
            return _message;
        }

        //------------------------------------------------------------------------
        //
        //  Overrides : Event
        //
        //------------------------------------------------------------------------

        override public function clone():Event
        {
            var event:TaskEvent = new TaskEvent(type, _task);

            event._message = _message;
            event._processed = _processed;
            event._size = _size;

            return event;
        }
    }
}