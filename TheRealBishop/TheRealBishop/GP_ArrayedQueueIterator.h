//
//  GP_ArrayedQueueIterator.h
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-22.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GP_Iterator.h"
#import "GP_ArrayedQueue.h"

@interface GP_ArrayedQueueIterator : NSObject <GP_Iterator>
{
//    private var _que:ArrayedQueue;
//    private var _cursor:int;
    @private
        GP_ArrayedQueue *_que;
        int _cursor;
}

//public function ArrayedQueueIterator(que:ArrayedQueue)
-(void)ArrayedQueueIterator:(GP_ArrayedQueue *)que;

//public function get data():*
//public function set data(obj:*):void
@property(nonatomic,retain) NSObject *data;

//public function start():void
-(void)start;

//public function hasNext():Boolean
-(BOOL)hasNext;

//public function next():*
-(NSObject *)next;

@end
