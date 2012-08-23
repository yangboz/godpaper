//
//  GP_ArrayedQueueIterator.m
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-22.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import "GP_ArrayedQueueIterator.h"

@implementation GP_ArrayedQueueIterator

//public function ArrayedQueueIterator(que:ArrayedQueue)
-(void)ArrayedQueueIterator:(GP_ArrayedQueue *)que
{
    _que = que;
    _cursor = 0;
}

//public function get data():*
-(NSObject *)data
{
//    return _que.getAt(_cursor);
    return [_que getAt:_cursor];
}

//public function set data(obj:*):void
-(void)setData:(NSObject *)data
{
//    _que.setAt(_cursor, obj);
    [_que setAt:_cursor objValue:data];
}

//public function start():void
-(void)start
{
    _cursor = 0;
}

//public function hasNext():Boolean
-(BOOL)hasNext
{
    return _cursor < _que.size;
}

//public function next():*
-(NSObject *)next
{
//    if (_cursor < _que.size)
//        return _que.getAt(_cursor++);
//    return null;
    if (_cursor < _que.size) {
        return [_que getAt:(_cursor++)];
    }
    return NULL;
}
@end
