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
	import com.godpaper.as3.utils.LogUtil;
	
	import mx.logging.ILogger;

    /**
     * A task group that processes its children in pseudo-parallel. All the child
     * tasks are started in quick succession and the task group only finishes
     * when all the children have completed successfully. If any child has a
     * fault, then the task group fails with a fault also.
     */
    public class ParallelTask extends TaskGroup
    {
        //------------------------------------------------------------------------
        //
        //  Constants
        //
        //------------------------------------------------------------------------
        private static const LOG:ILogger = LogUtil.getLogger(ParallelTask);

        //------------------------------------------------------------------------
        //
        //  Constructor
        //
        //------------------------------------------------------------------------

        public function ParallelTask()
        {
            super();
        }

        //------------------------------------------------------------------------
        //
        //  Implementation : Task
        //
        //------------------------------------------------------------------------

        override protected function performTask():void
        {
//            if (LOG.isDebugEnabled())
//            {
//                LOG.debug("Starting parallel task group: label={0}, children={1}, size={2}",
//                          label, children.length, size);
//            }
			LOG.debug("Starting parallel task group: label={0}, children={1}, size={2}",
				label, children.length, size);

            if (hasNoEnabledChildren)
            {
//                if (LOG.isDebugEnabled())
//                {
//                    LOG.debug("Completed parallel task group: label={0}", label);
//                }
				LOG.debug("Completed parallel task group: label={0}", label);
                complete();
            }
            else
            {
                processChildren();
            }
        }
		
		private function get hasNoEnabledChildren():Boolean
		{
			for each (var child:ITask in children)
			{
				if (child.enabled) return false;
			}
			return true;
		}
        
        private function processChildren():void
        {
            for each (var child:ITask in children)
            {
                processChild(child);
            }
        }

        //------------------------------------------------------------------------
        //
        //  Overrides : TaskGroup
        //
        //------------------------------------------------------------------------

        override protected function onChildTaskComplete(event:TaskEvent):void
        {
            super.onChildTaskComplete(event);

            if (processed == size && currentState != TaskEvent.TASK_FAULT)
            {
//                if (LOG.isDebugEnabled())
//                {
//                    LOG.debug("Completed parallel task group: label={0}", label);
//                }
				LOG.debug("Completed parallel task group: label={0}", label);

                complete();
            }
        }

        override protected function onChildTaskFault(event:TaskEvent):void
        {
            super.onChildTaskFault(event);

//            if (LOG.isErrorEnabled())
//            {
//                LOG.error("Fault during parallel task group: label={0}", label);
//            }
			LOG.error("Fault during parallel task group: label={0}", label);
            
            fault(event.message);
        }
    }
}