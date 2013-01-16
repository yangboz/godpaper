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
    //Empty
}
//global board config.
+(void)setXlines:(uint)value;
+(uint)xlines;
+(void)setYlines:(uint)value;
+(uint)ylines;
//board scale
+(void)setXScale:(uint)value;
+(uint)xScale;
+(void)setYScale:(uint)value;
+(uint)yScale;
//board lattic
+(void)setXOffset:(uint)value;
+(uint)xOffset;
+(void)setYOffset:(uint)value;
+(uint)yOffset;
//board size
+(uint)width;
+(uint)height;
//board background
+(void)setXAdjust:(uint)value;
+(uint)xAdjust;
+(void)setYAdjust:(uint)value;
+(uint)yAdjust;
//connex directions
+(void)setHConnex:(BOOL)value;//horizontally connection flag.
+(BOOL)hConnex;
+(void)setVConnex:(BOOL)value;//vertically connection flag.
+(BOOL)vConnex;
+(void)setFdConnex:(BOOL)value;//forward diagonally connection flag.
+(BOOL)fdConnex;
+(void)setBdConnex:(BOOL)value;//backward diagonally connection flag.
+(BOOL)bdConnex;
+(void)setNumConnex:(uint)value;//the number of connex in each direction.
+(uint)numConnex;
//background image texture.
+(void)setBackgroundImageRequired:(BOOL)value;
+(BOOL)backgroundImageRequired;
+(SPImage *)backgroundImage;
//Pieces box relevant variables.
//For partical chess board game with pieces box component view;
+(void)setPiecesBoxRequired:(BOOL)value;
+(BOOL)piecesBoxRequired;
//The chess pieces box 's backgroud texture;
+(void)setPiecesBoxBgImage:(SPImage *)value;
+(SPImage *)piecesBoxBgImage;
//TODO:type customize.
+(void)setType:(NSString *)value;
+(NSString *)type;
@end
