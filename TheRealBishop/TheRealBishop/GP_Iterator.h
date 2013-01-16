//
//  GPIterator.h
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-7-31.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 * A 'java-style' iterator interface.
 */
@protocol GP_Iterator
/**
 * Returns the current item and moves the iterator to the next item
 * in the collection. Note that the next() method returns the
 * <i>first</i> item in the collection when it's first called.
 * 
 * @return The next item in the collection.
 */
//function next():*
-(id)next;
/**
 * Checks if a next item exists.
 * 
 * @return True if a next item exists, otherwise false.
 */
//function hasNext():Boolean
-(BOOL)hasNext;
/**
 * Moves the iterator to the first item in the collection.
 */
//function start():void
-(void)start;
/**
 * Grants access to the current item being referenced by the iterator.
 * This provides a quick way to read or write the current data.
 */
//function get data():*
/**
 * @private
 */
//function set data(obj:*):void
@property(nonatomic,retain) id data;
//
@end
