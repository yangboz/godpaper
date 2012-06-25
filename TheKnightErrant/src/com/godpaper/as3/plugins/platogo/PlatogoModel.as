/**
 *  GODPAPER Confidential,Copyright 2012. All rights reserved.
 *
 *  Permission is hereby granted, free of charge, to any person obtaining
 *  a copy of this software and associated documentation files (the "Software"),
 *  to deal in the Software without restriction, including without limitation
 *  the rights to use, copy, modify, merge, publish, distribute, sub-license,
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
package com.godpaper.as3.plugins.platogo
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.plugins.IPlugData;
	
	import mx.utils.ObjectUtil;
	/**
	 * PlatogoModel.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Jun 25, 2012 1:58:32 PM
	 */   	 
	public class PlatogoModel implements IPlugData
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//-------------------------------------------------------------------------- 
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function PlatogoModel()
		{
			//TODO: implement function
		}
		
		public function set gameID(value:String):void
		{
			//TODO: implement function
		}
		
		public function get gameID():String
		{
			//TODO: implement function
			return null;
		}
		
		public function set boardID(value:String):void
		{
			//TODO: implement function
		}
		
		public function get boardID():String
		{
			//TODO: implement function
			return null;
		}
		
		public function get hasCaptureIndicator():Boolean
		{
			//TODO: implement function
			return false;
		}
		
		public function get hasCheckIndicator():Boolean
		{
			//TODO: implement function
			return false;
		}
		
		public function get hasMoveIndicator():Boolean
		{
			//TODO: implement function
			return false;
		}
		
		public function toString():String
		{
			return ObjectUtil.toString(this);
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}
	
}