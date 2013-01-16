//
//  GPArray2Iterator.m
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-6.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import "GP_Array2Iterator.h"
#import "GP_Array2.h"

@implementation GP_Array2Iterator

-(id)Array2Iterator:(GP_Array2 *)a2
{
    _a2 = a2;
    _xCursor = _yCursor = 0;
    return self;
}

#pragma mark Protocol of GP_Iterator

-(void)setData:(id)data
{
    //    _a2.sett(_xCursor, _yCursor, obj);
    [_a2 sett:_xCursor intValue:_yCursor idValue:data];
}

-(id)data
{
    //    return _a2.gett(_xCursor, _yCursor);
    return [_a2 gett:_xCursor intValue:_yCursor];
}

//public function start():void
-(void)start
{
    _xCursor = _yCursor = 0;
}

//public function hasNext():Boolean
-(BOOL)hasNext
{
    return (_yCursor * _a2.width + _xCursor < _a2.size);
}

//public function next():*
-(id)next
{
    //    var item:* = data;
    //    
    //    if (++_xCursor == _a2.width)
    //    {
    //        _yCursor++;
    //        _xCursor = 0;
    //    }
    //    
    //    return item;
    id item = self.data;
    if (++_xCursor == _a2.width) {
        _yCursor++;
        _xCursor=0;
    }
    //
    return item;
}

@end
