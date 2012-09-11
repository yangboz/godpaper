//
//  GP_ChessBoard.m
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-29.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import "GP_ChessBoard.h"
/**
 * A chess board is defined by a number of rows and columns, which may vary for different application levels.   	
 * @author yangboz
 * @langVersion 3.0
 * @playerVersion 11.2+
 * @airVersion 3.2+
 * Created Apr 18, 2012 10:01:04 AM
 * @see http://wiki.starling-framework.org/manual/dynamic_textures
 */ 
@implementation GP_ChessBoard
@synthesize xAdjust,xLines,xOffset,xScale;
@synthesize yAdjust,yLines,yOffset,yScale;
//----------------------------------
//  background(CrossLines or Embbed image textures)
//----------------------------------
//private var _background:Image = null;

//public function get background():Image
-(SPImage *)background;
{
//    return _background;
    return background;
}

//public function set background(value:Image):void
-(void)setBackground:(SPImage *)background
{
//    if(value!=null)
//    {
//        if(this.contains(_background))
//        {
//            removeChild(_background);//Remove the existed background at first.
//        }
//        //set anew value
//        _background=value;
//        //Puts on background image.
//        //			var bg:Image = new Image(DefaultEmbededAssets.getTexture(DefaultConstants.IMG_BACK_GROUND));
//        //			addChild(bg);
//        //Display anew backgournd
//        addChild(_background);
//    }
}
//--------------------------------------------------------------------------
//
//  Constructor
//
//--------------------------------------------------------------------------
//public function ChessBoard(background:Texture=null)
-(void)ChessBoard:(SPTexture *)background
{
//    //Binding to the global configured variables
//    this.xLines = BoardConfig.xLines;
//    this.yLines = BoardConfig.yLines;
//    this.xScale = BoardConfig.xScale;
//    this.yScale = BoardConfig.yScale;
//    this.xOffset = BoardConfig.xOffset;
//    this.yOffset = BoardConfig.yOffset;
//    //Does't work,the actual width and height changed every enterframe after the board added to stage.
//    //			this.width = BoardConfig.width;
//    //			this.height = BoardConfig.height;
//    this.xAdjust = BoardConfig.xAdjust;
//    this.yAdjust = BoardConfig.yAdjust;
//    //
//    super(background);
//    //
//    this.touchable = false;
}
//--------------------------------------------------------------------------
//
//  Public methods
//
//--------------------------------------------------------------------------
//public function toString():String
-(NSString *)toString
{
    //return ObjectUtil.toString(this);
    return [super description];//TODO:customize description;
}
#pragma mark GP_IType
-(NSString *)type
{
    return _type;
}
-(void)setType:(NSString *)value
{
    _type = value;
}
@end
