//
//  GP_ArrayedStack.m
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-8.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import "GP_ArrayedStack.h"

@implementation GP_ArrayedStack

/**
 * Initializes a stack to match the given size.
 * 
 * @param size The maximum allowed size.
 */
//public function ArrayedStack(size:int)
-(void)ArrayedStack:(int)size
{
    _size = size;
//    clear();
    [self clear];
}

/**
 * The stack's maximum capacity. 
 */
//public function get maxSize():int
-(int)maxSize
{
    return _size;
}

/**
 * Indicates the top item.
 *
 * @return The top item.
 */
//public function peek():*
-(id *)peek
{
//    return _stack[int(_top - 1)];
    return [_stack objectAtIndex:(int)(_top-1)];
}

/**
 * Pushes data onto the stack.
 * 
 * @param obj The data.
 */
//public function push(obj:*):Boolean
-(BOOL)push:(id *)obj
{
//if (_size != _top)
//{
//    _stack[_top++] = obj;
//    return true;
//}
//return false;
}
/**
 * Pops data off the stack.
 * 
 * @return A reference to the top item or null if the stack is empty.
 */
//public function pop():*
-(id *)pop
{
//    if (_top > 0)
//        return _stack[--_top];
//    return null;
}

/**
 * Reads an item at a given index.
 * 
 * @param i The index.
 * 
 * @return The item at the given index.
 */
//public function getAt(i:int):*
-(id *)getAt:(int)i
{
//    if (i >= _top) return null;
//    return _stack[i];
}

/**
 * Writes an item at a given index.
 * 
 * @param i   The index.
 * @param obj The data.
 */
//public function setAt(i:int, obj:*):void
-(void)setAt:(int)i objValue:(id *)obj
{
//    if (i >= _top) return;
//    _stack[i] = obj;
}
#pragma mark Protocol of GP_Collection
/**
 * @inheritDoc
 */
//public function contains(obj:*):Boolean
-(BOOL)contains:(id)obj
{
//for (var i:int = 0; i < _top; i++)
//{
//    if (_stack[i] === obj)
//        return true;
//}
//return false;
}

/**
 * @inheritDoc
 */
//public function clear():void
-(void)clear
{
//    _stack = new Array(_size);
//    _top = 0;
}

/**
 * @inheritDoc
 */
//public function getIterator():Iterator
-(id)getIterator
{
//return new ArrayedStackIterator(this);
}

/**
 * @inheritDoc
 */
//public function get size():int
-(int)size
{
    return _top;
}

/**
 * @inheritDoc
 */
//public function isEmpty():Boolean
-(BOOL)isEmpty
{
return _top == 0;
}

/**
 * @inheritDoc
 */
//public function toArray():Array
-(NSMutableArray *)toArray
{
//return _stack.concat();
}
/**
 * Prints out a string representing the current object.
 * 
 * @return A string representing the current object.
 */
//public function toString():String
-(NSString *)toString
{
//return "[ArrayedStack, size= " + _top + "]";
}
/**
 * Prints out all elements (for debug/demo purposes).
 * 
 * @return A human-readable representation of the structure.
 */
//public function dump():String
-(NSString *)dump
{
//var s:String = "[ArrayedStack]";
//if (_top == 0) return s;
//
//var k:int = _top - 1;
//s += "\n\t" + _stack[k--] + " -> front\n";
//for (var i:int = k; i >= 0; i--)
//s += "\t" + _stack[i] + "\n";
//return s;
}


@end
