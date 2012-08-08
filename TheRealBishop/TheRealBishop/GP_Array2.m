//
//  GP_Array2.m
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-1.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import "GP_Array2.h"
#import "GP_Array2Iterator.h"

@implementation GP_Array2
//@synthesize width,height,celled,size;

/**
 * Initializes a two-dimensional array to match a given width and
 * height. The smallest possible size is a 1x1 matrix. The initial value
 * of all elements is null.
 * 
 * @param w The width  (equals number of colums).
 * @param h The height (equals number of rows).
 */
//Constructor
-(void)Array2:(int)w intValue:(int)h
{
//    if (w < 1 || h < 1)
//        throw new Error("illegal size");
//    _a = new Array(_w = w, _h = h);
//    fill(null);
    if (w<1 || h<1) {
        @throw([NSException exceptionWithName:@"illegal siz" reason:@"Array2" userInfo:NULL]);
    }
    _w = w; _h = h;
    _a = [NSMutableArray arrayWithObjects:(NSNumber *)_w,(NSNumber *)_h, nil];
    [self fill:NULL];
}

//@properties
//width
-(void)setWidth:(NSInteger)width
{
//    resize(w, _h);
    [self resize:width intValue:_h];
}
/**
 * Indicates the width (colums).
 * If a new width is set, the two-dimensional array is resized
 * accordingly. The minimum value is 2.
 */
-(int)width
{
    return _w;
}
//height
-(void)setHeight:(NSInteger)height
{
//    resize(_w, h);
    [self resize:_w intValue:height];
}
/**
 * Indicates the height (rows).
 * If a new height is set, the two-dimensional array is resized
 * accordingly. The minimum value is 2.
 */
-(int)height
{
    return _h;
}
/**
* @return total cell be filled or cell-free.
*/	
-(int)celled
{
//    var _celled:int = 0;
//    for(var h:int=0;h<height;h++)
//    {
//        for(var w:int=0;w<width;w++)
//        {
//            if(this.gett(w,h))
//            {
//                _celled++;
//            }
//        }
//    }
    int celled=0;
    for (int h=0; h< _h; h++) {
        for (int w=0; w< _w; w++) {
            if ([self gett:w intValue:h]) {
                celled++;
            }
        }
    }
    return celled;
}
//Methods

/**
 * Writes a given value into each cell of the two-dimensional array. If
 * the obj parameter if of type Class, the method creates individual
 * instances of this class for all array cells.
 * 
 * @param item The item to be written into each cell.
 */
-(void)fill:(id)obj
{
//    var k:int = _w * _h;
//    var i:int;
//    
//    if (obj is Class)
//    {
//        var c:Class = obj as Class;
//        for (i = 0; i < k; i++)
//            _a[i] = new c();	
//    }
//    else
//    {
//        for (i = 0; i < k; i++)
//            _a[i] = obj;
//    }
    int k = _w * _h;
    int i;
    
    if ( [obj isKindOfClass:NSObject.class]==YES ) {
//        Class *c = (Class *)obj;
        for (i=0; i<k; i++) {
            [_a insertObject:[[obj alloc] init] atIndex:i];//FIXME: with obj-c class init constructor.
        }
    }else {
        for (i=0; i<k; i++) {
            [_a insertObject:obj atIndex:i];
        }
    }
}
/**
 * Reads a value from a given x/y index. No boundary check is done, so
 * you have to make sure that the input coordinates do not exceed the
 * width or height of the two-dimensional array.
 *
 * @param x The x index (column).
 * @param y The y index (row).
 * 
 * @return The value at the given x/y index.
 */
-(id)gett:(int)x intValue:(int)y
{
//    return _a[int(y * _w + x)];
    return [_a objectAtIndex:(int)(y*_w+x)];
}
/**
 * Writes a value into a cell at the given x/y index. Because of
 * performance reasons no boundary check is done, so you have to make
 * sure that the input coordinates do not exceed the width or height of
 * the two-dimensional array.
 *
 * @param x   The x index (column).
 * @param y   The y index (row).
 * @param obj The item to be written into the cell.
 */
-(void)sett:(int)x intValue:(int)y idValue:(id)obj;
{
//    _a[int(y * _w + x)] = obj;
    [_a insertObject:obj atIndex:(int)(y*_w+x)];
}
/**
 * Writes values horiztontally. 
 * @param y The y index (row).
 * @param objs The items to be writtten into the cell.
 * 
 */
-(void)setXs:(int)y arrayValue:(NSMutableArray *)objs
{
//    for(var i:int=0;i<objs.length;i++)
//    {
//        this.sett(i,y,objs[i]);
//    }
    for (int i=0; i<[objs count]; i++) {
        [self sett:i intValue:y idValue:[objs objectAtIndex:i]];
    }
}
/**
 * Writes values vertically. 
 * @param The x index (column).
 * @param objs The items to be writtten into the cell.
 * 
 */
-(void)setYs:(int)x arrayValue:(NSMutableArray *)objs
{
//    for(var i:int=0;i<objs.length;i++)
//    {
//        this.sett(x,i,objs[i]);
//    }
    for (int i=0; i<[objs count]; i++) {
        [self sett:x intValue:i idValue:[objs objectAtIndex:i]];
    }
}
/**
 * Resizes the array to match the given width and height. If the new
 * size is smaller than the existing size, values are lost because of
 * truncation, otherwise all values are preserved. The minimum size
 * is a 1x1 matrix.
 * 
 * @param w The new width (cols).
 * @param h The new height (rows).
 */
-(void)resize:(int)w intValue:(int)h
{
//    if (w < 1 || h < 1)
//        throw new Error("illegal size");
//    
//    var copy:Array = _a.concat();
//    
//    _a.length = 0;
//    _a.length = w * h;
//    
//    var minx:int = w < _w ? w : _w;
//    var miny:int = h < _h ? h : _h;
//    
//    var x:int, y:int, t1:int, t2:int;
//    for (y = 0; y < miny; y++)
//    {
//        t1 = y *  w;
//        t2 = y * _w;
//        
//        for (x = 0; x < minx; x++)
//            _a[int(t1 + x)] = copy[int(t2 + x)];
//    }
//    
//    _w = w;
//    _h = h;
    if (w<1 || h<1) {
        @throw([NSException exceptionWithName:@"illegal size" reason:@"Array2->resize" userInfo:NULL]);
    }
    //
    NSMutableArray *copy = [_a copy];
    [_a removeAllObjects];
    _a = [[NSMutableArray alloc] initWithCapacity:(w*h) ];
    //
    int minx = (w<_w)?w:_w;
    int miny = (h<_h)?h:_h;
    //
    int x,y,t1,t2;
    for( y=0; y < miny; y++)
    {
        t1 = y * w;
        t2 = y * _w;
        //
        for( x=0; x < minx; x++)
        {
            [_a insertObject:[copy objectAtIndex:(t2+x)] atIndex:(t1+x)];
        }
    }
    //
    _w = w;
    _h = h;
}
/**
 * Extracts a row from a given index.
 * 
 * @param y The row index.
 * 
 * @return An array storing the values of the row.
 */
-(NSMutableArray *)getRow:(int)y
{
//    var offset:int = y * _w;
//    return _a.slice(offset, offset + _w);
    int offset = y * _w;
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[_a subarrayWithRange:NSMakeRange(offset, _w)]];
    return array;
}
/**
 * Inserts new values into a complete row of the two-dimensional array. 
 * The new row is truncated if it exceeds the existing width.
 *
 * @param y The row index.
 * @param a The row's new values.
 */
-(void)setRow:(int)y arrayValue:(NSMutableArray *)rowArray
{
//    if (y < 0 || y > _h) throw new Error("row index out of bounds");
//    
//    var offset:int = y * _w;
//    for (var x:int = 0; x < _w; x++)
//        _a[int(offset + x)] = a[x];	
    if (y <0 || y > _h) {
        @throw([NSException exceptionWithName:@"row index out of bounds" reason:@"Array2->setRow" userInfo:NULL]);
    }
    //
    int offset = y * _w;
    for (int x=0; x < _w; x++) {
        [_a insertObject:[_a objectAtIndex:x] atIndex:(offset + x)];
    }
}
/**
 * Extracts a column from a given index.
 * 
 * @param x The column index.
 * 
 * @return An array storing the values of the column.
 */
-(NSMutableArray *)getCol:(int)x
{
//    var t:Array = [];
//    for (var i:int = 0; i < _h; i++)
//        t[i] = _a[int(i * _w + x)];
//    return t;
    NSMutableArray *t = [[NSMutableArray alloc] init];
    for (int i=0; i < _h; i++) {
        [t insertObject:[_a objectAtIndex:(i * _w +x)] atIndex:i];
    }
    return t;
}
/**
 * Inserts new values into a complete column of the two-dimensional
 * array. The new column is truncated if it exceeds the existing height.
 *
 * @param x The column index.
 * @param a The column's new values.
 */
-(void)setCol:(int)x arrayValue:(NSMutableArray *)rolArray
{
//    if (x < 0 || x > _w) throw new Error("column index out of bounds");
//    
//    for (var y:int = 0; y < _h; y++)
//        _a[int(y * _w + x)] = a[y];	
    if (x < 0 || x > _w) {
        @throw([NSException exceptionWithName:@"column index out of bounds" reason:@"Array2->setCol" userInfo:NULL]);
    }
    //
    for ( int y=0; y < _h; y++) {
        [_a insertObject:[_a objectAtIndex:y ] atIndex:( y * _w + x)];
    }
}
/**
 * Shifts all columns by one column to the left. Columns are wrapped,
 * so the column at index 0 is not lost but appended to the rightmost
 * column.
 */
-(void)shiftLeft
{
//    if (_w == 1) return;
//    
//    var j:int = _w - 1, k:int;
//    for (var i:int = 0; i < _h; i++)
//    {
//        k = i * _w + j;
//        _a.splice(k, 0, _a.splice(k - j, 1));
//    }
    if( _w == 1 ) return;
    //
    int j = _w - 1, k;
    for (int i=0; i< _h; i++) {
        k = i * _w + j;
        [_a removeObjectAtIndex:(k - j)];//FIXME:double check here. 
    }
}
/**
 * Shifts all columns by one column to the right. Columns are wrapped,
 * so the column at the last index is not lost but appended to the
 * leftmost column.
 */
-(void)shiftRight
{
//    if (_w == 1) return;
//    
//    var j:int = _w - 1, k:int;
//    for (var i:int = 0; i < _h; i++)
//    {
//        k = i * _w + j;
//        _a.splice(k - j, 0, _a.splice(k, 1));
//    }
    if (_w == 1) return;
    //
    int j = _w - 1, k;
    for (int i=0; i < _h; i++) {
        k = i * _w + j;
        [_a removeObjectAtIndex:k];//FIXME:double check here.
    }
}
/**
 * Shifts all rows up by one row. Rows are wrapped, so the first row
 * is not lost but appended to bottommost row.
 */
-(void)shiftUp
{
//    if (_h == 1) return;
//    
//    _a = _a.concat(_a.slice(0, _w));
//    _a.splice(0, _w);
    if ( _h == 1) return;
    //
    _a = [NSMutableArray arrayWithArray: [_a arrayByAddingObjectsFromArray:[_a subarrayWithRange:NSMakeRange(0, _w)] ] ];
    [_a removeObjectsInRange:NSMakeRange(0, _w)];
}
/**
 * Shifts all rows down by one row. Rows are wrapped, so the last row
 * is not lost but appended to the topmost row.
 */
-(void)shiftDown
{
//    if (_h == 1) return;
//    
//    var offset:int = (_h - 1) * _w;
//    _a = _a.slice(offset, offset + _w).concat(_a);
//    _a.splice(_h * _w, _w);
    if (_h == 1) return;
    //
    int offset = (_h - 1) * _w;
    NSArray *sub = [_a subarrayWithRange:NSMakeRange(offset,_w)];
    _a = [ [NSMutableArray alloc] initWithArray:sub];
    [_a addObjectsFromArray:[_a copy] ];
    [_a removeObjectsInRange:NSMakeRange(_h * _w, _w)];
}
/**
 * Appends a new row. If the new row doesn't match the current width,
 * the inserted row gets truncated or widened to match the existing
 * width.
 *
 * @param a The row to append.
 */
-(void)appendRow:(NSMutableArray *)a
{
//    a.length = _w;
//    _a = _a.concat(a);
//    _h++;
    a = [NSMutableArray arrayWithCapacity:_w];
    _a = [NSMutableArray arrayWithArray: [_a arrayByAddingObjectsFromArray:[a copy]] ];
    _h++;
}
/**
 * Prepends a new row. If the new row doesn't match the current width,
 * the inserted row gets truncated or widened to match the existing
 * width.
 *
 * @param a The row to prepend.
 */
-(void)prependRow:(NSMutableArray *)a
{
//    a.length = _w;
//    _a = a.concat(_a);
//    _h++;
    a = [NSMutableArray arrayWithCapacity:_w];
    _a =[NSMutableArray arrayWithArray: [a arrayByAddingObjectsFromArray:[_a copy]] ] ;
    _h++;
}
/**
 * Appends a new column. If the new column doesn't match the current
 * height, the inserted column gets truncated or widened to match the
 * existing height.
 *
 * @param a The column to append.
 */
-(void)appendCol:(NSMutableArray *)a
{
//    a.length = _h;
//    for (var y:int = 0; y < _h; y++)
//        _a.splice(y * _w + _w + y, 0, a[y]);
//    _w++;
    a = [NSMutableArray arrayWithCapacity:_w];
    for (int y=0; y < _h; y++) {
//        [_a removeObjectAtIndex:(y * _w + _w + y)];//FIXME:double check here.
        [_a insertObject:[a objectAtIndex:y] atIndex:(y * _w + _w + y)];
    }
    _w++;
}
/**
 * Prepends a new column. If the new column doesn't match the current
 * height, the inserted column gets truncated or widened to match the
 * existing height.
 *
 * @param a The column to prepend.
 */
-(void)prependCol:(NSMutableArray *)a
{
//    a.length = _h;
//    for (var y:int = 0; y < _h; y++)
//        _a.splice(y * _w + y, 0, a[y]);
//    _w++;
    a = [NSMutableArray arrayWithCapacity:_w];
    for (int y=0; y < _h; y++) {
//        [_a removeObjectAtIndex:(y * _w + y)];//FIXME:double check here.
        [_a insertObject:[a objectAtIndex:y] atIndex:(y * _w + y)];
    }
    _w++;
}
/**
 * Flips rows with cols and vice versa.
 */
-(void)transpose
{
//    var a:Array = _a.concat();
//    for (var y:int = 0; y < _h; y++)
//    {
//        for (var x:int = 0; x < _w; x++)
//            _a[int(x * _w + y)] = a[int(y * _w + x)];
//    }
    NSMutableArray *a = [_a copy];
    for (int y=0; y < _h; y++) {
        for (int x = 0; x < _w; x++) {
            [_a insertObject:[a objectAtIndex:(y * _w + x)] atIndex:(x * _w + y)];
        }
    }
}
/**
 * Grants access to the the linear array which is used internally to
 * store the data in the two-dimensional array. Use with care for
 * advanced operations.
 */
-(NSMutableArray *)getArray
{
    return _a;
}
//Protocol implementations
#pragma mark protocol#GP_Collection
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
        if ( [[_a objectAtIndex:i] isEqual:obj]) {
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
-(id)getIterator
{
//return new Array2Iterator(this);
    return [[GP_Array2Iterator alloc] Array2Iterator:self];
}

/**
 * @inheritDoc
 */
//public function get size():int
-(int)size
{
    return _w * _h;
}

/**
 * @inheritDoc
 */
//public function isEmpty():Boolean
-(BOOL)isEmpty
{
//return false;
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
    NSMutableArray *a = [NSMutableArray arrayWithArray:[_a copy]];
    //
    int k = [self size];
    if ([a count] > k) {
        [a removeObjectsInRange:NSMakeRange(k, ([a count]-k))];
    }
    return a;
}
#pragma mark Utility
/**
 * Prints out a string representing the current object.
 * 
 * @return A string representing the current object.
 */
-(NSString *)toString
{
//    return "[Array2, width=" + width + ", height=" + height + "]";
    NSString *result = [[[NSString alloc] initWithString:@"[Array2, width="] stringByAppendingFormat:@"%i",[self width]];
    result = [result stringByAppendingFormat:@"%@ %i %@",@"height= ",[self height],@"["];
    return result;
}
/**
 * Prints out all elements (for debug/demo purposes).
 * 
 * @return A human-readable representation of the structure.
 */
-(NSString *)dump
{
//    var s:String = "Array2\n{";
//    var offset:int, value:*;
//    for (var y:int = 0; y < _h; y++)
//    {
//        s += "\n" + "\t";
//        offset = y * _w;
//        for (var x:int = 0; x < _w; x++)
//        {
//            value = _a[int(offset + x)];
//            s += "[" + (value != undefined ? value : "?") + "]";
//        }
//    }
//    s += "\n}";
//    return s;
//TDODO:
    return @"";
}


@end