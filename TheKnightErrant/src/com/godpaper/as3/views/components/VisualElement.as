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
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	import mx.utils.ObjectUtil;
	import mx.utils.UIDUtil;
	
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.utils.Color;
	
	
	/**
	 * UIComponent.as class.(FLEX3)
	 * VisualElement.as class.(FLEX4)   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Apr 18, 2012 1:57:14 PM
	 */   	 
	public class VisualElement extends RoundButton implements IVisualElement
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
		//  uid
		//----------------------------------
		private var _uid:String;
		/**
		 *  The unique identifier(uid) for this object.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 */
		public function get uid():String
		{
			return _uid;
		}
		
		/**
		 *  @private
		 */
		public function set uid(value:String):void
		{
			_uid = value;
		}
		//----------------------------------
		//  label
		//----------------------------------
		private var _label:String;
		/**
		 *  The common identifier(label) for this object.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 */
		public function get label():String
		{
			return _label;
		}
		
		/**
		 *  @private
		 */
		public function set label(value:String):void
		{
			_label = value;
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
		public function VisualElement(upState:Texture=null, label:String="", downState:Texture=null)
		{
			//uid creation.
			this.uid = UIDUtil.createUID();
			//Initialize the uid
			this.uid = UIDUtil.createUID();
			this.label = label;
			//Default texture setting here.
			var defaultUpState:Texture = upState;
			if(defaultUpState==null)
			{
				defaultUpState = this.getUpStateTexture(Color.BLACK,1,Color.BLACK,1);
				//				var atlas:TextureAtlas = DefaultEmbededAssets.getTextureAtlas();
				//				defaultUpState = atlas.getTexture(DefaultConstants.BLUE_BISHOP);
			}
			//			this.background = new Image(defaultUpState);
			//
			super(defaultUpState, text, downState);
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		public function toString():String
		{
			return ObjectUtil.toString(this);
		}
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		//Custom render the texture with the global gasket configuration.
		protected function getUpStateTexture(bgColor:uint,bgAlpha:Number,borderColor:uint,borderAlpha:Number):Texture
		{
			//Temp graphic objects tests.
			//@see:http://wiki.starling-framework.org/manual/dynamic_textures
			//			Polygon
			//			var polygon:Polygon = new Polygon(50,4,Color.NAVY);
			//			polygon.x = 100;
			//			polygon.y = 100;
			//			polygon.pivotX = 0;
			//			polygon.pivotY = 0;
			//			polygon.rotation = 30;
			//			addChild(polygon);
			//Draw a circle shape
			var shape:Sprite = new Sprite();
			//			var shape:Shape = new Shape();
			shape.graphics.beginFill(bgColor,bgAlpha);
			shape.graphics.lineStyle(1,borderColor,1);
//			var radius:Number = Math.min(GasketConfig.width,GasketConfig.height)/2;
			//			shape.graphics.drawCircle(GasketConfig.width/2,GasketConfig.height/2,radius);
			shape.graphics.drawRect(0,0,this.width,this.height);
			shape.graphics.endFill();
			//But we can draw that shape into a bitmap and then create a texture from that bitmap! 
			var bmpData:BitmapData = new BitmapData(this.width, this.height, true, 0x0);
			bmpData.draw(shape);
			//
			var texture:Texture = Texture.fromBitmapData(bmpData);
			//			var image:Image = new Image(texture);
			//			addChild(image);
			//
			return texture;
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}
	
}