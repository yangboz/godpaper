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
//    import mx.logging.ILogger;
//    import mx.logging.Log;
	import org.spicefactory.lib.logging.Logger;
	import org.spicefactory.lib.logging.LogContext;
    //---------------------------------------------------------------------------
    //
    //  Meta-data
    //
    //---------------------------------------------------------------------------

    //----------------------------------
    //  Events
    //----------------------------------

    [Event(name="taskProgress", type="com.adobe.cairngorm.task.TaskEvent")]

    [Event(name="childStart", type="com.adobe.cairngorm.task.TaskEvent")]

    [Event(name="childComplete", type="com.adobe.cairngorm.task.TaskEvent")]

    [Event(name="childFault", type="com.adobe.cairngorm.task.TaskEvent")]

    //----------------------------------
    //  Other Metadata
    //----------------------------------

    [DefaultProperty("children")]

    /**
     * A base-class for task groups which implements the <code>children</code> and
     * <code>size</code> properties.
     */
    public class TaskGroup extends Task implements ITaskGroup
    {
        //------------------------------------------------------------------------
        //
        //  Constants
        //
        //------------------------------------------------------------------------

        private static const LOG:Logger = LogContext.getLogger(TaskGroup);

        //------------------------------------------------------------------------
        //
        //  Constructor
        //
        //------------------------------------------------------------------------

        public function TaskGroup()
        {
        }

        //------------------------------------------------------------------------
        //
        //  Implementation : ITaskGroup : Properties
        //
        //------------------------------------------------------------------------

        //-------------------------------
        //  children
        //-------------------------------

        [ArrayElementType("com.adobe.cairngorm.task.ITask")]
        private var _children:Array = [];

        public function set children(value:Array):void
        {
            _children = value;
        }

        public function get children():Array
        {
            return _children;
        }

        //-------------------------------
        //  size
        //-------------------------------

        [Bindable("taskStart")]

        public function get size():uint
        {
            return countChildren(this);
        }

        private function countChildren(taskgroup:ITaskGroup):uint
        {
            var size:uint = taskgroup.children.length;

            for each (var child:ITask in taskgroup.children)
            {
                if (child is ITaskGroup)
                {
                    size += countChildren(ITaskGroup(child));
                }
            }

            return size;
        }

        //-------------------------------
        //  processed
        //-------------------------------

        private var _processed:uint = 0;

        [Bindable("taskProgress")]

        public function get processed():uint
        {
            return _processed;
        }

        //------------------------------------------------------------------------
        //
        //  Implementation : ITask : Methods
        //
        //------------------------------------------------------------------------

        public function addChild(child:ITask):void
        {
            if (child == null)
                return;

            _children.push(child);
        }

        public function removeChild(child:ITask):void
        {
            if (child == null)
                return;

            var index:int = _children.indexOf(child);

            if (index >= 0)
            {
                _children.splice(index, 1);
            }
        }

        //------------------------------------------------------------------------
        //
        //  Protected Methods
        //
        //------------------------------------------------------------------------

        /**
         * Processes the specified child by starting it if it is enabled or
         * skipping it if it is disabled.
         *
         * @param child
         *    the child task to start processing
         * @return
         *    true if the child task is started or false if it is skipped
         */
        protected function processChild(child:ITask):Boolean
        {
            if (child == null)
            {
                throw new Error("Cannot start processing a null task");
            }

            if (child.enabled)
            {
                if (LOG.isDebugEnabled())
                {
                    LOG.debug("Starting task: label={0}", child.label);
                }

                child.addEventListener(TaskEvent.TASK_START, onChildTaskStart);
                child.addEventListener(TaskEvent.TASK_COMPLETE, onChildTaskComplete);
                child.addEventListener(TaskEvent.TASK_FAULT, onChildTaskFault);
                child.addEventListener(TaskEvent.TASK_PROGRESS, onChildTaskProgress);
                // re-dispatch any other nested child events
                child.addEventListener(TaskEvent.CHILD_START, dispatchEvent);
                child.addEventListener(TaskEvent.CHILD_COMPLETE, dispatchEvent);
                child.addEventListener(TaskEvent.CHILD_FAULT, dispatchEvent);
                child.start();

                return true;
            }
            else
            {
                if (LOG.isDebugEnabled())
                {
                    LOG.debug("Skipping task-item: label={0}", child.label);
                }

                dispatchNextProgressEvent();

                return false;
            }
        }

        //------------------------------------------------------------------------
        //
        //  Protected Event Handlers
        //
        //------------------------------------------------------------------------

        /**
         * This event handler is called whenever a child task is started. It
         * can be overridden, but the <code>super.onChildTaskStart()</code> method
         * should be called.
         */
        protected function onChildTaskStart(event:TaskEvent):void
        {
            if (LOG.isDebugEnabled())
            {
                LOG.debug("Started child task-item: label={0}", event.task.label);
            }

            dispatchEvent(TaskEvent.createChildStartEvent(event.task));
        }

        /**
         * This event handler is called whenever a child task completes. It
         * can be overridden, but the <code>super.onChildTaskComplete()</code>
         * method should be called.
         */
        protected function onChildTaskComplete(event:TaskEvent):void
        {
            if (LOG.isDebugEnabled())
            {
                LOG.debug("Completed child task-item: label={0}", event.task.label);
            }

            cleanUpChild(event.task);

            dispatchEvent(TaskEvent.createChildCompleteEvent(event.task));

            dispatchNextProgressEvent();
        }

        /**
         * This event handler is called whenever a child task fails. It
         * can be overridden, but the <code>super.onChildTaskFault()</code> method
         * should be called.
         */
        protected function onChildTaskFault(event:TaskEvent):void
        {
            if (LOG.isErrorEnabled())
            {
                LOG.error("Fault during child task-item: label={0}", event.task.label);
            }

            cleanUpChild(event.task);

            dispatchEvent(TaskEvent.createChildFaultEvent(event.task));
        }

        //------------------------------------------------------------------------
        //
        //  Private Methods
        //
        //------------------------------------------------------------------------

        private function dispatchNextProgressEvent():void
        {
            dispatchEvent(TaskEvent.createProgressEvent(this, ++_processed, size));
        }

        private function onChildTaskProgress(event:TaskEvent):void
        {
            dispatchNextProgressEvent();
        }

        private function cleanUpChild(child:ITask):void
        {
            child.removeEventListener(TaskEvent.TASK_START, onChildTaskStart);
            child.removeEventListener(TaskEvent.TASK_COMPLETE, onChildTaskComplete);
            child.removeEventListener(TaskEvent.TASK_FAULT, onChildTaskFault);
            child.removeEventListener(TaskEvent.TASK_PROGRESS, onChildTaskProgress);
            child.removeEventListener(TaskEvent.CHILD_START, dispatchEvent);
            child.removeEventListener(TaskEvent.CHILD_COMPLETE, dispatchEvent);
            child.removeEventListener(TaskEvent.CHILD_FAULT, dispatchEvent);
        }
    }
}