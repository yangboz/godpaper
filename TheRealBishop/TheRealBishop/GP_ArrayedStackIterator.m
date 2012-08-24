//
//  GP_ArrayedStackIterator.m
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-23.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import "GP_ArrayedStackIterator.h"

@implementation GP_ArrayedStackIterator

//public function ArrayedStackIterator(stack:ArrayedStack)
-(void)ArrayedStackIterator:(GP_ArrayedStack *)stack
{
    _stack = stack;
//    start();
    [self start];
}

//public function get data():*
-(NSObject *)data
{
//    return _stack.getAt(_cursor);
    return [_stack getAt:_cursor];
}

//public function set data(obj:*):void
-(void)setData:(NSObject *)data
{
//    _stack.setAt(_cursor, obj);
}

//public function start():void
-(void)start
{
    _cursor = _stack.size - 1;
}

//public function hasNext():Boolean
-(BOOL)hasNext
{
    return _cursor >= 0;
}

//public function next():*
-(id *)next
{
//    if (_cursor >= 0)
//        return _stack.getAt(_cursor--);
//    return null;
}

@end
