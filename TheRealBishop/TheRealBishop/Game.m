//
//  Game.m
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-15.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import "Game.h"
#import "SHLine.h"
#import "GP_ChessBoard.h"

@implementation Game

-(id)initWithWidth:(float)width height:(float)height
{
    if (self == [super initWithWidth:width height:height]) {
        // this is where the code of your game will start. 
        // in this sample, we add just a simple quad to see 
        // if it works.
        SPQuad *quad = [SPQuad quadWithWidth:self.stage.width height:self.stage.height];
        quad.color = 0xff0000;
        quad.x = 0;
        quad.y = 0;
        [self addChild:quad];
                
        //Chess board test
        SPTexture *bgTexture = [SPTexture textureWithContentsOfFile:@"background_chinese_chess_jam.png"];
//        GP_ChessBoard *board = [[GP_ChessBoard alloc] init];
        GP_ChessBoard *board = [[GP_ChessBoard alloc] initWithUpState:bgTexture];
        [board setLabel:@"GP_ChessBoard"];
        [self addChild:board];
    }
    return self;
}

@end
