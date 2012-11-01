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
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.core.FlexGlobals;
	import com.godpaper.as3.model.vos.PostVO;
	import com.godpaper.as3.model.vos.UserVO;
	import com.godpaper.as3.utils.LogUtil;
	
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.PickerList;
	import feathers.controls.ProgressBar;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;
	import feathers.data.ListCollection;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	import feathers.motion.GTween;
	
	import flash.events.Event;
	import flash.events.TouchEvent;
	
	import mx.logging.ILogger;
	
	import starling.display.DisplayObject;
	import starling.events.TouchEvent;
	import starling.text.TextField;
	
	/**
	 * HandshakeScreen.as class.The client of the game connects with the listening others by tree-way handshake firstly. 	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Aug 22, 2012 1:52:08 PM
	 */   	 
	public class HandshakeScreen extends ScreenBase
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var _header:Header;
		private var _progressTween:GTween;//Foxhole extended GTween.
		private var _progress:ProgressBar;
//		private var _label:TextField;
		//
		private var _container:ScrollContainer;
		//form grouper
		private var _form_grouper:ScrollContainer;
		//form elements
		private var _label_picker:TextField;
		private var _picker_list:PickerList;
		private var _button_invite:Button;
		private var _picker_list_items:Array = [];
		//response grouper
		private var _response_grouper:ScrollContainer;
		//response elements
		private var _lebel_response:TextField;
		private var _response_list:List;
		private var _button_response:Button;
		private var _response_list_items:Array = [];
		private var _button_back:Button;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(HandshakeScreen);
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
		public function HandshakeScreen()
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
		//
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
//			this._label = new TextField(200,20,"HAND SHAKING...");
//			this._container.addChild(this._label);
			//
			this._progress = new ProgressBar();
			this._progress.minimum = 0;
			this._progress.maximum = 1;
			this._progress.value = 0;
//			this._container.addChild(this._progress);
			//
			this._progressTween = new GTween(this._progress, 5,
				{
					value: 1
				},
				{
					repeatCount: 99
				});
			//Loading subroutines here.
			//			CursorManager.setBusyCursor();
			// sound initialization takes a moment, so we prepare them here
			if(TextureConfig.fontTextureRequired)
			{
				AssetEmbedsDefault.loadBitmapFonts();
			}
			//Loading complete handler.
			this._progressTween.onComplete =  function():void
			{
				//TODO:notify user(try again,keep waitting..).
			}
			//Response grouper
			const hLayout:HorizontalLayout = new HorizontalLayout();
			hLayout.gap = 5;
			hLayout.paddingTop = 10;
			hLayout.paddingRight = 10;
			hLayout.paddingBottom = 10;
			hLayout.paddingLeft = 10;
			hLayout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			hLayout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			//
			this._form_grouper = new ScrollContainer();
			this._form_grouper.layout = hLayout;
			this._form_grouper.scrollerProperties.horizontalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			this._container.addChild(this._form_grouper);
			//Form elements
//			this._label_picker = new TextField(80,20,"neighbors:");
			this._label_picker = new TextField(80,20,this.resourceManager.getString(this.bundleName,"LABEL_NEIGHBORS"));
			this._form_grouper.addChild(this._label_picker);
			//
			this._picker_list = new PickerList();
			this._form_grouper.addChild(this._picker_list);
//			this._picker_list.typicalItem = {text: "Item 1000"};
//			this._picker_list.labelField = "text";
			this._picker_list.width = 150;
			this._picker_list.labelFunction = function trancateLabel(str:String):String
			{
				return str.substr(0, 10)+"..."; 
			}
			//notice that we're setting typicalItem on the list separately. we
			//may want to have the list measure at a different width, so it
			//might need a different typical item than the picker list's button.
//			this._picker_list.listProperties.typicalItem = {text: "Item 1000"};
			//notice that we're setting labelField on the item renderers
			//separately. the default item renderer has a labelField property,
			//but a custom item renderer may not even have a label, so
			//PickerList cannot simply pass its labelField down to item
			//renderers automatically
//			this._picker_list.listProperties.@itemRendererProperties.labelField = "text";
			//
			this._button_invite = new Button();
//			this._button_invite.label = "INVITE";
			this._button_invite.label = this.resourceManager.getString(this.bundleName,"BTN_INVITE");
			this._button_invite.isEnabled = false;
			this._form_grouper.addChild(this._button_invite);
			this._button_invite.onRelease.add(inviteButtonReleaseHandler);
			//
			this._response_grouper = new ScrollContainer();
			this._response_grouper.layout = hLayout;
			this._response_grouper.scrollerProperties.horizontalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			this._container.addChild(this._response_grouper);
			//Form elements
//			this._lebel_response = new TextField(80,20,"invites:");
			this._lebel_response = new TextField(80,20,this.resourceManager.getString(this.bundleName,"LABEL_INVITES"));
			this._response_grouper.addChild(this._lebel_response);
			//
			this._response_list = new List();
			this._response_list.width = 150;
			this._response_list.height = 100;
			this._response_grouper.addChild(this._response_list);
//			this._response_list.labelFunction = function trancateLabel(str:String):String
//			{
//				return str.substr(0, 10)+"..."; 
//			}
//			this._response_list.itemRendererType = ;
			//
			this._button_response = new Button();
//			this._button_response.label = "RESPONSE";
			this._button_response.label = this.resourceManager.getString(this.bundleName,"BTN_RESPONSE");
			this._button_response.isEnabled = false;
			this._response_grouper.addChild(this._button_response);
			this._button_response.onRelease.add(responseButtonReleaseHandler);
			//
			this._button_back = new Button();
			//			this._button_back.label = "BACK";
			this._button_back.label = this.resourceManager.getString(this.bundleName,"BTN_BACK");
			this._button_back.onRelease.add(backButton_onRelease);
			//
			this._header = new Header();
//			this._header.title = "HAND SHAKING...";
			this._header.title = this.resourceManager.getString(this.bundleName,"HEADER_HANDSHAKE");
			this.addChild(this._header);
			this._header.rightItems = new <DisplayObject>
				[
					this._progress
				];
			this._header.leftItems = new <DisplayObject>
				[
					this._button_back
				];
			//Conduct service here.
			FlexGlobals.conductService.initialization(null,null);	
			//Signal watcher
			FlexGlobals.conductService.connectSignal.add(conductConnectHandler);
			FlexGlobals.conductService.disconnectSignal.add(conductDisconnectHandler);
			FlexGlobals.conductService.userVoSignal.add(conductUserVoHandler);
			FlexGlobals.conductService.postVoSignal.add(conductPostVoHandler);
			//_response_list selector
//			this._response_list.addEventListener(Event.CHANGE,responseListChangeHandler);//no more work.
		}
		//
		override protected function draw():void
		{
			this._header.width = this.actualWidth;
			this._header.validate();
			//
			this._container.y = 0;
			this._container.width = this.actualWidth;
			this._container.height = this.actualHeight - this._container.y;
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		//
		private function conductConnectHandler(peerID:String):void
		{
			LOG.info("Conduct connected peerID:{0}",peerID);
			var item:Object = {text: peerID};
			_picker_list_items.push(peerID);
			_picker_list_items.fixed = true;
			this._picker_list.dataProvider = new ListCollection(_picker_list_items);
			//enable invite button
			this._button_invite.isEnabled = true;
		}
		//
		private function conductDisconnectHandler(peerID:String):void
		{
			LOG.info("Conduct disconnected peerID:{0}",peerID);
			var item:Object = {text: peerID};
			var index:int = _picker_list_items.indexOf(peerID);
			_picker_list_items.splice(index,1);
			_picker_list_items.fixed = true;
			this._picker_list.dataProvider = new ListCollection(_picker_list_items);
			//remove related response list item.
			var leftIndex:int = _response_list_items.indexOf(peerID);
			if(leftIndex)
			{
				_response_list_items.splice(leftIndex,1);
				_response_list.dataProvider = new ListCollection(_response_list_items);
				this._button_response.isEnabled = Boolean(_response_list_items.length);
			}
			//disable invite button,if neccessary.
			this._button_invite.isEnabled = Boolean(_picker_list_items.length);
		}
		//
		private function conductUserVoHandler(userVO:UserVO):void
		{
			LOG.info("Conduct userVO:{0}",userVO);
			//@see:https://github.com/joshtynjala/foxhole-starling/wiki/How-to-Use-List
			if(_response_list_items.indexOf(userVO.shortenPeerId)<0)
			{
				_response_list_items.push(userVO.peerID);
			}
//			_response_list_items.fixed = true;
			_response_list.dataProvider = new ListCollection(_response_list_items);
			//only select one request from the invite list.
			this._button_response.isEnabled = Boolean(_response_list_items.length);
			//Screen swither here with data.
			if(userVO.action == UserVO.ACTION_PLAY)
			{
				FlexGlobals.screenNavigator.showScreen(DefaultConstants.SCREEN_GAME);//Screen swither here.
			}
		}
		//
		private function conductPostVoHandler(postVO:PostVO):void
		{
			LOG.info("Conduct postVO:{0}",postVO);
		}
		//
		private function inviteButtonReleaseHandler(button:Button):void
		{
			var postVO:PostVO = new PostVO();
			postVO.peerID = FlexGlobals.userModel.hosterPeerId;
			postVO.roleIndex = FlexGlobals.userModel.hosterRoleIndex;
			postVO.roleName = FlexGlobals.userModel.hostRoleName;
			postVO.action = UserVO.ACTION_IDLE;
			postVO.state = PostVO.STATE_HAND_SHAKE;
			//Post message to net group
			FlexGlobals.conductService.netGroupPost(postVO,this._picker_list.selectedItem.toString());
			//no more invite request,untill none response.
//			this._button_invite.isEnabled = false;
		}
		//
		private function responseButtonReleaseHandler(button:Button):void
		{
			var selectedPeerId:String = (this._response_list.selectedItem==null)?String(this._response_list.dataProvider.data[0]):this._response_list.selectedItem.toString();//if none selection,default index is 0.
			LOG.info("response index:{0},peerid:{1}",this._response_list.selectedIndex,selectedPeerId);
			//Post message to net group
			var postVO:PostVO = new PostVO();
			postVO.peerID = FlexGlobals.userModel.hosterPeerId;
			postVO.roleIndex = FlexGlobals.userModel.hosterRoleIndex;
			postVO.roleName = FlexGlobals.userModel.hostRoleName;
			postVO.action = UserVO.ACTION_PLAY;
			postVO.state = PostVO.STATE_ENTRY;
			FlexGlobals.conductService.netGroupPost(postVO,selectedPeerId);
			//Screen swither here with data.
			FlexGlobals.screenNavigator.showScreen(DefaultConstants.SCREEN_GAME);//Screen swither here.
		}
		//
		private function backButton_onRelease(button:Button):void
		{
			//Screen swither here.
			FlexGlobals.screenNavigator.showScreen(DefaultConstants.SCREEN_MAIN_MENU);
		}
		//
		private function responseListChangeHandler(event:Event):void
		{
			var list:List = List( event.currentTarget );
			LOG.info("response index:{0},peerid:{1}",list.selectedIndex,list.selectedItem);
			//only select one request from the invite list.
			this._button_response.isEnabled = true;
		}
	}
	
}