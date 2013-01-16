//
//  GP_BitVector.m
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-8.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import "GP_BitVector.h"

@implementation GP_BitVector
/**
 * Creates a bit-vector with a given number of bits. Each cell holds an
 * int, allowing to store 32 flags each. 
 * 
 * @param bits The total number of bits.
 */
//public function BitVector(bits:int)
-(GP_BitVector *)BitVector:(int)bits
{
//    _bits = [];
//    _arrSize = 0;
//    
//    resize(bits);
    _bits = [[NSMutableArray alloc] init];
    _arrSize = 0;
    //
    [self resize:bits];
    return self;
}

/**
 * The total number of bits.
 */
//public function get bitCount():int
-(int)bitCount
{
    return _arrSize * 31;
}

/**
 * The total number of cells.
 */
//public function get cellCount():int
-(int)cellCount
{
    return _arrSize;
}

/**
 * Gets a bit from a given index.
 * 
 * @param index The index of the bit.
 */
//public function getBit(index:int):int
-(int)getBit:(int)index
{
//    var bit:int = index % 31;
//    return (_bits[(index / 31) >> 0] & (1 << bit)) >> bit;
    int bit = index % 31;
    return ((int)[_bits objectAtIndex:((index /31) >>0)] & (1 << bit) ) >> bit;
}

/**
 * Sets a bit at a given index.
 * 
 * @param index The index of the bit.
 * @param b     The boolean flag to set.
 */
//public function setBit(index:int, b:Boolean):void
-(void)setBit:(int)index boolValue:(BOOL)b
{
//    var cell:int = index / 31;
//    var mask:int = 1 << index % 31;
//    _bits[cell] = b ? (_bits[cell] | mask) : (_bits[cell] & (~mask));
    int cell = index / 31;
    int mask = 1 << index % 31;
    NSNumber *num = [NSNumber numberWithBool:( b ? ((int)[_bits objectAtIndex:cell] | mask) : ((int)[_bits objectAtIndex:cell] & (~mask)) )];
    [_bits insertObject:num atIndex:cell];
}

/**
 * Resizes the bit-vector to an appropriate number of bits.
 * 
 * @param size The total number of bits.
 */
//public function resize(size:int):void
-(void)resize:(int)size
{
//    if (size == _bitSize) return;
//    _bitSize = size;
//    
//    //convert the bit-size to integer-size
//    if (size % 31 == 0)
//        size /= 31;
//    else
//        size = (size / 31) + 1;
//    
//    if (size < _arrSize)
//    {
//        _bits.splice(size);
//        _arrSize = size;
//    }
//    else
//    {
//        _bits = _bits.concat(new Array(size - _arrSize));
//        _arrSize = _bits.length;
//    }
    if (size == _bitSize) return;
    _bitSize = size;
    //convert the bit-size to integer-size
    if (size % 31 == 0) {
        size /= 31;
    }else {
        size = (size / 31) + 1;
    }
    //
    if (size < _arrSize) {
        [_bits removeObjectsInRange:NSMakeRange(size, (_arrSize-size))];
    }else {
        NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:(size - _arrSize)];
        [_bits addObjectsFromArray:arr];
        _arrSize = [_bits count];
    }
}

/**
 * Resets all bits to 0;
 */
//public function clear():void
-(void)clear
{
//    var k:int = _bits.length;
//    for (var i:int = 0; i < k; i++)
//        _bits[i] = 0;
    int k = [_bits count];
    for (int i=0; i < k; i++) {
        [_bits insertObject:[NSNumber numberWithInt:0] atIndex:i];
    }
}

/**
 * Sets each bit to 1.
 */
//public function setAll():void
-(void)setAll
{
//    var k:int = _bits.length;
//    for (var i:int = 0; i < k; i++)
//        _bits[i] = int.MAX_VALUE;
    int k = [_bits count];
    for (int i = 0; i < k;  i++) {
        [_bits insertObject:[NSNumber numberWithInt:(int)(FLT_MAX)] atIndex:i];
    }
}

/**
 * Prints out a string representing the current object.
 * 
 * @return A string representing the current object.
 */
//public function toString():String
-(NSString *)toString
{
//return "[BitVector, size=" + _bitSize + "]";
    NSString *str = @"[BitVector, size=";
    str = [NSString stringWithFormat:@"%i %@",_bitSize,@"]"];
    return str;
}

@end
