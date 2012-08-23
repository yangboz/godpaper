//
//  GP_ArrayedStack.h
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-8.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GP_Collection.h"

@interface GP_ArrayedStack : NSObject <GP_Collection>
{
//    private var _stack:Array;
//    private var _size:int;
//    private var _top:int;
    @private
        NSMutableArray *_stack;
        int _size,_top;
}
//
//public function ArrayedStack(size:int)
-(void)ArrayedStack:(int)size;
//public function get maxSize():int
@property(nonatomic,readonly) int maxSize;
//public function peek():*
-(id *)peek;
//public function push(obj:*):Boolean
-(BOOL)push:(id *)obj;
//public function pop():*
-(id *)pop;
//public function getAt(i:int):*
-(id *)getAt:(int)i;
//public function setAt(i:int, obj:*):void
-(void)setAt:(int)i objValue:(id *)obj;
//public function dump():String
-(NSString *)dump;
//
@end
