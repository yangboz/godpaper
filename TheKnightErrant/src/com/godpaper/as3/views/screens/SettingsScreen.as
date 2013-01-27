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
	import com.godpaper.as3.configs.TextureConfig;
	import com.godpaper.as3.configs.ThemeConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.core.FlexGlobals;
	import com.godpaper.as3.utils.LogUtil;
	
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.PickerList;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;
	import feathers.data.ListCollection;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	
	import flash.system.Capabilities;
	
	import mx.logging.ILogger;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.text.TextField;

	/**
	 * SettingsScreen.as class.This screen providers language and msic settings.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Sep 7, 2012 2:40:07 PM
	 */   	 
	public class SettingsScreen extends ScreenBase
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var _header:Header;
		private var _container:ScrollContainer;
		//
		private var _button_back:Button;
		private var _button_done:Button;
		//for language
		private var _picker_language:PickerList;
		private var _picker_language_item:Array;
		private var _form_language:ScrollContainer;
		private var _label_language:TextField;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static var LOG:ILogger = LogUtil.getLogger(SettingsScreen);
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
		public function SettingsScreen()
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
			const vLayout:VerticalLayout = new VerticalLayout();
			vLayout.gap = 10;
			vLayout.paddingTop = 10;
			vLayout.paddingRight = 10;
			vLayout.paddingBottom = 10;
			vLayout.paddingLeft = 10;
			vLayout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			vLayout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			//
			this._container = new ScrollContainer();
			this._container.layout = vLayout;
			//			this._container.verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			this.addChild(this._container);
			//
			//form grouper
			const hLayout:HorizontalLayout = new HorizontalLayout();
			hLayout.gap = 5;
			hLayout.paddingTop = 10;
			hLayout.paddingRight = 10;
			hLayout.paddingBottom = 10;
			hLayout.paddingLeft = 10;
			hLayout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			hLayout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			//language form
			this._form_language = new ScrollContainer();
			this._form_language.layout = hLayout;
			this._form_language.scrollerProperties.horizontalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			this._container.addChild(this._form_language);
			//Form elements
//			this._label_language = new TextField(80,20,"Languages:");
			this._label_language = new TextField(80,20,this.resourceManager.getString(this.bundleName,"LABEL_LANGUAGE"));
			this._form_language.addChild(this._label_language);
			//
			this._picker_language = new PickerList();
			this._picker_language_item  = [];
			var english:String = this.resourceManager.getString(this.bundleName,"LABEL_ENGLISH");
			var chinese:String = this.resourceManager.getString(this.bundleName,"LABEL_CHINESE");
			var korean:String = this.resourceManager.getString(this.bundleName,"LABEL_KOREAN");
			this._picker_language_item.push({text: english,locale:DefaultConstants.LOCALE_LANG_EN_US});
			this._picker_language_item.push({text: chinese,locale:DefaultConstants.LOCALE_LANG_ZH_CN});
			this._picker_language_item.push({text: korean,locale:DefaultConstants.LOCALE_LANG_KO_KR});
//			this._picker_language_item.fixed = true;
//			this._picker_language.typicalItem = {text: "Choose language"};
			this._picker_language.labelField = "text";
			this._picker_language.dataProvider = new ListCollection(this._picker_language_item);
			this._form_language.addChild(this._picker_language);
			//notice that we're setting labelField on the item renderers
			//separately. the default item renderer has a labelField property,
			//but a custom item renderer may not even have a label, so
			//PickerList cannot simply pass its labelField down to item
			//renderers automatically
			this._picker_language.listProperties.@itemRendererProperties.labelField = "text";
//			this._picker_language.onChange.add(picker_language_onChange);
			this._picker_language.addEventListener(starling.events.Event.CHANGE,picker_language_onChange);
			//
			this._button_done = new Button();
//			this._button_done.label = "Done";
			this._button_done.label = this.resourceManager.getString(this.bundleName,"BTN_DONE");
//			this._button_done.onRelease.add(doneButton_onRelease);
			this._button_done.addEventListener(starling.events.Event.TRIGGERED,doneButton_onRelease);
			//
			this._button_back = new Button();
//			this._button_back.label = "BACK";
			this._button_back.label = this.resourceManager.getString(this.bundleName,"BTN_BACK");
//			this._button_back.onRelease.add(backButton_onRelease);
			this._button_back.addEventListener(starling.events.Event.TRIGGERED,backButton_onRelease);
			//
			this._header = new Header();
//			this._header.title = "Settings";
			this._header.title = this.resourceManager.getString(this.bundleName,"HEADER_SETTINGS");
			this.addChild(this._header);
			this._header.rightItems = new <DisplayObject>
				[
					this._button_done
				];	
			this._header.leftItems = new <DisplayObject>
				[
					this._button_back
				];
		}
		//
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
		private function doneButton_onRelease(event:Event):void
		{
			//TODO:update settings.
			
			//Screen swither here.
			FlexGlobals.screenNavigator.showScreen(DefaultConstants.SCREEN_MAIN_MENU);
		}
		private function backButton_onRelease(event:Event):void
		{
			//Screen swither here.
			FlexGlobals.screenNavigator.showScreen(DefaultConstants.SCREEN_MAIN_MENU);
		}
		//
		private function picker_language_onChange(event:Event):void
		{
			this.resourceManager.localeChain = [this._picker_language.selectedItem.locale];
			FlexGlobals.userModel.locale = this._picker_language.selectedItem.locale;
			this.resourceManager.update();
//			this.dispatchEvent(new ChangeEvent(ChangeEvent.LANG_UPDATE));//TODO:dispatch event to update locale strings.
		}
	}
	
}