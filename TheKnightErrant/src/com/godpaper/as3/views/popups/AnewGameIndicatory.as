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
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.core.FlexGlobals;
	import com.godpaper.as3.plugins.playerIO.PlayerIoPlugin;
	
	import feathers.controls.Button;
	import feathers.controls.Callout;
	import feathers.controls.Label;
	import feathers.controls.ScrollContainer;
	import feathers.controls.TextInput;
	import feathers.core.PopUpManager;
	
	import starling.display.DisplayObject;
	import starling.events.Event;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * AnewGameIndicatory.as class.Create a new game by hoster.</br>
	 * Example skelton as follows:</br>	
	 * -----------------------------------</br>
	 * ----------Create new game----------</br>
	 * -----------------------------------</br>
	 * -----------------------------------</br>
	 * ------------TextInput--------------</br>
	 * -----------------------------------</br>
	 * -----------------------------------</br>
	 * -------CANCEL---------CREATE-------</br>
	 * -----------------------------------</br>
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Feb 3, 2013 5:11:32 PM
	 */   	 
	public class AnewGameIndicatory extends IndicatoryBase
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var _nameInput:TextInput;
		private var _inputsContainer:ScrollContainer;
		private var _buttonsContainer:ScrollContainer;//submit,next button 
		private var _cancelBtn:Button;//camcel creating game button.
		private var _createBtn:Button;//create a new game button.
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
		public function AnewGameIndicatory()
		{
			super();
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
			this._inputsContainer = new ScrollContainer();
			this._inputsContainer.layout = this.vLayout;
			this._container.addChild(this._inputsContainer);
			this._buttonsContainer = new ScrollContainer();
			this._buttonsContainer.layout = this.hLayout;
			this._container.addChild(this._buttonsContainer);
			//text inputs
			this._nameInput = new TextInput();
			this._nameInput.height = 25;
			this._nameInput.width = 125;
			this._nameInput.text = "Amazing chess game!";
			this._inputsContainer.addChild(this._nameInput);
			//buttons 
			this._cancelBtn = new Button();
			this._cancelBtn.label = "Cancel";
			this._buttonsContainer.addChild(this._cancelBtn);
			this._createBtn = new Button();
			this._createBtn.label = "Create";
			this._buttonsContainer.addChild(this._createBtn);
			//event listener
			//			this._submitBtn.onRelease.add(submitButtonOnRelease);
			this._cancelBtn.addEventListener(starling.events.Event.TRIGGERED,cancelButtonOnRelease);
			//			this._nextBtn.onRelease.add(nextButtonOnRelease);
			this._createBtn.addEventListener(starling.events.Event.TRIGGERED,createButtonOnRelease);
			//
			this._header.title = DefaultConstants.INDICATION_NAME_PROMPT_GAME;
			this.width = 200;
			this.height = 200;
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
		private function createButtonOnRelease(event:Event):void
		{
			if(this._nameInput.text.length<=0)//name text input validate.
			{
				const content:Label = new Label();
				content.text = "Please input game name!";
				Callout.show(DisplayObject(content), this._nameInput, Callout.DIRECTION_LEFT);
				return;
			}
			//Set up a new game room here.
			var playerIoPlugin:PlayerIoPlugin = (FlexGlobals.topLevelApplication.pluginProvider as PlayerIoPlugin);
			if( playerIoPlugin )
			{
				playerIoPlugin.createJoinRoom(this._nameInput.text);
			}
			
		}
	}
	
}