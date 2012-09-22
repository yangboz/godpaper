//
//  GP_BoardConfig.m
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-9-16.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import "GP_BoardConfig.h"

@implementation GP_BoardConfig
//global board config.
//    public static var xLines:Number=4;
//    public static var yLines:Number=4;
static uint _xLines=4,_yLines=4;
//board scale
//    public static var xScale:Number=1;
//    public static var yScale:Number=1;
static uint _xScale=1,_yScale=1;
//board lattic
//    public static var xOffset:Number=50;
//    public static var yOffset:Number=50;
static uint _xOffset=50,_yOffset=50;
//board size
//    public static function get height():Number
//    {
//        return (BoardConfig.yLines-1)*BoardConfig.yOffset+BoardConfig.yAdjust*2;
//    }
//static uint _height;
//
//    public static function get width():Number
//    {
//        return (BoardConfig.xLines-1)*BoardConfig.xOffset+BoardConfig.xAdjust*2;
//    }
//static uint _width;
//board background
//		private static var _backGround:Class;
//board x,y position adjust
//    public static var xAdjust:Number=50;
//    public static var yAdjust:Number=50;
static uint _xAdjust=50,_yAdjust=50;
//connex directions
//    public static var hConnex:Boolean=false; //horizontally connection flag.
//    public static var vConnex:Boolean=false; //vertically connection flag.
//    public static var fdConnex:Boolean=false; //forward diagonally connection flag.
//    public static var bdConnex:Boolean=false; //backward diagonally connection flag.
//    public static var numConnex:Number;//the number of connex in each direction.
static BOOL _hConnex,_vConnex,_fdConnex,_bdConnex,_numConex;
//background image texture.
//		var chessBoardBackground:Image = new Image(AssetEmbedsDefault.getTexture(DefaultConstants.IMG_BACK_GROUND));
//		public static var backgroundImage:Image= null;//The chess board's backgroud texture;
//
//    public static var backgroundImageRequired:Boolean = false;
//    public static function get backgroundImage():Image
//    {
//        if(!backgroundImageRequired) return null;
//        return new Image(AssetEmbedsDefault.getTexture_cp_bg(DefaultConstants.IMG_BACK_GROUND));
//    }
static BOOL _backgroundImageRequired;
//static SPImage *_backgroundImage;
//Pieces box relevant variables.
//    public static var piecesBoxRequired:Boolean = false;//For partical chess board game with pieces box component view;
//    public static var piecesBoxBgImage:Image=null;//The chess pieces box 's backgroud texture;
static BOOL _piecesBoxRequired;
static SPImage *_piecesBoxBgImage;
//public static var type:String = null;//type customize.
static NSString *_type;
//Avoid alloc
+ (id)alloc {
    [NSException raise:@"Cannot be instantiated!" format:@"Static class 'GP_BoardConfig' cannot be instantiated!"];
    return nil;
}
#pragma mark GP_BoardConfig static methods
+(void)setBdConnex:(BOOL)value
{
    _bdConnex = value;
}
+(BOOL)bdConnex
{
    return _bdConnex;
}
//
+(void)setBackgroundImageRequired:(BOOL)value
{
    _backgroundImageRequired = value;
}
+(BOOL)backgroundImageRequired
{
    return _backgroundImageRequired;
}
//
+(void)setFdConnex:(BOOL)value
{
    _fdConnex = value;
}
+(BOOL)fdConnex
{
    return _fdConnex;
}
//
+(void)setHConnex:(BOOL)value
{
    _hConnex = value;
}
+(BOOL)hConnex
{
    return _hConnex;
}
//
+(void)setNumConnex:(uint)value
{
    _numConex = value;
}
+(uint)numConnex
{
    return _numConex;
}
//
+(void)setPiecesBoxBgImage:(SPImage *)value
{
    _piecesBoxBgImage = value;
}
+(SPImage *)piecesBoxBgImage
{
    return _piecesBoxBgImage;
}
//
+(void)setPiecesBoxRequired:(BOOL)value
{
    _piecesBoxRequired = value;
}
+(BOOL)piecesBoxRequired
{
    return _piecesBoxRequired;
}
//
+(void)setType:(NSString *)value
{
    _type = value;
}
+(NSString *)type
{
    return _type;
}
//
+(void)setVConnex:(BOOL)value
{
    _vConnex  = value;
}
+(BOOL)vConnex
{
    return _vConnex;
}
//
+(void)setXAdjust:(uint)value
{
    _xAdjust = value;
}
+(uint)xAdjust
{
    return _xAdjust;
}
//
+(void)setXLines:(uint)value
{
    _xLines = value;
}
+(uint)xLines
{
    return _xLines;
}
//
+(void)setXOffset:(uint)value
{
    _xOffset = value;
}
+(uint)xOffset
{
    return _xOffset;
}
//
+(void)setXScale:(uint)value
{
    _xScale = value;
}
+(uint)xScale
{
    return _xScale;
}
//
+(void)setYAdjust:(uint)value
{
    _yAdjust = value;
}
+(uint)yAdjust
{
    return _yAdjust;
}
//
+(void)setYLines:(uint)value
{
    _yLines = value;
}
+(uint)yLines
{
    return _yLines;
}
//
+(void)setYOffset:(uint)value
{
    _yOffset = value;
}
+(uint)yOffset
{
    return _yOffset;
}
//
+(void)setYScale:(uint)value
{
    _yScale = value;
}
+(uint)yScale
{
    return _yScale;
}
//
+(uint)width
{
    return (_xLines-1)*_xOffset+_xAdjust*2;
}
+(uint)height
{
    return (_yLines-1)*_yOffset+_yAdjust*2;
}
//
+(SPImage *)backgroundImage
{
    if(!_backgroundImageRequired) return Nil;
//    return new Image(AssetEmbedsDefault.getTexture_cp_bg(DefaultConstants.IMG_BACK_GROUND));
    return [[SPImage alloc] initWithTexture:Nil];//TODO:texture construct.
}
@end
