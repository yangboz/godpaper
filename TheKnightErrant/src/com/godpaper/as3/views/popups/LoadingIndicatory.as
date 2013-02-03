/**
 *  GODPAPER Confidential,Copyright 2013. All rights reserved.
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
	import feathers.controls.ProgressBar;
	import feathers.controls.ScrollContainer;
	import feathers.layout.VerticalLayout;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.events.Event;
	import starling.text.TextField;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	//event metdata declare
	/** Dispatched when a new progress bar loading complete. */
	[Event(type="starling.events.Event",name="loading_complete")]
	/**
	 * LoadingIndicatory.as class.Pop-up view triggered by progressing signal.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Feb 3, 2013 9:37:53 PM
	 */   	 
	public class LoadingIndicatory extends IndicatoryBase
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//		private var _progressTween:GTween;//Foxhole extended GTween.
		private var _progressTween:Tween;
		private var _progress:ProgressBar;
		private var _label:TextField;
		//
		private var _label_value:String;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		public static const LOADING_COMPLETE:String = "loading_complete";
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
		public function LoadingIndicatory(label:String="")
		{
			super();
			//
			if(!label)
			{
				this._label_value = this.resourceManager.getString(this.bundleName,"LABEL_LOADING");
			}else
			{
				this._label_value = label;
			}
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
			const layout:VerticalLayout = new VerticalLayout();
			layout.gap = 10;
			layout.paddingTop = 10;
			layout.paddingRight = 10;
			layout.paddingBottom = 10;
			layout.paddingLeft = 10;
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			layout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			//
			this._container = new ScrollContainer();
			this._container.layout = layout;
			//			this._container.verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			this.addChild(this._container);
			//
			this._label = new TextField(100,20,this._label_value);
//			this._label = new TextField(100,20,this.resourceManager.getString(this.bundleName,"LABEL_LOADING"));
			this._container.addChild(this._label);
			//
			this._progress = new ProgressBar();
			this._progress.minimum = 0;
			this._progress.maximum = 1;
			this._progress.value = 0;
			this._container.addChild(this._progress);
			//
			//			this._progressTween = new GTween(this._progress, 5,
			this._progressTween = new Tween(this._progress, 5,Transitions.EASE_IN);
			this._progressTween.animate("value",100);
			Starling.juggler.add(this._progressTween); 
			//Loading subroutines here.
			//Loading complete handler.
			//			starling.core.Starling.juggler.delayCall(
			this._progressTween.onComplete =  
				function():void
				{
					dispatchEvent(new Event(LOADING_COMPLETE,false,null));//Dispatch it.
				};
		}
		//
		override protected function draw():void
		{
			this._container.y = 0;
			this._container.width = this.actualWidth;
			this._container.height = this.actualHeight - this._container.y;
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}
	
}