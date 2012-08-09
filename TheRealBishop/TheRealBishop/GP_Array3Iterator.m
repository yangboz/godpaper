//
//  GP_Array3Iterator.m
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-9.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import "GP_Array3Iterator.h"

@implementation GP_Array3Iterator

//public function Array3Iterator(a3:Array3)
-(void)Array3Iterator:(NSMutableArray *)a3;
{
//    _values = a3.toArray();
//    _length = _values.length;
//    _cursor = 0;
    _values = [a3 copy];
    _length = [a3 count];
    _cursor = 0;
}
#pragma mark Protocol_GP_Iterator
//public function get data():*
-(id)data
{
//    return _values[_cursor];
    return [_values objectAtIndex:_cursor];
}
//
//public function set data(obj:*):void
-(void)setData:(id)data
{
//    _values[_cursor] = obj;
    [_values insertObject:data atIndex:_cursor];
}
//
//public function start():void
-(void)start
{
    _cursor = 0;
}
//
//public function hasNext():Boolean
-(BOOL)hasNext
{
    return _cursor < _length;
}
//
//public function next():*
-(id)next
{
//    return _values[_cursor++];
    return [_values objectAtIndex:(_cursor++)];
}

@end
