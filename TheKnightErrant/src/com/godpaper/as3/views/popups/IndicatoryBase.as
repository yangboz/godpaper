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
package com.godpaper.as3.views.popups
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import org.josht.starling.foxhole.controls.Screen;
	import org.josht.starling.foxhole.controls.ScreenHeader;
	import org.josht.starling.foxhole.controls.ScrollContainer;
	import org.josht.starling.foxhole.controls.Scroller;
	import org.josht.starling.foxhole.layout.HorizontalLayout;
	import org.josht.starling.foxhole.layout.VerticalLayout;
	
	
	/**
	 * IndicatoryBase.as class.The base class of all indicatory with popup behavior.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Aug 23, 2012 5:17:27 PM
	 */   	 
	public class IndicatoryBase extends Screen
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		protected var hLayout:HorizontalLayout;
		protected var vLayout:VerticalLayout;
		protected var _header:ScreenHeader;
		protected var _container:ScrollContainer;
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
		public function IndicatoryBase()
		{
			super();
			//layout 
			hLayout = new HorizontalLayout();
			hLayout.gap = 10;
			hLayout.paddingTop = 10;
			hLayout.paddingRight = 10;
			hLayout.paddingBottom = 10;
			hLayout.paddingLeft = 10;
			hLayout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			hLayout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			//
			vLayout = new VerticalLayout();
			vLayout.gap = 10;
			vLayout.paddingTop = 10;
			vLayout.paddingRight = 10;
			vLayout.paddingBottom = 10;
			vLayout.paddingLeft = 10;
			vLayout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			vLayout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
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
		override protected function initialize():void
		{
			//header title
			this._header = new ScreenHeader();
			this._header.title = "???";
			this.addChild(this._header);
			//container
			this._container = new ScrollContainer();
			this._container.layout = vLayout;//default layout
			this._container.horizontalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			this._container.verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			this.addChild(this._container);
			//Append the customize initialization.
		}
		//
		override protected function draw():void
		{
			//
			this._header.width = this.actualWidth;
			this._header.validate();
			//			
			this._container.y = this._header.height;
			this._container.width = this.actualWidth;
			this._container.height = this.actualHeight - this._container.y;
			this._container.validate();
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}
	
}