//
//  Game.m
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-15.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import "Game.h"

@implementation Game

-(id)initWithWidth:(float)width height:(float)height
{
    if (self == [super initWithWidth:width height:height]) {
        // this is where the code of your game will start. 
        // in this sample, we add just a simple quad to see 
        // if it works.
        SPQuad *quad = [SPQuad quadWithWidth:100 height:100];
        quad.color = 0xff0000;
        quad.x = 50;
        quad.y = 50;
        [self addChild:quad];
    }
    return self;
}

@end
