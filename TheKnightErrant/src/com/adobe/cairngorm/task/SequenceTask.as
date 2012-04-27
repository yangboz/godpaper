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
	import org.spicefactory.lib.logging.Logger;
    import org.spicefactory.lib.logging.LogContext;

    /**
     * A task group that processes its children in sequence. The next child is
     * started only when the previous child completes.
     */
    public class SequenceTask extends TaskGroup
    {
        //------------------------------------------------------------------------
        //
        //  Constants
        //
        //------------------------------------------------------------------------
        private static const LOG:Logger = LogContext.getLogger(SequenceTask);

        //------------------------------------------------------------------------
        //
        //  Private Variables
        //
        //------------------------------------------------------------------------

        /** The index of the task currently processing. */
        private var currentIndex:uint = 0;

        //------------------------------------------------------------------------
        //
        //  Constructor
        //
        //------------------------------------------------------------------------

        public function SequenceTask()
        {
            super();
        }

        //------------------------------------------------------------------------
        //
        //  Implementation : TaskItem
        //
        //------------------------------------------------------------------------

        override protected function performTask():void
        {
            if (LOG.isDebugEnabled())
            {
                LOG.debug("Starting sequence task group: label={0}, children={1}, size={2}",
                          label, children.length, size);
            }

            startNextTask();
        }

        //------------------------------------------------------------------------
        //
        //  Overrides : TaskGroup
        //
        //------------------------------------------------------------------------

        override protected function onChildTaskComplete(event:TaskEvent):void
        {
            super.onChildTaskComplete(event);

            startNextTask();
        }

        override protected function onChildTaskFault(event:TaskEvent):void
        {
            super.onChildTaskFault(event);

            if (LOG.isErrorEnabled())
            {
                LOG.error("Fault during sequence task group: label={0}", label);
            }

            fault(event.message);
        }

        //------------------------------------------------------------------------
        //
        //  Private methods
        //
        //------------------------------------------------------------------------

        private function startNextTask():void
        {
            if (hasMoreTasks)
            {
                var skipped:Boolean = processChild(getNextChild()) == false;

                if (skipped)
                {
                    startNextTask();
                }
            }
            else
            {
                if (LOG.isDebugEnabled())
                {
                    LOG.debug("Completed sequence task group: label={0}", label);
                }

                complete();
            }
        }

        private function get hasMoreTasks():Boolean
        {
            return children && currentIndex < children.length;
        }

        private function getNextChild():ITask
        {
            return children[currentIndex++] as ITask;
        }
    }
}