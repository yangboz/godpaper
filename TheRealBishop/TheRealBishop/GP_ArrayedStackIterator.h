//
//  GP_ArrayedStackIterator.h
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-23.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GP_Iterator.h"
#import "GP_ArrayedStack.h"

@interface GP_ArrayedStackIterator : NSObject <GP_Iterator>
{
//    private var _stack:ArrayedStack;
//	private var _cursor:int;
    @private
        GP_ArrayedStack *_stack;
        int _cursor;
}
//
//public function ArrayedStackIterator(stack:ArrayedStack)
-(void)ArrayedStackIterator:(GP_ArrayedStack *)stack;
//public function get data():*
//public function set data(obj:*):void
@property(nonatomic,retain) NSObject *data;
//public function start():void
-(void)start;
//public function hasNext():Boolean
-(BOOL)hasNext;
//public function next():*
-(id)next;
//
@end
