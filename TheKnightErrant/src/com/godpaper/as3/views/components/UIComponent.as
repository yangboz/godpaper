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
package com.godpaper.as3.views.components
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.core.IVisualElement;
	
	import mx.utils.UIDUtil;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	
	/**
	 * UIComponent.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Apr 18, 2012 1:57:14 PM
	 */   	 
	public class UIComponent extends Sprite implements IVisualElement
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		//----------------------------------
		//  background(CrossLines or Embbed image textures)
		//----------------------------------
		private var _background:Image = null;
		public function get background():Image
		{
			return _background;
		}
		public function set background(value:Image):void
		{
			if(value!=null)
			{
				if(this.contains(_background))
				{
					removeChild(_background);//Remove the existed background at first.
				}
				//set anew value
				_background=value;
				//Puts on background image.
				//			var bg:Image = new Image(DefaultEmbededAssets.getTexture(DefaultConstants.IMG_BACK_GROUND));
				//			addChild(bg);
				//Display anew backgournd
				addChild(_background);
			}else//Draw to render the program background.
			{
				this.backgroundRender();
			}
		}
		//----------------------------------
		//  label
		//----------------------------------
		private var _label:String;
		public function set label(value:String):void
		{
			_label = value;
		}
		public function get label():String
		{
			return _label;
		}
		//----------------------------------
		//  uid
		//----------------------------------
		private var _uid:String;
		public function get uid():String
		{
			return _uid;
		}
		public function set uid(value:String):void
		{
			_uid = value;
		}
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
		public function UIComponent()
		{
			super();
			//uid creation.
			this.uid = UIDUtil.createUID();
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
		protected function backgroundRender():void
		{
			//TODO:with customize override.
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}
	
}