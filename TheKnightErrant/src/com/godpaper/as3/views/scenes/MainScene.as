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
package com.godpaper.as3.views.scenes
{
	import com.godpaper.as3.configs.GameConfig;
	import com.godpaper.as3.configs.ThemeConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.core.FlexGlobals;
	import com.godpaper.as3.utils.LogUtil;
	import com.godpaper.as3.views.screens.GameScreen;
	import com.godpaper.as3.views.screens.MainMenuScreen;
	import com.godpaper.as3.views.screens.SplashScreen;
	import com.gskinner.motion.easing.Cubic;
	
	import flash.ui.Mouse;
	
	import mx.core.ClassFactory;
	import mx.logging.ILogger;
	
	import org.josht.starling.foxhole.controls.FPSDisplay;
	import org.josht.starling.foxhole.controls.ScreenNavigator;
	import org.josht.starling.foxhole.controls.ScreenNavigatorItem;
	import org.josht.starling.foxhole.themes.AeonDesktopTheme;
	import org.josht.starling.foxhole.themes.AzureTheme;
	import org.josht.starling.foxhole.themes.IFoxholeTheme;
	import org.josht.starling.foxhole.themes.MinimalTheme;
	import org.josht.starling.foxhole.transitions.ScreenSlidingStackTransitionManager;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.ResizeEvent;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * MainScene.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Jul 3, 2012 5:20:17 PM
	 */   	 
	public class MainScene extends SceneBase
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var _theme:IFoxholeTheme;
		private var _navigator:ScreenNavigator;
		private var _transitionManager:ScreenSlidingStackTransitionManager;
//		private var _fps:FPSDisplay;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(MainScene);
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
		public function MainScene()
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
		override protected function addToStageHandler(event:Event):void
		{
			//this is supposed to be an example mobile app, but it is also shown
			//as a preview in Flash Player on the web. we're making a special
			//case to pretend that the web SWF is running in the theme's "ideal"
			//DPI. official themes usually target an iPhone Retina display.
			const isDesktop:Boolean = Mouse.supportsCursor;
//			this._theme = new MinimalTheme(this.stage, !isDesktop);
//			this._theme = new AeonDesktopTheme(this.stage);
//			this._theme = new AzureTheme(this.stage, !isDesktop);
			this._theme = ThemeConfig.getThemeImpl(this.stage, !isDesktop);
			const originalThemeDPI:int = this._theme.originalDPI;
			
			this._navigator = new ScreenNavigator();
			this.addChild(this._navigator);
			//
			this._navigator.addScreen(DefaultConstants.SCREEN_SPLASH, new ScreenNavigatorItem(SplashScreen));
			this._navigator.addScreen(DefaultConstants.SCREEN_MAIN_MENU, new ScreenNavigatorItem(MainMenuScreen));
			this._navigator.addScreen(DefaultConstants.SCREEN_GAME, new ScreenNavigatorItem(GameScreen));
			
			//Store the navigator ref to FlexGlobals.
			FlexGlobals.screenNavigator = this._navigator;
			FlexGlobals.screenNavigator.showScreen((DefaultConstants.SCREEN_SPLASH));//Screen swither here.
			
			this._transitionManager = new ScreenSlidingStackTransitionManager(this._navigator);
			this._transitionManager.duration = 0.4;
			this._transitionManager.ease = Cubic.easeOut;
			
//			this._fps = new FPSDisplay();
//			this.stage.addChild(this._fps);
//			this._fps.validate();
//			this._fps.y = this.stage.stageHeight - this._fps.height;
//			this.stage.addEventListener(ResizeEvent.RESIZE, stage_resizeHandler);
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
//		private function stage_resizeHandler(event:ResizeEvent):void
//		{
//			this._fps.validate();
//			this._fps.y = this.stage.stageHeight - this._fps.height;
//		}
	}
	
}