//
//  GP_Array3.m
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-8.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import "GP_Array3.h"
#import "GP_Array3Iterator.h"
/**
 * A three-dimensional array.
 */
@implementation GP_Array3
/**
 * Initializes a three-dimensional array to match the given width,
 * height and depth. The smallest possible size is a 1x1x1 matrix.
 * The initial value of all items is null.
 * 
 * @param w The width (equals number of columns).
 * @param h The height (equals number of rows).
 * @param d The depth (equals number of layers).
 */
//public function Array3(w:int, h:int, d:int)
-(id)Array3:(int)w intValue:(int)h intValue:(int)d;
{
//    if (w < 1 || h < 1 || h < 1)
//        throw new Error("illegal size");
//    
//    _a = new Array((_w = w) * (_h = h) * (_d = d));
//    
//    fill(null);
    if (w < 1 || h < 1 || d < 1) @throw([NSException exceptionWithName:@"illegal size" reason:@"Array3" userInfo:NULL]);
    //
    _a = [[NSMutableArray alloc] initWithCapacity:( (_w = w) * (_h = h) * (_d = d) )];
    //
//    [self fill:NULL];
    return self;
}

/**
 * Indicates the width (columns).
 * If a new width is set, the three-dimensional array
 * is resized accordingly.
 */
//public function get width():int
-(int)width;
{
    return _w;
}

/**
 * @private
 */
//public function set width(w:int):void
-(void)setWidth:(NSInteger)width;
{
//    resize(w, _h, _d);
    [self resize:width intValue:_h intValue:_d];
}

/**
 * Indicates the height (rows).
 * If a new height is set, the three-dimensional array
 * is resized accordingly.
 */
//public function get height():int
-(int)height
{
    return _h;
}

/**
 * @private
 */
//public function set height(h:int):void
-(void)setHeight:(NSInteger)height
{
//    resize(_w, h, _d);
    [self resize:_w intValue:height intValue:_d];
}

/**
 * Indicates the depth (layers).
 * If a new depth is set, the three-dimensional array
 * is resized accordingly.
 */
//public function get depth():int
-(int)depth
{
    return _d;
}

/**
 * @private
 */
//public function set depth(d:int):void
-(void)setDepth:(NSInteger)depth
{
//    resize(_w, _h, d);
    [self resize:_w intValue:_h intValue:depth];
}

/**
 * Writes a given value into each cell of the three-dimensional array.
 * 
 * @param item The item to be written into each cell.
 */
//public function fill(obj:*):void
-(void)fill:(id)obj
{
//    var k:int = size;
//    for (var i:int = 0; i < k; i++)
//        _a[i] = obj;
    int k = [self size];
    for (int i=0; i < k; i++) {
        [_a insertObject:obj atIndex:i];
    }
}

/**
 * Reads a value from a given x/y/z index. No boundary check is done, so
 * you have to make sure that the input coordinates do not exceed the
 * width, height or depth of the three-dimensional array.
 *
 * @param x The x index (column).
 * @param y The y index (row).
 * @param z The z index (layer).
 * 
 * @return The value at the given x/y/z index.
 */
//public function get(x:int, y:int, z:int):*
-(id)gett:(int)x intValue:(int)y intValue:(int)z
{
//    return _a[int((z * _w * _h) + (y * _w) + x)];
    return [_a objectAtIndex:((z * _w * _h) + (y * _w) + x) ];
}

/**
 * Writes a value into a cell at the given x/y/z index. No boundary
 * check is done, so you have to make sure that the input coordinates do
 * not exceed the width, height or depth of the two-dimensional array.
 *
 * @param x   The x index (column).
 * @param y   The y index (row).
 * @param z   The z index (layer).
 * @param obj The item to be written into the cell.
 */
//public function set(x:int, y:int, z:int, obj:*):void
-(void)sett:(int)x intValue:(int)y intValue:(int)z idValue:(id)obj
{
//    _a[int((z * _w * _h) + (y * _w) + x)] = obj;
    [_a insertObject:obj atIndex:((z * _w * _h) + (y * _w) + x)];
}

/**
 * Resizes the array to match the given width, height and depth. If the
 * new size is smaller than the existing size, values are lost because
 * of truncation, otherwise all values are preserved.
 * 
 * @param w The new width (cols).
 * @param h The new height (rows).
 * @param d The new depth (layers).
 */
//public function resize(w:int, h:int, d:int):void
-(void)resize:(int)w intValue:(int)h intValue:(int)d
{
//    if (width < 1 || height < 1 || height < 1)
//        throw new Error("illegal size");
//    
//    var tmp:Array = _a.concat();
//    
//    _a.length = 0;
//    _a.length = w * h * d;
//    
//    if (_a.length == 0)
//        return;
//    
//    var xMin:int = w < _w ? w : _w;
//    var yMin:int = h < _h ? h : _h;
//    var zMin:int = d < _d ? d : _d;
//    
//    var x:int, y:int, z:int;
//    var t1:int, t2:int, t3:int, t4:int;
//    
//    for (z = 0; z < zMin; z++)
//    {
//        t1 = z *  w  * h;
//        t2 = z * _w * _h;
//        
//        for (y = 0; y < yMin; y++)
//        {
//            t3 = y *  w;
//            t4 = y * _w;
//            
//            for (x = 0; x < xMin; x++)
//                _a[t1 + t3 + x] = tmp[t2 + t4 + x];
//        }
//    }
//    
//    _w = w;
//    _h = h;
//    _d = d;
    if (w < 1 || h < 1 || d < 1) @throw([NSException exceptionWithName:@"illegal size" reason:@"Array3->resize" userInfo:NULL]);
    //
    NSMutableArray *tmp = [_a copy];
    [_a removeAllObjects];
    _a = [[NSMutableArray alloc] initWithCapacity:(w * h * d)];
    if ( [_a count] ==0) return;
    //
    int xMin = w < _w ? w : _w;
    int yMin = h < _h ? h : _h;
    int zMin = d < _d ? d : _d;
    //
    int x,y,z;
    int t1,t2,t3,t4;
    //
    for (z=0; z < zMin; z++) {
        t1 = z * w * h;
        t2 = z * _w * _h;
        //
        for (y=0; y < yMin; y++) {
            t3 = y * w;
            t4 = y * _w;
            //
            for (x=0; x < xMin; x++) {
                [_a insertObject:[tmp objectAtIndex:(t2 + t4 + x)] atIndex:(t1 + t3 + x)];
            }
        }
    }
    //
    _w = w;
    _h = h;
    _d = d;
}

/**
 * Copies the data from a given depth (layer) into a
 * two-dimensional array.
 * 
 * @param z The layer to extract.
 * 
 * @return The layer's data.
 */
//public function getLayer(z:int):Array2
-(GP_Array2 *)getLayer:(int)z
{
//var a:Array2 = new Array2(_w, _h);
//var offset:int =  z * _w * _h;
//
//for (var x:int = 0; x < _w; x++)
//for (var y:int = 0; y < _h; y++)
//a.sett(x, y, _a[int(offset + (y * _w) + x)]);
//
//return a;
    GP_Array2 *a = [[GP_Array2 alloc] Array2:_w intValue:_h];
    int offset = z * _w * _h;
    for (int x=0; x < _w; x++) {
        for (int y=0; y < _h; y++) {
            [a sett:x intValue:y idValue:[_a objectAtIndex:(offset + (y * _w) +x)]];
        }
    }
    return a;
}

/**
 * Extracts a row from a given y index and depth (layer).
 *
 * @param z The layer containing the row
 * @param y The row index.
 * 
 * @return An array storing the values of the row.
 */
//public function getRow(z:int, y:int):Array
-(NSMutableArray *)getRow:(int)z intValule:(int)y
{
//var offset:int =  z * _w * _h + y * _w;
//return _a.slice(offset, offset + _w);
    int offset = z * _w * _h + y * _w;
    NSArray *sliced = [_a subarrayWithRange:NSMakeRange(offset, _w)];
    return [[NSMutableArray alloc] initWithArray:sliced];
}

/**
 * Inserts new values into a complete row at a given depth into the
 * three-dimensional array. The new row is truncated if it exceeds
 * the existing width.
 *
 * @param z The layer containing the existing row.
 * @param y The row index.
 * @param a The row's new values.
 */
//public function setRow(z:int, y:int, a:Array):void
-(void)setRow:(int)z intValue:(int)y arrayValue:(NSMutableArray *)a
{
//    var offset:int =  z * _w * _h + y * _w;
//    for (var i:int = 0; i < _w; i++)
//        _a[int(offset + i)] = a[i];
    int offset = z * _w * _h + y * _w;
    for (int i=0; i < _w ; i++) {
        [_a insertObject:[_a objectAtIndex:i] atIndex:(offset + i)];
    }
}

/**
 * Extracts a colum from a given index and depth (layer).
 * 
 * @param z The layer containing the column.
 * @param x The column index.
 * 
 * @return An array storing the values of the column.
 */
//public function getCol(z:int, x:int):Array
-(NSMutableArray *)getCol:(int)z intValue:(int)x
{
//var t:Array = [];
//var offset:int = z * _w * _h;
//for (var i:int = 0; i < _h; i++)
//t[i] = _a[int(offset + (i * _w + x))];
//return t;
    NSMutableArray *t = [[NSMutableArray alloc] init];
    int offset = z * _w * _h;
    for (int i=0; i < _h; i++) {
        [t insertObject:[_a objectAtIndex:(offset + (i * _w + x))] atIndex:i];
    }
    return t;
}

/**
 * Inserts new values into a complete column at a given depth into the
 * three-dimensional array. The new column is truncated if it exceeds
 * the existing height.
 *
 * @param z The layer containing the existing column.
 * @param x The column index.
 * @param a The column's new values.
 */
//public function setCol(z:int, x:int, a:Array):void
-(void)setCol:(int)z intValue:(int)x arrayValue:(NSMutableArray *)a
{
//    var offset:int = z * _w * _h;
//    for (var i:int = 0; i < _h; i++)
//        _a[int(offset + (i * _w + x))] = a[i];
    int offset = z * _w * _h;
    for (int i=0; i < _h; i++) {
        [_a insertObject:[_a objectAtIndex:i] atIndex:(offset + (i * _w + x))];
    }
}

/**
 * Extracts a pile going through the given x,y index.
 * The order is from bottom to top (lowest to highest layer).
 *
 * @param x The column index.
 * @param y The row index.
 * 
 * @return An array storing the values of the pile.
 */
//public function getPile(x:int, y:int):Array
-(NSMutableArray *)getPile:(int)x intValue:(int)y
{
//var t:Array = [];
//var offset1:int = _w * _h;
//var offset2:int = (y * _w + x);
//for (var i:int = 0; i < _d; i++)
//t[i] = _a[int(i * offset1 + offset2)];
//return t;
    NSMutableArray *t = [[NSMutableArray alloc] init];
    int offset1 = _w * _h;
    int offset2 = y * _w + x;
    for (int i=0; i < _d ; i++) {
        [t insertObject:[_a objectAtIndex:(i * offset1 + offset2)] atIndex:i];
    }
    return t;
}

/**
 * Inserts new values into a complete pile of the three-dimensional
 * array going through the given x, y index.
 * The pile is truncated if it exceeds the existing depth.
 *
 * @param x The column index.
 * @param y The row index.
 * @param a The pile's new values.
 */
//public function setPile(x:int, y:int, a:Array):void
-(void)setPile:(int)x intValue:(int)y arrayValue:(NSMutableArray *)a
{
//    var offset1:int = _w * _h;
//    var offset2:int = (y * _w + x);
//    for (var i:int = 0; i < _d; i++)
//        _a[int(i * offset1 + offset2)] = a[i];
    int offset1 = _w * _h;
    int offset2 = y * _w + x;
    for (int i=0; i < _d; i++) {
        [_a insertObject:[_a objectAtIndex:i] atIndex:(i * offset1 + offset2)];
    }
}
#pragma mark Protocol_GP_collection.
/**
 * @inheritDoc
 */
//public function contains(obj:*):Boolean
-(BOOL)contains:(id)obj
{
//var k:int = size;
//for (var i:int = 0; i < k; i++)
//{
//    if (_a[i] === obj)
//        return true;
//}
//return false;
    int k = [self size];
    for (int i=0; i < k; i++) {
        if ([[_a objectAtIndex:i] isEqual:obj]) {
            return YES;
        }
    }
    return NO;
}

/**
 * @inheritDoc
 */
//public function clear():void
-(void)clear
{
//    _a = new Array(size);
    _a = [[NSMutableArray alloc] initWithCapacity:[self size]];
}

/**
 * @inheritDoc
 */
//public function getIterator():Iterator
-(GP_Array3Iterator *)getIterator
{
//return new Array3Iterator(this);
    return [[GP_Array3Iterator alloc] Array3Iterator:self];
}

/**
 * @inheritDoc
 */
//public function get size():int
-(int)size
{
    return _w * _h * _d;
}

/**
 * @inheritDoc
 */
//public function isEmpty():Boolean
-(BOOL)isEmpty
{
//    return false;
    return NO;
}

/**
 * @inheritDoc
 */
//public function toArray():Array
-(NSMutableArray *)toArray
{
//var a:Array = _a.concat();
//
//var k:int = size;
//if (a.length > k) a.length = k;
//return a;
    NSMutableArray *a = [_a copy];
    //
    int k = [self size];
    if ([a count] > k) {
        [a removeObjectsInRange:NSMakeRange(k, ([a count]-k))];
    }
    return a;
}

/**
 * Prints out a string representing the current object.
 * 
 * @return A string representing the current object.
 */
//public function toString():String
-(NSString *)toString
{
//return "[Array3, size=" + size + "]";
    NSString *result = [[[NSString alloc] initWithString:@"[Array3, size="] stringByAppendingFormat:@"%i",[self size]];
    return result;

}

/**
 * Prints out all elements (for debug/demo purposes).
 * 
 * @param z The layer to dump.
 * @return A human-readable representation of the structure.
 */
//public function dump(z:int):String
-(NSString *)dump:(int)z
{
//return getLayer(z).dump();
    return [[self getLayer:z] dump];
}
@end
