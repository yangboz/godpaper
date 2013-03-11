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
package com.godpaper.as3.views.plugin
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.configs.ThemeConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.core.FlexGlobals;
	import com.godpaper.as3.plugins.IPlug;
	import com.godpaper.as3.utils.LogUtil;
	import com.godpaper.as3.model.PGN_Model;
	
	import feathers.controls.Button;
	import feathers.controls.ButtonGroup;
	import feathers.controls.Callout;
	import feathers.controls.Label;
	import feathers.controls.TabBar;
	import feathers.data.ListCollection;
	import feathers.skins.IFeathersTheme;
	
	import flash.ui.Mouse;
	
	import mx.logging.ILogger;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.ResizeEvent;
	import starling.text.TextField;
	import starling.textures.TextureAtlas;
	import starling.textures.TextureSmoothing;
	
	
	/**
	 * PGN_PluginButtonBar.as class.For PGN file reading and replaying with (tab bar) control components. 	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Mar 9, 2013 3:44:14 PM
	 */   	 
	public class PGN_PluginButtonBar extends ButtonGroup implements IPluginButtonBar
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var theme:IFeathersTheme;
		//
		private var pgnModel:PGN_Model = PGN_Model.getInstance();
		//
		private var _icon_skip_backward:Image;
		private var _icon_backward:Image;
		private var _icon_play:Image;
		private var _icon_forward:Image;
		private var _icon_skip_forward:Image;
		private var _selectedIcon:Image;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(PGN_PluginButtonBar);
		//Buttonbar action identifer;
		private static const ICON_PLAY:String = "play";
		private static const ICON_FORWARD:String = "forward";
		private static const ICON_BACKWARD:String = "backward";
		private static const ICON_SKIP_FORWARD:String = "skip-forward";
		private static const ICON_SKIP_BACKWARD:String = "skip-backward";
		
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
		public function PGN_PluginButtonBar()
		{
			super();
			//
			this.addEventListener(Event.ADDED_TO_STAGE,addToStageHandler);
			//
			this.direction = ButtonGroup.DIRECTION_HORIZONTAL;
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		override public function dispose():void
		{
			//
			this.removeEventListener(Event.ADDED_TO_STAGE,addToStageHandler);
			if(this.stage)
			{
				this.stage.removeEventListener(ResizeEvent.RESIZE, stageResizeHandler);
			}
			super.dispose();
		}
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		private function addToStageHandler(event:Event):void
		{
			//Signal listener
//			FlexGlobals.levelUpSignal.add(levelUpHandler);
			//Tab bar view initialize
			const isDesktop:Boolean = Mouse.supportsCursor;
			//			this._theme = new AzureTheme(this.stage, !isDesktop);
			//			this.theme = new MinimalTheme(this.stage, !isDesktop);
			//			this.theme = new AeonDesktopTheme(this.stage);
			//			this.theme = new AzureTheme(this.stage, !isDesktop);
			this.theme = ThemeConfig.getThemeImpl(this.stage, !isDesktop);
			//Custom tab bar data provider
			var gameLevel:int = 0;//Should dynnamic and configurable.
			var atlas:TextureAtlas = AssetEmbedsDefault.getTextureAtlas();
			this._icon_skip_backward = new Image(atlas.getTexture(ICON_SKIP_BACKWARD));
			this._icon_skip_backward.smoothing = TextureSmoothing.NONE;
			//			this._icon.scaleX = this._icon.scaleY = this.dpiScale;
			//			this._icon_avatar.scaleX = this._icon_avatar.scaleY = .5;
			this._icon_backward = new Image(atlas.getTexture(ICON_BACKWARD));
			this._icon_backward.smoothing = TextureSmoothing.NONE;
			this._icon_play = new Image(atlas.getTexture(ICON_PLAY));
			this._icon_play.smoothing = TextureSmoothing.NONE;
			this._icon_forward = new Image(atlas.getTexture(ICON_FORWARD));
			this._icon_forward.smoothing = TextureSmoothing.NONE;
			this._icon_skip_forward = new Image(atlas.getTexture(ICON_SKIP_FORWARD));
			this._icon_skip_forward.smoothing = TextureSmoothing.NONE;
			//
			this._selectedIcon = new Image(atlas.getTexture(DefaultConstants.RED));
			this._selectedIcon.smoothing = TextureSmoothing.NONE;
			//			this._selectedIcon.scaleX = this._selectedIcon.scaleY = this.dpiScale;
			this.dataProvider = new ListCollection(
				[
					{ label: "", action: ICON_SKIP_BACKWARD,defaultIcon:_icon_skip_backward,isToggle:false,useHandCursor:true,triggered: button_skip_backward_triggeredHandler},
					{ label: "", action: ICON_BACKWARD,defaultIcon:_icon_backward,isToggle:false,useHandCursor:true,triggered: button_backward_triggeredHandler},
					{ label: "", action: ICON_PLAY,defaultIcon:_icon_play,isToggle:false,useHandCursor:true,triggered: button_play_triggeredHandler},
					{ label: "", action: ICON_FORWARD,defaultIcon:_icon_forward,isToggle:false,useHandCursor:true,triggered: button_forward_triggeredHandler},
					{ label: "", action: ICON_SKIP_FORWARD,defaultIcon:_icon_skip_forward,isToggle:false,useHandCursor:true,triggered: button_skip_forward_triggeredHandler}
				]
			);
			this.validate();
			//
			this.relayout(this.stage.stageWidth, this.stage.stageHeight);
			//
			this.stage.addEventListener(ResizeEvent.RESIZE, stageResizeHandler);
			//Default title
//			const content:Label = new Label();
//			const content:TextField = new TextField(pgnModel.chessbookVO.title.length*10,30,pgnModel.chessbookVO.title);
//			Callout.show(DisplayObject(content), this.getChildAt(2), Callout.DIRECTION_UP);
		}
		//
		private function stageResizeHandler(event:ResizeEvent):void
		{
			this.relayout(event.width, event.height);
		}
		//
		private function relayout(w:Number, h:Number):void
		{
			this.width = w;
			this.x = (w - this.width) / 2;
			this.y = h - this.height;
		}
		//
		private var currentChessbookIndex:int = 0;
		private function button_skip_backward_triggeredHandler(event:starling.events.Event):void
		{
			const button:Button = Button(event.currentTarget);
			//
			currentChessbookIndex  = 0;
			const content0:TextField = new TextField(pgnModel.chessbookVO.title.length*10,30,pgnModel.chessbookVO.body[currentChessbookIndex].redComments);
			Callout.show(DisplayObject(content0), button, Callout.DIRECTION_UP);
			//Apply chess piece move
			this.getChessMoves(currentChessbookIndex);
		}
		//
		private function button_backward_triggeredHandler(event:starling.events.Event):void
		{
			const button:Button = Button(event.currentTarget);
			//
			if(currentChessbookIndex) currentChessbookIndex--;
			const content1:TextField = new TextField(pgnModel.chessbookVO.title.length*10,30,pgnModel.chessbookVO.body[currentChessbookIndex].redMove);
			Callout.show(DisplayObject(content1), button, Callout.DIRECTION_UP);
			//Apply chess piece move
			this.getChessMoves(currentChessbookIndex);
		}
		//
		private function button_play_triggeredHandler(event:starling.events.Event):void
		{
			const button:Button = Button(event.currentTarget);
			//
			//					const content:Label = new Label();
			const content2:TextField = new TextField(pgnModel.chessbookVO.title.length*10,30,pgnModel.chessbookVO.title);
			Callout.show(DisplayObject(content2), button, Callout.DIRECTION_UP);
		}
		//
		private function button_forward_triggeredHandler(event:starling.events.Event):void
		{
			const button:Button = Button(event.currentTarget);
			//
			if(currentChessbookIndex<pgnModel.chessbookVO.body.length-1) currentChessbookIndex++;
			const content3:TextField = new TextField(pgnModel.chessbookVO.title.length*10,30,pgnModel.chessbookVO.body[currentChessbookIndex].blackComments);
			Callout.show(DisplayObject(content3), button, Callout.DIRECTION_UP);
			//Apply chess piece move
			this.getChessMoves(currentChessbookIndex);
		}
		//
		private function button_skip_forward_triggeredHandler(event:starling.events.Event):void
		{
			const button:Button = Button(event.currentTarget);
			//
			currentChessbookIndex  = pgnModel.chessbookVO.body.length-1;
			const content4:TextField = new TextField(pgnModel.chessbookVO.title.length*10,30,pgnModel.chessbookVO.body[currentChessbookIndex].blackMove);
			Callout.show(DisplayObject(content4), button, Callout.DIRECTION_UP);
			//Apply chess piece move
			this.getChessMoves(currentChessbookIndex);
		}
		//
		private function getChessMoves(index:int):Vector.<String>
		{
			var results:Vector.<String> = new Vector.<String>();
			var redMove:String = pgnModel.chessbookVO.body[index].redMove;
			var blackMove:String = pgnModel.chessbookVO.body[index].blackMove;
			LOG.info("redMove:{0}",redMove);
			LOG.info("blackMove:{0}",blackMove);
			results.push(redMove);
			results.push(blackMove);
			return results;
		}
	}
	
}