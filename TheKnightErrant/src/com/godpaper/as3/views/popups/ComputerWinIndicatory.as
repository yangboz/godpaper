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
	import com.godpaper.as3.configs.GameConfig;
	import com.godpaper.as3.configs.IndicatorConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	
	import org.josht.starling.foxhole.controls.Button;
	import org.josht.starling.foxhole.controls.Label;
	import org.josht.starling.foxhole.controls.Screen;
	import org.josht.starling.foxhole.controls.ScreenHeader;
	import org.josht.starling.foxhole.controls.ScrollContainer;
	import org.josht.starling.foxhole.layout.HorizontalLayout;
	
	import starling.display.DisplayObject;
	/**
	 * Callout/popup view component that indicated the computer win status. 	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Jun 20, 2012 2:56:34 PM
	 */   	 
	public class ComputerWinIndicatory extends Screen
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var _yesBtn:Button;
		private var _noBtn:Button;
		//
		private var _container:ScrollContainer;
		private var _header:ScreenHeader;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private var layout:HorizontalLayout;
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
		public function ComputerWinIndicatory()
		{
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
			this._header.title = DefaultConstants.INDICATION_COMPUTER_WIN;
			this.addChild(this._header);
			//layout 
			const layout:HorizontalLayout = new HorizontalLayout();
			layout.gap = 0;
			layout.paddingTop = 0;
			layout.paddingRight = 0;
			layout.paddingBottom = 0;
			layout.paddingLeft = 0;
			layout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_LEFT;
			layout.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_TOP;
			//container
			this._container = new ScrollContainer();
			this._container.layout = layout;
//			this.addChild(this._container);
			//buttons 
			this._yesBtn = new Button();
			this._yesBtn.label = "YES";
			this._yesBtn.width = this._yesBtn.height = (44 + 88 * Math.random()) * this.dpiScale;
//			this._container.addChild(this._yesBtn);
			this._noBtn = new Button();
			this._noBtn.label = "NO";
			this._noBtn.width = this._noBtn.height = (44 + 88 * Math.random()) * this.dpiScale;
//			this._container.addChild(this._noBtn);
			//header items
			this._header.leftItems = new <DisplayObject>
				[
					this._yesBtn
				];
			this._header.rightItems = new <DisplayObject>
				[
					this._noBtn
				];
			//event listener
			this._yesBtn.onRelease.add(yesButtonOnRelease);
			this._noBtn.onRelease.add(noButtonOnRelease);
		}
		//
		override protected function draw():void
		{
			//
			this._header.width = this.actualWidth;
			this._header.validate();
			//			
			this._container.y = this._header.height;
//			this._container.width = this.actualWidth;
			this._container.width = 100;
			this._container.height = this.actualHeight - this._container.y;
			this._container.validate();
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		private function yesButtonOnRelease(button:Button):void
		{
			//restart game.
			GameConfig.gameStateManager.restart();
			//
			IndicatorConfig.outcome = false;
		}
		private function noButtonOnRelease(button:Button):void
		{
			IndicatorConfig.outcome = false;
		}
	}
	
}