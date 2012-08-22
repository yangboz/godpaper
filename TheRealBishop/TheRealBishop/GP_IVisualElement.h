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
{
    @private
        NSNumber *x;
        NSNumber *y;
        NSString *label;
}
//--------------------------------------------------------------------------
//
//  Public properties
//
//-------------------------------------------------------------------------- 
//
//function set x(value:Number):void;
//function get x():Number;
//
//function set y(value:Number):void;
//function get y():Number;
//
//function set label(value:String):void;
//function get label():String;
@property(nonatomic,retain) NSNumber *x;
@property(nonatomic,retain) NSNumber *y;
@property(nonatomic,retain) NSString *label;
//
@end
