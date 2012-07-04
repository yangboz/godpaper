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
package com.godpaper.as3.views.plugin
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.configs.IndicatorConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.core.FlexGlobals;
	import com.godpaper.as3.plugins.IPlug;
	import com.godpaper.as3.utils.LogUtil;
	import com.godpaper.as3.views.popups.ThinkIndicatory;
	
	import flash.ui.Mouse;
	
	import mx.logging.ILogger;
	
	import org.josht.starling.foxhole.controls.Button;
	import org.josht.starling.foxhole.controls.Callout;
	import org.josht.starling.foxhole.controls.Label;
	import org.josht.starling.foxhole.controls.TabBar;
	import org.josht.starling.foxhole.data.ListCollection;
	import org.josht.starling.foxhole.themes.IFoxholeTheme;
	import org.josht.starling.foxhole.themes.MinimalTheme;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.ResizeEvent;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.textures.TextureSmoothing;
	
	
	/**
	 * Extending the foxhole UI component(TabBar) with customzie data provider,make it configurable and plugin-able.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Jun 19, 2012 12:53:29 PM
	 */   	 
	public class PluginButtonBar extends TabBar
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var theme:IFoxholeTheme;
		//
		private var _icon_avatar:Image;
		private var _icon_store:Image;
		private var _icon_coin:Image;
		private var _icon_account:Image;
		private var _selectedIcon:Image;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(PluginButtonBar);
		//Buttonbar action identifer;
		private static const ICON_TOLLGATE:String = "ICON_TOLLGATE_";
		private static const ICON_STORE:String = "ICON_STORE";
		private static const ICON_COIN:String = "ICON_COIN";
		private static const ICON_ACCOUNT:String = "ICON_ACCOUNT";
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
		public function PluginButtonBar()
		{
			super();
			//
			this.addEventListener(Event.ADDED_TO_STAGE,addToStageHandler);
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
			this.stage.removeEventListener(ResizeEvent.RESIZE, stageResizeHandler);
			super.dispose();
		}
		//Signal message handler
		public function levelUpHandler(level:int):void
		{
//			var btnBarBtn:ButtonBarButton=this.dataGroup.getElementAt(0) as ButtonBarButton;
//			btnBarBtn.skin["iconImage"]["source"]=GameConfig.tollgates[GameConfig.gameStateManager.level].icon;
//			btnBarBtn.toolTip = GameConfig.tollgates[GameConfig.gameStateManager.level].tips;
		}
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		//
		protected function get iPlug():IPlug
		{
			return IPlug(FlexGlobals.topLevelApplication.pluginUIComponent.provider);
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		private function addToStageHandler(event:Event):void
		{
			//Signal listener
			FlexGlobals.levelUpSignal.add(levelUpHandler);
			//Tab bar view initialize
			const isDesktop:Boolean = Mouse.supportsCursor;
			//			this._theme = new AzureTheme(this.stage, !isDesktop);
			this.theme = new MinimalTheme(this.stage, !isDesktop);
			//Custom tab bar data provider
			var gameLevel:int = 0;//Should dynnamic and configurable.
			var atlas:TextureAtlas = AssetEmbedsDefault.getTextureAtlas();
			this._icon_avatar = new Image(atlas.getTexture(ICON_TOLLGATE.concat(gameLevel)));
			this._icon_avatar.smoothing = TextureSmoothing.NONE;
//			this._icon.scaleX = this._icon.scaleY = this.dpiScale;
//			this._icon_avatar.scaleX = this._icon_avatar.scaleY = .5;
			this._icon_store = new Image(atlas.getTexture(ICON_STORE));
			this._icon_store.smoothing = TextureSmoothing.NONE;
			this._icon_coin = new Image(atlas.getTexture(ICON_COIN));
			this._icon_coin.smoothing = TextureSmoothing.NONE;
			this._icon_account = new Image(atlas.getTexture(ICON_ACCOUNT));
			this._icon_account.smoothing = TextureSmoothing.NONE;
			
			this._selectedIcon = new Image(atlas.getTexture(DefaultConstants.RED));
			this._selectedIcon.smoothing = TextureSmoothing.NONE;
//			this._selectedIcon.scaleX = this._selectedIcon.scaleY = this.dpiScale;
			this.dataProvider = new ListCollection(
				[
					{ label: "", action: ICON_TOLLGATE,defaultIcon:_icon_avatar,isToggle:true,useHandCursor:true},
					{ label: "", action: ICON_STORE,defaultIcon:_icon_store,isToggle:true},
					{ label: "", action: ICON_COIN,defaultIcon:_icon_coin,isToggle:true},
					{ label: "", action: ICON_ACCOUNT,defaultIcon:_icon_account,isToggle:true}
				]
			);
			this.validate();
			this.onChange.add(tabBarChangeHandler);
			//
			this.relayout(this.stage.stageWidth, this.stage.stageHeight);
			//
			this.stage.addEventListener(ResizeEvent.RESIZE, stageResizeHandler);
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
		private function tabBarChangeHandler(tabBar:TabBar):void
		{
//			LOG.debug("change action:{0}",tabBar.selectedItem.action);
			switch (tabBar.selectedItem.action)
			{
				case ICON_TOLLGATE: //tollgate
					iPlug.showData();
					break;
				case ICON_STORE: //store
					iPlug.showStore();
					break;
				case ICON_COIN: //coin,leadboard
					iPlug.showLeaderboard({boardID: iPlug.data.boardID});
					break;
				case ICON_ACCOUNT: //account
					//
					iPlug.showLoginWidget();
					break;
				default:
					break;
			}
		}
	}
	
}