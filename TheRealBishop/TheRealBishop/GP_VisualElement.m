//
//  GP_VisualElement.m
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-25.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import "GP_VisualElement.h"
/**
 * UIComponent.as class.(FLEX3)
 * VisualElement.as class.(FLEX4)   	
 * @author yangboz
 * @langVersion 3.0
 * @playerVersion 11.2+
 * @airVersion 3.2+
 * Created Apr 18, 2012 1:57:14 PM
 */   	 
@implementation GP_VisualElement
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
@end
