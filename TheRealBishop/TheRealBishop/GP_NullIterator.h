//
//  GP_NullIterator.h
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-8.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GP_Iterator.h"

@interface GP_NullIterator : NSObject <GP_Iterator>
{
    @private
        id data;
}
/**
 * Nullified behaviour.
 */
//public function start():void
-(void)start;
/**
 * Nullified behaviour.
 */
//public function next():*
-(id *)next;
/**
 * Nullified behaviour.
 */
//public function hasNext():Boolean
-(BOOL)hasNext;
/**
 * Always returns null.
 */
//public function get data():*
/**
 * Nullified behaviour.
 */
//public function set data(obj:*):void
@property(nonatomic,retain) id data;
//
@end
