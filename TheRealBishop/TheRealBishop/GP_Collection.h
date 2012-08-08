//
//  GPCollection.h
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-7-31.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import "GP_Iterator.h"
/**
 * A 'java-style' collection interface.
 */
@protocol GP_Collection
/**
 * Determines if the collection contains a given item.
 * 
 * @param obj The item to search for.
 * 
 * @return True if the item exists, otherwise false.
 */
//function contains(obj:*):Boolean
-(BOOL)contains:(id)obj;
/**
 * Clears all items.
 */
//function clear():void
-(void)clear;
/**
 * Initializes an iterator object pointing to the first item in the
 * collection.
 *
 * @return An iterator object.
 */
//function getIterator():Iterator
-(id *)getIterator;
/**
 * The total number of items.
 * 
 * @return The size.
 */
//function get size():int;
@property(readonly) NSInteger size;

/**
 * Checks if the collection is empty.
 * 
 * @return True if empty, otherwise false.
 */
//function isEmpty():Boolean;
-(BOOL)isEmpty;

/**
 * Converts the collection into an array.
 * 
 * @return An array.
 */
//function toArray():Array;
-(NSMutableArray *)toArray;

@end
