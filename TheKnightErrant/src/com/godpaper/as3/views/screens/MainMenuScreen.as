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
package com.godpaper.as3.views.screens
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.configs.GameConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.core.FlexGlobals;
	
	import flash.geom.Rectangle;
	
	import org.josht.starling.foxhole.controls.Button;
	import org.josht.starling.foxhole.controls.Screen;
	import org.josht.starling.foxhole.controls.ScreenHeader;
	import org.josht.starling.foxhole.controls.ScrollContainer;
	import org.josht.starling.foxhole.controls.Scroller;
	import org.josht.starling.foxhole.layout.VerticalLayout;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	
	import starling.display.DisplayObject;
	
	
	/**
	 * MainMenuScreen.as class.Create an exciting and dynamic main menu screen for your game.	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Jul 4, 2012 3:26:43 PM
	 */   	 
	public class MainMenuScreen extends Screen
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//
		private var _container:ScrollContainer;
		private var _header:ScreenHeader;
		private var _settingsButton:Button;
		//Menu buttons
		private var _singlePlayButton:Button;
		private var _multiPlayButton:Button;
		private var _creditButton:Button;
		private var _helpButton:Button;
		private var _aboutButton:Button;
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
			
			this._container = new ScrollContainer();
			this._container.layout = layout;
			this._container.verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			this.addChild(this._container);
			//
			_singlePlayButton = new Button();
			_singlePlayButton.label = "Single Play";
			_singlePlayButton.width =  200 * this.dpiScale;
			_singlePlayButton.height = 100 * this.dpiScale;
			_singlePlayButton.onRelease.addOnce(singlePlayButton_onRelease);
			this._container.addChild(_singlePlayButton);
//			this.addChild(_singlePlayButton);
			//
			_multiPlayButton = new Button();
			_multiPlayButton.label = "Multi Play";
			_multiPlayButton.width  = 200 * this.dpiScale;
			_multiPlayButton.height = 100 * this.dpiScale;
			_multiPlayButton.onRelease.addOnce(multiPlayButton_onRelease);
			this._container.addChild(_multiPlayButton);
//			this.addChild(_multiPlayButton);
			//
			this._settingsButton = new Button();
			this._settingsButton.label = "Settings";
			this._settingsButton.onRelease.add(settingsButton_onRelease);
			//
			this._header = new ScreenHeader();
			this._header.title = "Main Menu";
			this.addChild(this._header);
			this._header.rightItems = new <DisplayObject>
				[
					this._settingsButton
				];
			
		}
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function MainMenuScreen()
		{
			super();
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		private var _onSettings:Signal = new Signal();//TODO:with setting screen.
		public function get onSettings():ISignal
		{
			return this._onSettings;
		}
		//
//		override public function dispose():void
//		{
//			this._container.dispose();
//			super.dispose();
//		}
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		override protected function draw():void
		{
			this._header.width = this.actualWidth;
			this._header.validate();
			
			this._container.y = this._header.height;
			this._container.width = this.actualWidth;
			this._container.height = this.actualHeight - this._container.y;
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		private function settingsButton_onRelease(button:Button):void
		{
			this._onSettings.dispatch(this);
		}
		//
		private function singlePlayButton_onRelease(button:Button):void
		{
			//Register the play mode of game.
			GameConfig.playMode = GameConfig.HUMAN_VS_COMPUTER;
			//Screen swither here.
			FlexGlobals.screenNavigator.showScreen(DefaultConstants.SCREEN_GAME);
		}
		//
		private function multiPlayButton_onRelease(button:Button):void
		{
			//Register the play mode of game.
			GameConfig.playMode = GameConfig.HUMAN_VS_HUMAN;
			//Screen swither here.
			FlexGlobals.screenNavigator.showScreen(DefaultConstants.SCREEN_HANDSHAKE);
//			FlexGlobals.screenNavigator.showScreen(DefaultConstants.SCREEN_GAME);
		}
	}
	
}