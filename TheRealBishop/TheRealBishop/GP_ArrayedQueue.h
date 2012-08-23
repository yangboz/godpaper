//
//  GP_ArrayedQueue.h
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-8.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GP_Collection.h"

@interface GP_ArrayedQueue : NSObject <GP_Collection>
{
//    private var _que:Array;
//    private var _size:int;
//    private var _divisor:int;
//    
//    private var _count:int;
//    private var _front:int;
    @private
        NSMutableArray *_que;
        int _size,_divisor,_count,_front;
}

//public function ArrayedQueue(size:int)
-(void)ArrayedQueue:(int)size;
//public function get maxSize():int
@property(nonatomic,readonly)int maxSize;
//public function peek():*
-(id *)peek;
//public function back():*
-(id *)back;
//public function enqueue(obj:*):Boolean
-(BOOL)enqueue:(id *)obj;
//public function dequeue():*
-(id *)dequeue;
//public function dispose():void
-(void)dispose;
//public function getAt(i:int):*
-(NSObject *)getAt:(int)i;
//public function setAt(i:int, obj:*):void
-(void)setAt:(int)i objValue:(NSObject *)obj;

@end
