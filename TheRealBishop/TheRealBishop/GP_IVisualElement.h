//
//  GP_IVisualElement.h
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-16.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GP_IUID.h"

@protocol GP_IVisualElement <GP_IUID>
//--------------------------------------------------------------------------
//
//  Public properties
//
//-------------------------------------------------------------------------- 
//
//function set x(value:Number):void;
-(void)setX:(NSNumber)value;
//function get x():Number;
-(NSNumber)x;
//
//function set y(value:Number):void;
-(void)setY:(NSNumber)value;
//function get y():Number;
-(void)y;
//
//function set label(value:String):void;
-(void)setLabel:(NSString *)value;
//function get label():String;
-(NSString *)label;
//
@end
