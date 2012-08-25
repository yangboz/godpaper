//
//  GP_IPosition.h
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-16.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * The interface of chess piece and chess gasket.With x,y position properties.
 *
 */
@protocol GP_IPosition <NSObject>
//function set position(value:Point):void;
-(void)setPosition:(CGPoint *)value;
//function get position():Point;
-(CGPoint *)position;
//
@end
