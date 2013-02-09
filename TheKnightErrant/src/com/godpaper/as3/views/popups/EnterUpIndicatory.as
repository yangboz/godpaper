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
	
	import feathers.controls.Button;
	import feathers.controls.Callout;
	import feathers.controls.Label;
	import feathers.controls.ScrollContainer;
	import feathers.controls.TextInput;
	
	import mx.utils.UIDUtil;
	
	import starling.display.DisplayObject;
	import starling.events.Event;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * EnterUpIndicatory.as class.To register player's name before enter up to lobby screen.</br>
	 * Example skelton as follows:</br>	
	 * -----------------------------------</br>
	 * --------What's your name?----------</br>
	 * -----------------------------------</br>
	 * -----------------------------------</br>
	 * ------------TextInput--------------</br>
	 * -----------------------------------</br>
	 * -----------------------------------</br>
	 * ------------Join Game--------------</br>
	 * -----------------------------------</br>
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Feb 3, 2013 3:31:00 PM
	 */   	 
	public class EnterUpIndicatory extends IndicatoryBase
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var _nameInput:TextInput;
		private var _inputsContainer:ScrollContainer;
		private var _buttonsContainer:ScrollContainer;//submit,next button 
		private var _joinBtn:Button;//join gamebutton.
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
		public function EnterUpIndicatory()
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
			this._inputsContainer.addChild(this._nameInput);
			//buttons 
			this._joinBtn = new Button();
			this._joinBtn.label = "Enter Lobby";
			this._buttonsContainer.addChild(this._joinBtn);
			//event listener
			//			this._submitBtn.onRelease.add(submitButtonOnRelease);
			this._joinBtn.addEventListener(starling.events.Event.TRIGGERED,joinButtonOnRelease);
			//
			this._header.title = DefaultConstants.INDICATION_NAME_PROMPT_PLAYER;
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
		private function joinButtonOnRelease(event:Event):void
		{
			if(this._nameInput.text.length<=0)//name text input validate.
			{
				const content:Label = new Label();
				content.text = "Please input your name!";
				Callout.show(DisplayObject(content), this._nameInput, Callout.DIRECTION_LEFT);
				return;
			}
			//Register player role name
			var peerID:String = UIDUtil.createUID();
			FlexGlobals.userModel.addUser(peerID);
			FlexGlobals.userModel.hostRoleName = this._nameInput.text;
			FlexGlobals.userModel.registerRole(peerID,1,FlexGlobals.userModel.ROLE_NAME_LIST[1]);
			//Enter up to game server by plugin initialization.
			FlexGlobals.topLevelApplication.pluginProvider.initialization();
		}
	}
	
}