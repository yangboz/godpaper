//
//  Game.m
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-15.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import "Game.h"
#import "SHLine.h"

@implementation Game

-(id)initWithWidth:(float)width height:(float)height
{
    if (self == [super initWithWidth:width height:height]) {
        // this is where the code of your game will start. 
        // in this sample, we add just a simple quad to see 
        // if it works.
        SPQuad *quad = [SPQuad quadWithWidth:self.stage.width height:self.stage.height];
        quad.color = 0xff00ff;
        quad.x = 0;
        quad.y = 0;
        [self addChild:quad];
        //SHLine testing.
        //initialize a line with a length of 100 pixels and thickness of 5 pixels
        SHLine *line = [SHLine lineWithLength:100 andThickness:5];
        
        //set the start color to red
        line.startColor = 0xff0000;
        
        //set the end color to blue
        line.endColor = 0x0000ff;
        
        //set the start opacity to 75%
        line.startAlpha = 0.75f;
        
        //set the end opacity to 25%
        line.endAlpha = 0.25f;
        
        //set the end destination to the bottom right corner of the screen
        line.x2 = 320;
        line.y2 = 480;
        
        //initialize another line with the coords (x, y, width, height)
        SHLine *line2 = [SHLine lineWithCoords:0:480:320:-480];
        
        //set the line thickness to 5 pixels
        line2.thickness = 5;

        //add the line to the stage
        [self addChild:line];

    }
    return self;
}

@end
