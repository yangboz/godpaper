//
//  GP_IDragdropable.h
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-16.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPTouchEvent.h"
/**
 * IDragdropable.as class.Customize chess piece's Drag-and-Drop inside of AS3/starling system. 	
 */   
@protocol GP_IDragdropable <NSObject>
{
}
//
//--------------------------------------------------------------------------
//
//  Public methods
//
//--------------------------------------------------------------------------
////dragEnterHandler
//function dragEnterHandler(event:TouchEvent):Boolean;
-(BOOL)dragEnterHandler:(SPTouchEvent *)event;
////dragOutHandler
//function dragOutHandler(event:TouchEvent):void;
-(BOOL)dragOutHandler:(SPTouchEvent *)event;
////dragDropHandler
//function dragDropHandler(event:TouchEvent):void;
-(BOOL)dragDropHandler:(SPTouchEvent *)event;
//
@end
