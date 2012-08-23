//
//  GP_NullIterator.m
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-8.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import "GP_NullIterator.h"
/**
 * An do-nothing iterator for structures that don't support iterators.
 */
@implementation GP_NullIterator
//@synthesize data;
/**
 * Nullified behaviour.
 */
//public function start():void
-(void)start;
{
}

/**
 * Nullified behaviour.
 */
//public function next():*
-(id *)next;
{
//    return null;
    return nil;
}

/**
 * Nullified behaviour.
 */
//public function hasNext():Boolean
-(BOOL)hasNext;
{
//    return false;
    return NO;
}

/**
 * Always returns null.
 */
//public function get data():*
-(id)data
{
//    return null;
    return nil;
}

/**
 * Nullified behaviour.
 */
//public function set data(obj:*):void
-(void)setData:(id)data
{
    //Always empty.
}
@end
