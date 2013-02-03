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
package com.godpaper.as3.views.screens
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.controls.PageIndicator;
	import feathers.controls.Screen;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.layout.TiledRowsLayout;
	import feathers.text.BitmapFontTextFormat;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.ResizeEvent;
	import starling.text.BitmapFont;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	/**
	 * LobbyScreen.as class. All players should waited for others in the game lobby at first. 	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Feb 3, 2013 11:48:45 AM
	 */   	 
	public class LobbyScreen extends Screen
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var _iconAtlas:TextureAtlas;
		private var _font:BitmapFont;
		private var _list:List;
		private var _pageIndicator:PageIndicator;
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
		public function LobbyScreen()
		{
			super();
			//
			this._iconAtlas = AssetEmbedsDefault.getTextureAtlas();
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
		protected function layout():void
		{
			this._pageIndicator.width = this.stage.stageWidth;
			this._pageIndicator.validate();
			this._pageIndicator.y = this.stage.stageHeight - this._pageIndicator.height;
			
			const shorterSide:Number = Math.min(this.stage.stageWidth, this.stage.stageHeight);
			const layout:TiledRowsLayout = TiledRowsLayout(this._list.layout);
			layout.paddingTop = layout.paddingRight = layout.paddingBottom =
				layout.paddingLeft = shorterSide * 0.06;
			layout.gap = shorterSide * 0.04;
			
			this._list.itemRendererProperties.gap = shorterSide * 0.01;
			
			this._list.width = this.stage.stageWidth;
			this._list.height = this._pageIndicator.y;
			this._list.validate();
			
			this._pageIndicator.pageCount = Math.ceil(this._list.maxHorizontalScrollPosition / this._list.width) + 1;
		}
		//
		override protected function initialize():void
		{
			this.stage.addEventListener(ResizeEvent.RESIZE, stage_resizeHandler);
			
			const collection:ListCollection = new ListCollection(
				[
					{ label: "Facebook", texture: this._iconAtlas.getTexture("TABLE") },
					{ label: "Twitter", texture: this._iconAtlas.getTexture("TABLE") },
					{ label: "Google", texture: this._iconAtlas.getTexture("TABLE") },
					{ label: "YouTube", texture: this._iconAtlas.getTexture("TABLE") },
					{ label: "StumbleUpon", texture: this._iconAtlas.getTexture("TABLE") },
					{ label: "Yahoo", texture: this._iconAtlas.getTexture("TABLE") },
					{ label: "Tumblr", texture: this._iconAtlas.getTexture("TABLE") },
					{ label: "Blogger", texture: this._iconAtlas.getTexture("TABLE") },
					{ label: "Reddit", texture: this._iconAtlas.getTexture("TABLE") },
					{ label: "Flickr", texture: this._iconAtlas.getTexture("TABLE") },
					{ label: "Yelp", texture: this._iconAtlas.getTexture("TABLE") },
					{ label: "Vimeo", texture: this._iconAtlas.getTexture("TABLE") },
					{ label: "LinkedIn", texture: this._iconAtlas.getTexture("TABLE") },
					{ label: "Delicious", texture: this._iconAtlas.getTexture("TABLE") },
					{ label: "FriendFeed", texture: this._iconAtlas.getTexture("TABLE") },
					{ label: "MySpace", texture: this._iconAtlas.getTexture("TABLE") },
					{ label: "Digg", texture: this._iconAtlas.getTexture("TABLE") },
					{ label: "DeviantArt", texture: this._iconAtlas.getTexture("TABLE") },
					{ label: "Picasa", texture: this._iconAtlas.getTexture("TABLE") },
					{ label: "LiveJournal", texture: this._iconAtlas.getTexture("TABLE") },
					{ label: "Slashdot", texture: this._iconAtlas.getTexture("TABLE") },
					{ label: "Bebo", texture: this._iconAtlas.getTexture("TABLE") },
					{ label: "Viddler", texture: this._iconAtlas.getTexture("TABLE") },
					{ label: "Newsvine", texture: this._iconAtlas.getTexture("TABLE") },
					{ label: "Posterous", texture: this._iconAtlas.getTexture("TABLE") },
					{ label: "Orkut", texture: this._iconAtlas.getTexture("TABLE") },
				]);
			
			const listLayout:TiledRowsLayout = new TiledRowsLayout();
			listLayout.paging = TiledRowsLayout.PAGING_HORIZONTAL;
			listLayout.useSquareTiles = false;
			listLayout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_CENTER;
			listLayout.horizontalAlign = TiledRowsLayout.HORIZONTAL_ALIGN_CENTER;
			
			this._list = new List();
			this._list.dataProvider = collection;
			this._list.layout = listLayout;
//			this._list.snapToPages = true;
//			this._list.scrollBarDisplayMode = List.SCROLL_BAR_DISPLAY_MODE_NONE;
//			this._list.horizontalScrollPolicy = List.SCROLL_POLICY_ON;
			this._list.itemRendererFactory = tileListItemRendererFactory;
			this._list.addEventListener(Event.SCROLL, list_scrollHandler);
			this.addChild(this._list);
			
			const normalSymbolTexture:Texture = this._iconAtlas.getTexture("normal-page-symbol");
			const selectedSymbolTexture:Texture = this._iconAtlas.getTexture("selected-page-symbol");
			this._pageIndicator = new PageIndicator();
			this._pageIndicator.normalSymbolFactory = function():Image
			{
				return new Image(normalSymbolTexture);
			}
			this._pageIndicator.selectedSymbolFactory = function():Image
			{
				return new Image(selectedSymbolTexture);
			}
			this._pageIndicator.direction = PageIndicator.DIRECTION_HORIZONTAL;
			this._pageIndicator.pageCount = 1;
			this._pageIndicator.gap = 3;
			this._pageIndicator.paddingTop = this._pageIndicator.paddingRight = this._pageIndicator.paddingBottom =
				this._pageIndicator.paddingLeft = 6;
			this._pageIndicator.addEventListener(Event.CHANGE, pageIndicator_changeHandler);
			this.addChild(this._pageIndicator);
			
			this.layout();
		}
		//
		protected function tileListItemRendererFactory():IListItemRenderer
		{
			const renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
			renderer.labelField = "label";
			renderer.iconSourceField = "texture";
			renderer.iconPosition = Button.ICON_POSITION_TOP;
//			renderer.defaultLabelProperties.textFormat = new BitmapFontTextFormat(this._font, NaN, 0x000000);
			return renderer;
		}
		//
		protected function list_scrollHandler(event:Event):void
		{
			this._pageIndicator.selectedIndex = this._list.horizontalPageIndex;
		}
		//
		protected function pageIndicator_changeHandler(event:Event):void
		{
			this._list.scrollToPageIndex(this._pageIndicator.selectedIndex, 0, 0.25);
		}
		//
		protected function stage_resizeHandler(event:ResizeEvent):void
		{
			this.layout();
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}
	
}