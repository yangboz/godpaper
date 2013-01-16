//
//  GP_BitVector.h
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-8.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GP_BitVector : NSObject
{
//    private var _bits:Array;
//    private var _arrSize:int;
//    private var _bitSize:int;
    @private
        NSMutableArray *_bits;
        int _arrSize,_bitSize;
}
//Methods
//public function BitVector(bits:int)
-(GP_BitVector *)BitVector:(int)bits;

//public function get bitCount():int
@property(readonly,assign) int bitCount;

//public function get cellCount():int
@property(readonly,assign) int cellCount;

//public function getBit(index:int):int
-(int)getBit:(int)index;

//public function setBit(index:int, b:Boolean):void
-(void)setBit:(int)index boolValue:(BOOL)b;

//public function resize(size:int):void
-(void)resize:(int)size;

//public function clear():void
-(void)clear;

//public function setAll():void
-(void)setAll;

//public function toString():String
-(NSString *)toString;

@end
