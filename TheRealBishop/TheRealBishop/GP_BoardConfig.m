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
static uint _xLines,_yLines;
//board scale
//    public static var xScale:Number=1;
//    public static var yScale:Number=1;
static uint xScale,yScale;
//board lattic
//    public static var xOffset:Number=50;
//    public static var yOffset:Number=50;
static uint xOffset,yOffset;
//board size
//    public static function get height():Number
//    {
//        return (BoardConfig.yLines-1)*BoardConfig.yOffset+BoardConfig.yAdjust*2;
//    }
static uint height;
//
//    public static function get width():Number
//    {
//        return (BoardConfig.xLines-1)*BoardConfig.xOffset+BoardConfig.xAdjust*2;
//    }
static uint width;
//board background
//		private static var _backGround:Class;
//board x,y position adjust
//    public static var xAdjust:Number=50;
//    public static var yAdjust:Number=50;
static uint xAdjust,yAdjust;
//connex directions
//    public static var hConnex:Boolean=false; //horizontally connection flag.
//    public static var vConnex:Boolean=false; //vertically connection flag.
//    public static var fdConnex:Boolean=false; //forward diagonally connection flag.
//    public static var bdConnex:Boolean=false; //backward diagonally connection flag.
//    public static var numConnex:Number;//the number of connex in each direction.
static BOOL hConnex,vConnex,fdConnex,bdConnex,numConex;
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
static BOOL backgroundImageRequired;
static SPImage *backgroundImage;
//Pieces box relevant variables.
//    public static var piecesBoxRequired:Boolean = false;//For partical chess board game with pieces box component view;
//    public static var piecesBoxBgImage:Image=null;//The chess pieces box 's backgroud texture;
static BOOL piecesBoxRequired;
static SPImage *piecesBoxBgImage;
//public static var type:String = null;//type customize.
static NSString *type;
//Avoid alloc
+ (id)alloc {
    [NSException raise:@"Cannot be instantiated!" format:@"Static class 'GP_BoardConfig' cannot be instantiated!"];
    return nil;
}
#pragma mark GP_BoardConfig static methods

@end
