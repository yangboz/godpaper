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
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.core.FlexGlobals;
	import com.godpaper.as3.plugins.playerIO.PlayerIoPlugin;
	
	import feathers.controls.Button;
	import feathers.controls.Callout;
	import feathers.controls.Label;
	import feathers.controls.ScrollContainer;
	import feathers.controls.TextInput;
	import feathers.core.PopUpManager;
	
	import mx.utils.UIDUtil;
	
	import org.osflash.signals.Signal;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	
	/**
	 * ExitComfirmIndicatory.as class.When playing game, the player wanna quit game,comfirm window on demanding.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Feb 10, 2013 11:51:52 PM
	 */   	 
//	public class ExitComfirmIndicatory extends PanelScreen
	public class ExitComfirmIndicatory extends IndicatoryBase	
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var _buttonsContainer:ScrollContainer;//submit,next button 
		private var _cancelBtn:Button;//camcel exiting game button.
		private var _exitBtn:Button;//confirm exit game button.
		//Public signals
		public var signal_exit_game:Signal;
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
		public function ExitComfirmIndicatory()
		{
			super();
			//
			this.signal_exit_game = new Signal();
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
			//_buttonsContainer
			this._buttonsContainer = new ScrollContainer();
			this._buttonsContainer.layout = this.hLayout;
			this._container.addChild(this._buttonsContainer);
			//buttons 
			this._cancelBtn = new Button();
			this._cancelBtn.label = "Cancel";
			this._buttonsContainer.addChild(this._cancelBtn);
			this._exitBtn = new Button();
			this._exitBtn.label = "Exit";
			this._buttonsContainer.addChild(this._exitBtn);
			//event listener
			//			this._submitBtn.onRelease.add(submitButtonOnRelease);
			this._cancelBtn.addEventListener(starling.events.Event.TRIGGERED,cancelButtonOnRelease);
			//			this._nextBtn.onRelease.add(nextButtonOnRelease);
			this._exitBtn.addEventListener(starling.events.Event.TRIGGERED,exitButtonOnRelease);
			//
			this._header.title = "Confirm exit?";
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
		//
		private function cancelButtonOnRelease(event:Event):void
		{
			PopUpManager.removePopUp(this);
		}
		//
		private function exitButtonOnRelease(event:Event):void
		{
			//Remove the pop-up.
			PopUpManager.removePopUp(this);
			//Screen swither here.
			FlexGlobals.screenNavigator.showScreen(DefaultConstants.SCREEN_MAIN_MENU);
			//Signal broad casting
			this.signal_exit_game.dispatch();
		}
	}
	
}