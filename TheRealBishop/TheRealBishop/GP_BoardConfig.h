//
//  GP_BoardConfig.h
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-9-16.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPImage.h"
/**
 * BoardConfig.as class.Global board configuration,(which one) set up at application's initialization stage.
 * @author yangboz
 * @langVersion 3.0
 * @playerVersion 9.0
 * Created Jan 19, 2011 2:20:20 PM
 * @history 2011-07-18,added connex directions flag.
 */
@interface GP_BoardConfig : NSObject
{
    //global board config.
//    public static var xLines:Number=4;
//    public static var yLines:Number=4;
    uint _xLines,_yLines;
    //board scale
//    public static var xScale:Number=1;
//    public static var yScale:Number=1;
    uint xScale,yScale;
    //board lattic
//    public static var xOffset:Number=50;
//    public static var yOffset:Number=50;
    uint xOffset,yOffset;
    //board size
//    public static function get height():Number
//    {
//        return (BoardConfig.yLines-1)*BoardConfig.yOffset+BoardConfig.yAdjust*2;
//    }
    uint height;
    //
//    public static function get width():Number
//    {
//        return (BoardConfig.xLines-1)*BoardConfig.xOffset+BoardConfig.xAdjust*2;
//    }
    uint width;
    //board background
    //		private static var _backGround:Class;
    //board x,y position adjust
//    public static var xAdjust:Number=50;
//    public static var yAdjust:Number=50;
    uint xAdjust,yAdjust;
    //connex directions
//    public static var hConnex:Boolean=false; //horizontally connection flag.
//    public static var vConnex:Boolean=false; //vertically connection flag.
//    public static var fdConnex:Boolean=false; //forward diagonally connection flag.
//    public static var bdConnex:Boolean=false; //backward diagonally connection flag.
//    public static var numConnex:Number;//the number of connex in each direction.
    BOOL hConnex,vConnex,fdConnex,bdConnex,numConex;
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
    BOOL backgroundImageRequired;
    SPImage *backgroundImage;
    //Pieces box relevant variables.
//    public static var piecesBoxRequired:Boolean = false;//For partical chess board game with pieces box component view;
//    public static var piecesBoxBgImage:Image=null;//The chess pieces box 's backgroud texture;
    BOOL piecesBoxRequired;
    SPImage *piecesBoxBgImage;
    //public static var type:String = null;//TODO:type customize.
}
@property(nonatomic,assign)uint xLines;

@end
