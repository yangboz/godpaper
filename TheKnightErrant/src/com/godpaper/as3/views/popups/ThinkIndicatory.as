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
	import feathers.controls.Label;
	import feathers.controls.ProgressBar;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	
	
	/**
	 * Callout/popup view component that indicated the computer thinking status.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Jun 20, 2012 1:41:57 PM
	 */   	 
	public class ThinkIndicatory extends IndicatoryBase
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
//		private var _progressTween:GTween;//Foxhole extended GTween.
		private var _progressTween:Tween;
		private var _progress:ProgressBar;
		private var _label:Label;
		//
		private var _label_value:String;
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
		public function ThinkIndicatory(label:String="")
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
			//
			this._progress = new ProgressBar();
			this._progress.minimum = 0;
			this._progress.maximum = 1;
			this._progress.value = 0;
			this.addChild(this._progress);
			//
//			this._progressTween = new GTween(this._progress, 5,
			this._progressTween = new Tween(this._progress, 2,Transitions.EASE_IN);
			this._progressTween.animate("value",100);
			this._progressTween.repeatCount = 0;
			Starling.juggler.add(this._progressTween); 
			//
			this._label = new Label();
			this._label.text = this._label_value;
			this.addChild(this._label);
		}
		
		override protected function draw():void
		{
			this._progress.validate();
			this._progress.x = (this.actualWidth - this._progress.width) / 2;
			this._progress.y = (this.actualHeight - this._progress.height) / 2;
			//
			this._label.validate();
			this._label.x = (this.actualWidth - this._label.width) / 2;
			this._label.y = (this.actualHeight - this._label.height) / 2 - this._progress.height*3;//more gap.
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}
	
}