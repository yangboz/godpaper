//
//  GP_ArrayedQueue.m
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-8.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import "GP_ArrayedQueue.h"
#import "GP_Iterator.h"
#import "GP_ArrayedQueueIterator.h"

@implementation GP_ArrayedQueue

/**
 * Initializes a queue object to match the given size.
 * The size <b>must be a power of two</b> - if not the size is
 * automatically rounded to the next largest power of 2.
 * The initial value of all items is null.
 * 
 * @param size The queue's size.
 */
//public function ArrayedQueue(size:int)
-(void)ArrayedQueue:(int)size
{
//    init(size);
    [self init:size];
}

/**
 * The queue's maximum capacity. 
 */
//public function get maxSize():int
-(int)maxSize;
{
    return _size;
}

/**
 * Indicates the front item.
 * 
 * @return The front item or null if the queue is empty.
 */
//public function peek():*
-(id)peek
{
//    return _que[_front];
    return [_que objectAtIndex:_front];
}
/**
 * Indicates the most recently added item.
 * 
 * @return The last item in the queue or null if the queue is empty.
 */
//public function back():*
-(id)back
{
//    return _que[int((_count - 1 + _front) & _divisor)];
    return [_que objectAtIndex:(int)((_count - 1 + _front) & _divisor)];
}

/**
 * Enqueues some data.
 * 
 * @param  obj The data to enqueue.
 * 
 * @return True if the item fits into the queue, otherwise false.
 */
//public function enqueue(obj:*):Boolean
-(BOOL)enqueue:(NSObject *)obj
{
//if (_size != _count)
//{
//    _que[int((_count++ + _front) & _divisor)] = obj;
//    return true;
//}
//return false;
    if (_size != _count) {
        [_que insertObject:obj atIndex:(int)((_count++ + _front) & _divisor)];
        return YES;
    }
    return NO;
}

/**
 * Dequeues and returns the front item.
 * 
 * @return The front item or null if the queue is empty.
 */
//public function dequeue():*
-(id)dequeue
{
//    if (_count > 0)
//    {
//        var data:* = _que[int(_front++)];
//        if (_front == _size) _front = 0;
//        _count--;
//        return data;
//    }
//    return null;
    if (_count > 0) {
        id data = [_que objectAtIndex:(int)(_front++)];
        if (_front == _size) {
            _front = 0;
        }
        _count--;
        return data;
    }
    return nil;
}
/**
 * Deletes the last dequeued item to free it for the garbage collector.
 * <i>Use only directly after you have invoked dequeue()</i>.
 * 
 * @example The following code clears the dequeued item:
 * <listing version="3.0">
 * myQueue.dequeue();
 * myQueue.dispose();
 * </listing>
 */
//public function dispose():void
-(void)dispose
{
//    if (!_front) _que[int(_size  - 1)] = null;
//    else 		 _que[int(_front - 1)] = null;
    if (!_front) {
        [_que insertObject:[NSNull null] atIndex:(_size - 1)];
    }else {
        [_que insertObject:[NSNull null] atIndex:(_front - 1)];
    }
}

/**
 * Reads an item relative to the front index.
 * 
 * @param i The index of the item.
 * 
 * @return The item at the given index.
 */
//public function getAt(i:int):*
-(NSObject *)getAt:(int)i
{
//    if (i >= _count) return null;
//    return _que[int((i + _front) & _divisor)];
    if (i >= _count) {
        return nil;
    }
    return [_que objectAtIndex:(int)((i + _front) & _divisor)];
}

/**
 * Writes an item relative to the front index.
 * 
 * @param i   The index of the item.
 * @param obj The data.
 */
//public function setAt(i:int, obj:*):void
-(void)setAt:(int)i objValue:(NSObject *)obj
{
//    if (i >= _count) return;
//    _que[int((i + _front) & _divisor)] = obj;
    if (i >= _count) {
        return;
    }
    [_que insertObject:obj atIndex:(int)((i + _front) & _divisor)];
}
#pragma mark Protocol of GP_Iterator
/**
 * @inheritDoc
 */
//public function clear():void
-(void)clear
{
//    _que = new Array(_size);
//    _front = _count = 0;
//    
//    for (var i:int = 0; i < _size; i++) _que[i] = null;	
    _que = [NSMutableArray arrayWithCapacity:_size];
    _front = _count = 0;

}

/**
 * @inheritDoc
 */
//public function getIterator():Iterator
-(id)getIterator
{
//    return new ArrayedQueueIterator(this);
    return [GP_ArrayedQueueIterator alloc];
}

/**
 * @inheritDoc
 */
//public function get size():int
-(int)size
{
    return _count;
}

/**
 * @inheritDoc
 */
//public function isEmpty():Boolean
-(BOOL)isEmpty
{
    return _count == 0;
}

/**
 * @inheritDoc
 */
//public function toArray():Array
-(NSMutableArray *)toArray
{
//var a:Array = new Array(_count);
//for (var i:int = 0; i < _count; i++)
//a[i] = _que[int((i + _front) & _divisor)];
//return a;
    NSMutableArray *a = [NSMutableArray arrayWithCapacity:_count];
    for (int i = 0; i < _count; i++) {
        [a insertObject:[_que objectAtIndex:((i + _front) & _divisor)] atIndex:i];
    }
    return a;
}

/**
 * Prints out a string representing the current object.
 * 
 * @return A string representing the current object.
 */
//public function toString():String
-(NSString *)toString;
{
//return "[ArrayedQueue, size=" + size + "]";
    NSString *str = [[NSString alloc] initWithString:@"[ArrayedQueue, size="];
    str = [str stringByAppendingFormat:@"%i %@",[self size],@"]"];
    return str;
}
/**
 * Prints out all elements (for debug/demo purposes).
 * 
 * @return A human-readable representation of the structure.
 */
//public function dump():String
-(NSString *)dump;
{
//var s:String = "[ArrayedQueue]\n";
//
//s += "\t" + getAt(i) + " -> front\n";
//for (var i:int = 1; i < _count; i++)
//s += "\t" + getAt(i) + "\n";
//
//return s;
    NSString *s = [[NSString alloc] initWithString:@"[ArrayedQueue]\n"];
    //TODO:more string appending.
    return s;
}

/**
 * @private
 */
//private function init(size:int):void
-(void)init:(int)size
{
    //check if the size is a power of 2
    if (!(size > 0 && ((size & (size - 1)) == 0)))
    {
        //given a binary integer value x, the next largest power of 2
        //can be computed by a swar algorithm that recursively "folds"
        //the upper bits into the lower bits. this process yields a bit
        //vector with the same most significant 1 as x, but all 1's
        //below it. adding 1 to that value yields the next largest power
        //of 2. for a 32-bit value
        size |= (size >> 1);
        size |= (size >> 2);
        size |= (size >> 4);
        size |= (size >> 8);
        size |= (size >> 16);
        size++;
    }
    
    _size = size;
    _divisor = size - 1;
//    clear();
    [self clear];
}

@end
