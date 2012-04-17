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
package com.godpaper.starling.views.components
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	/**
	 * RoundButton.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Apr 16, 2012 1:42:24 PM
	 */   	 
	public class RoundButton extends Button
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
		public function RoundButton(upState:Texture, text:String="", downState:Texture=null)
		{
			super(upState, text, downState);
			//
			this.addEventListener(TouchEvent.TOUCH,touchHandler);
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		public override function hitTest(localPoint:Point, forTouch:Boolean=false):DisplayObject
		{
			// When the user touches the screen, this method is used to find out if an object was 
			// hit. By default, this method uses the bounding box, but by overriding it, 
			// we can change the box (rectangle) to a circle (or whatever necessary).
			
			// when the hit test is done to check if a touch is hitting the object, invisible or
			// untouchable objects must cause the hit test to fail.
			if (forTouch && (!visible || !touchable)) 
				return null; 
			
			// get center of button
			var bounds:Rectangle = this.bounds;
			var centerX:Number = bounds.width / 2;
			var centerY:Number = bounds.height / 2;
			
			// calculate distance of localPoint to center. 
			// we keep it squared, since we want to avoid the 'sqrt()'-call.
			var sqDist:Number = Math.pow(localPoint.x - centerX, 2) + 
				Math.pow(localPoint.y - centerY, 2);
			
			// when the squared distance is smaller than the squared radius, 
			// the point is inside the circle
			var radius:Number = bounds.width / 2;
			if (sqDist < Math.pow(radius, 2)) return this;
			else return null;
		}
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
		private function touchHandler(event:TouchEvent):void
		{
			const touch:Touch = event.getTouch(this);
			//
			if(touch.phase == TouchPhase.BEGAN)
			{
				this.x = touch.globalX;
				this.y = touch.globalY;
			}
			else if(touch.phase == TouchPhase.MOVED)
			{
				this.x = touch.globalX;
				this.y = touch.globalY;
			}
			else if(touch.phase == TouchPhase.ENDED)
			{
				this.x = touch.globalX;
				this.y = touch.globalY;
			}
		}
	}
	
}