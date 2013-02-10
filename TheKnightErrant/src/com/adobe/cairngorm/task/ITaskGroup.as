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

    //---------------------------------------------------------------------------
    //
    //  Meta-data
    //
    //---------------------------------------------------------------------------

    //----------------------------------
    //  Events
    //----------------------------------

    /**
     *
     */

    [Event(name="taskProgress", type="com.adobe.cairngorm.task.TaskEvent")]

    /**
     *
     */

    [Event(name="childStart", type="com.adobe.cairngorm.task.TaskEvent")]

    /**
     *
     */

    [Event(name="childComplete", type="com.adobe.cairngorm.task.TaskEvent")]

    /**
     *
     */

    [Event(name="childFault", type="com.adobe.cairngorm.task.TaskEvent")]

    /**
     * A task is a composition of task-items.
     */
    public interface ITaskGroup extends ITask
    {
        //------------------------------------------------------------------------
        //
        //  Properties
        //
        //------------------------------------------------------------------------

        //-------------------------------
        //  children
        //-------------------------------

        [ArrayElementType("com.adobe.cairngorm.task.ITask")]

        /**
         * The child tasks contained in the task group.
         */

        function get children():Array /* of ITaskItem */;

        function set children(value:Array /* of ITaskItem */):void;

        //-------------------------------
        //  size
        //-------------------------------

        [Bindable("taskStart")]

        /**
         * The number of tasks contained in the task group, including nested
         * children.
         */

        function get size():uint;

        //-------------------------------
        //  processed
        //-------------------------------

        [Bindable("taskProgress")]

        /**
         * The number of tasks that have been processed to completion or
         * skipped because they it was disabled.
         */

        function get processed():uint;

        //------------------------------------------------------------------------
        //
        //  Methods
        //
        //------------------------------------------------------------------------

        /**
         *
         */
        function addChild(child:ITask):void;

        /**
         *
         */
        function removeChild(child:ITask):void;
    }
}