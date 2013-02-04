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
	import com.godpaper.as3.configs.TextureConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.core.FlexGlobals;
	import com.godpaper.as3.utils.LogUtil;
	
	import feathers.controls.Label;
	import feathers.controls.ProgressBar;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;
	import feathers.core.PopUpManager;
	import feathers.layout.VerticalLayout;
	
	import flash.ui.Keyboard;
	
	import mx.logging.ILogger;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.extensions.PDParticleSystem;
	import starling.extensions.ParticleSystem;
	import starling.text.TextField;
	import starling.textures.Texture;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * SplashScene.as class with customzie subroutines.	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Jul 3, 2012 5:11:09 PM
	 */   	 
	public class SplashScreen extends ScreenBase
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
		private var _container:ScrollContainer;
		
		// member variables
		private var mParticleSystems:Vector.<ParticleSystem>;
		private var mParticleSystem:ParticleSystem;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(SplashScreen);
		
		//Particle system(config,texture)
		[Embed(source="../../../../../assets/particleSystem/particle-snow.pex", mimeType="application/octet-stream")]
		private static const StarParticleConfig:Class;
		
		[Embed(source="../../../../../assets/particleSystem/particle-snow.png")]
		private static const StarParticle:Class;
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
		public function SplashScreen()
		{
			super();
			//Particle system begin!
			var startParticleConfig:XML = XML(new StarParticleConfig());
			var startParticleTexture:Texture = Texture.fromBitmap(new StarParticle());
			//
			mParticleSystems = new <ParticleSystem>[
				new PDParticleSystem(startParticleConfig, startParticleTexture)
			];
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
//			this._label = new TextField(100,20,"LOADING...");
			this._label = new TextField(100,20,this.resourceManager.getString(this.bundleName,"LABEL_LOADING"));
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
			
			//			CursorManager.setBusyCursor();
			// sound initialization takes a moment, so we prepare them here
			if(TextureConfig.fontTextureRequired)
			{
				AssetEmbedsDefault.loadBitmapFonts();
			}
			//Loading complete handler.
//			starling.core.Starling.juggler.delayCall(
			this._progressTween.onComplete =  
			function():void
			{
//				FlexGlobals.screenNavigator.showScreen((DefaultConstants.SCREEN_GAME));//Screen swither here.
				FlexGlobals.screenNavigator.showScreen(DefaultConstants.SCREEN_MAIN_MENU);//Screen swither here.
			};
		}
		//
		override protected function draw():void
		{
			this._container.y = 0;
			this._container.width = this.actualWidth;
			this._container.height = this.actualHeight - this._container.y;
		}
		//
		override protected function screen_addedToStageHandler(event:Event):void
		{
			super.screen_addedToStageHandler(event);
			//
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
			//
			startNextParticleSystem();
		}
		//
		override protected function screen_removedFromStageHandler(event:Event):void
		{
			super.screen_removedFromStageHandler(event);
			//
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKey);
			stage.removeEventListener(TouchEvent.TOUCH, onTouch);
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		private function startNextParticleSystem():void
		{
			if (mParticleSystem)
			{
				mParticleSystem.stop();
				mParticleSystem.removeFromParent();
				Starling.juggler.remove(mParticleSystem);
			}
			
			mParticleSystem = mParticleSystems.shift();
			mParticleSystems.push(mParticleSystem);
			
			mParticleSystem.emitterX = this.stage.stageWidth/2;
			mParticleSystem.emitterY = this.stage.stageHeight;
			mParticleSystem.start();
			
			addChild(mParticleSystem);
			Starling.juggler.add(mParticleSystem);
		}
		
		private function onKey(event:Event, keyCode:uint):void
		{
			if (keyCode == Keyboard.SPACE)
				startNextParticleSystem();
		}
		
		private function onTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(stage);
			if (touch && touch.phase != TouchPhase.HOVER)
			{
				mParticleSystem.emitterX = touch.globalX;
				mParticleSystem.emitterY = touch.globalY;
			}
		}
	}
	
}