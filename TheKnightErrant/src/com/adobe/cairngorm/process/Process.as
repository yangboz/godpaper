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
package com.adobe.cairngorm.process
{
    import flash.events.EventDispatcher;
    
    [Event(name="partialComplete",type="com.adobe.ac.utils.ProcessEvent")]
    [Event(name="ready",type="com.adobe.ac.utils.ProcessEvent")]
    public class Process extends EventDispatcher
    {
        //---------------------------------------------------------------------
        //
        //  Properties
        //
        //---------------------------------------------------------------------

		private var currentStatus:int;
        private var completeStatus:int;
        
        //---------------------------------------------------------------------
        //
        //  Constructor
        //
        //---------------------------------------------------------------------
        
		public function Process(... args)
        {
            completeStatus = 0;
            addTasks.apply(this, args);
        }
        
        //---------------------------------------------------------------------
        //
        //  Public Methods
        //
        //---------------------------------------------------------------------
        
		public function addTask(taskId:int):void 
        {
            completeStatus |= getShiftedTask(taskId);
        }
        
        public function addTasks(...args):void 
        {
            for (var i:int = 0; i < args.length; i++)
            {
                addTask(int(args[i]));
            }
        }
        
        public function clear():void
        {
            currentStatus = 0;
        }
        
        [Bindable("complete")]
        public function isComplete():Boolean
        {
            return (currentStatus & completeStatus) == completeStatus;
        }
        
        [Bindable("ready")]
        public function isReady(taskId:int):Boolean
        {
            var shiftedTask : int = getShiftedTask(taskId);
            return ((currentStatus & shiftedTask) == shiftedTask) ? true : false;
        }
        
        public function completeTask(taskId:int):void
        {
            currentStatus |= getShiftedTask(taskId);
            dispatchEvent(new ProcessEvent(ProcessEvent.READY));
            
            if (isComplete())
            {
                dispatchEvent(new ProcessEvent(ProcessEvent.COMPLETE));
            }
        }

		//---------------------------------------------------------------------
		//
		//  Private Methods
		//
		//---------------------------------------------------------------------
		
		private function getShiftedTask(taskId:int):int
		{
			return 1 << taskId;
		}
    }
}