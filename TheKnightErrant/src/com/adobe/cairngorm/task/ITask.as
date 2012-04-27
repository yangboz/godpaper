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
    import flash.events.IEventDispatcher;

    //---------------------------------------------------------------------------
    //
    //  Meta-data
    //
    //---------------------------------------------------------------------------

    //----------------------------------
    //  Events
    //----------------------------------

    /**
     * Dispatched when the <code>currentState</code> property has changed value.
     */

    [Event(name="currentStateChange", type="mx.events.StateChangeEvent")]

    /**
     * Dispatched when the task has started after the <code>start()</code> method
     * of the task has been invoked.
     */

    [Event(name="taskStart", type="com.adobe.cairngorm.task.TaskEvent")]

    /**
     * Dispatched when the task has been completed.
     */

    [Event(name="taskComplete", type="com.adobe.cairngorm.task.TaskEvent")]

    /**
     * Dispatched when a fault has occurred while performing the task.
     */

    [Event(name="taskFault", type="com.adobe.cairngorm.task.TaskEvent")]

    /**
     * A task performs some task when the <code>start()</code> method is
     * called. If the task completes successfully, the <code>taskComplete</code>
     * event is dispatched, if a fault occurs then the <code>taskFault</code>
     * event is dispatched. During progressing <code>taskProgress</code> events
     * are dispatched. The granularity of these depends on the concrete
     * implementation.
     */
    public interface ITask extends IEventDispatcher
    {
        //------------------------------------------------------------------------
        //
        //  Properties
        //
        //------------------------------------------------------------------------

        /**
         * A label associated with the task.
         */

//        [Bindable("propertyChange")]

        function get label():String;
        function set label(value:String):void;

        /**
         * Enables or disables the taskgroup task. Only enabled task group tasks
         * will be processed.
         */

//        [Bindable("propertyChange")]

        function get enabled():Boolean;
        function set enabled(value:Boolean):void;

        /**
         * Gets the current state of the task. The values are defined as
         * constants on the <code>TaskState</code> class.
         */

//        [Bindable("currentStateChange")]

        function get currentState():String;

        //------------------------------------------------------------------------
        //
        //  Methods
        //
        //------------------------------------------------------------------------

        /**
         * Starts processing the task-item.
         */
        function start():void;
    }
}