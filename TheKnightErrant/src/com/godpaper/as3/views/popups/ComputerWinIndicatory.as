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
	
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	
	import starling.display.DisplayObject;
	import starling.text.TextField;

	/**
	 * Callout/popup view component that indicated the computer win status.</br>
	 * Example skelton as follows:</br>
	 * -----------------------------------</br>
	 * -----------!!!You lost!!!----------</br>
	 * -----------------------------------</br>
	 * ------------Try again?-------------</br>
	 * -----------------------------------</br>
	 * -------YES---------------NO--------</br>
	 * -----------------------------------</br>
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Jun 20, 2012 2:56:34 PM
	 */   	 
	public class ComputerWinIndicatory extends IndicatoryBase
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var _yesBtn:Button;
		private var _noBtn:Button;
		private var _msgLable:TextField;
		//
		private var _buttonsContainer:ScrollContainer;//yes,no button.
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
			super.initialize();
			//
			this._msgLable = new TextField(200,20,"Try again?");
			this._container.addChild(this._msgLable);
			//
			this._buttonsContainer = new ScrollContainer();
			this._buttonsContainer.layout = hLayout;
			this._buttonsContainer.scrollerProperties.horizontalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			this._buttonsContainer.scrollerProperties.verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			this._container.addChild(this._buttonsContainer);
			//buttons 
			this._yesBtn = new Button();
			this._yesBtn.label = "YES";
//			this._yesBtn.width = this._yesBtn.height = (44 + 88 * Math.random()) * this.dpiScale;
			this._buttonsContainer.addChild(this._yesBtn);
			this._noBtn = new Button();
			this._noBtn.label = "NO";
//			this._noBtn.width = this._noBtn.height = (44 + 88 * Math.random()) * this.dpiScale;
			this._buttonsContainer.addChild(this._noBtn);
			//header items
//			this._header.leftItems = new <DisplayObject>
//				[
//					this._yesBtn
//				];
//			this._header.rightItems = new <DisplayObject>
//				[
//					this._noBtn
//				];
			//event listener
			this._yesBtn.onRelease.add(yesButtonOnRelease);
			this._noBtn.onRelease.add(noButtonOnRelease);
			//
			this._header.title = DefaultConstants.INDICATION_COMPUTER_WIN;
			this.width = 200;
			this.height = 100;	
		}
		//
		override protected function draw():void
		{
			super.draw();
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