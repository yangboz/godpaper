//
//  GP_Array2.m
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-1.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import "GP_Array2.h"

@implementation GP_Array2
//@synthesize width,height,celled;

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
    _w = width;
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
    _h = height;
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
    return _celled;
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
-(void)resize:(int)width intValue:(int)height
{

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

}
/**
 * Extracts a column from a given index.
 * 
 * @param x The column index.
 * 
 * @return An array storing the values of the column.
 */
-(NSMutableArray *)getCol:(int)y
{

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

}
/**
 * Shifts all columns by one column to the left. Columns are wrapped,
 * so the column at index 0 is not lost but appended to the rightmost
 * column.
 */
-(void)shiftLeft
{

}
/**
 * Shifts all columns by one column to the right. Columns are wrapped,
 * so the column at the last index is not lost but appended to the
 * leftmost column.
 */
-(void)shiftRight
{

}
/**
 * Shifts all rows up by one row. Rows are wrapped, so the first row
 * is not lost but appended to bottommost row.
 */
-(void)shiftUp
{

}
/**
 * Shifts all rows down by one row. Rows are wrapped, so the last row
 * is not lost but appended to the topmost row.
 */
-(void)shiftDown
{

}
/**
 * Appends a new row. If the new row doesn't match the current width,
 * the inserted row gets truncated or widened to match the existing
 * width.
 *
 * @param a The row to append.
 */
-(void)appendRow:(NSMutableArray *)rowArray
{

}
/**
 * Prepends a new row. If the new row doesn't match the current width,
 * the inserted row gets truncated or widened to match the existing
 * width.
 *
 * @param a The row to prepend.
 */
-(void)prependRow:(NSMutableArray *)rowArray
{

}
/**
 * Appends a new column. If the new column doesn't match the current
 * height, the inserted column gets truncated or widened to match the
 * existing height.
 *
 * @param a The column to append.
 */
-(void)appendCol:(NSMutableArray *)colArray
{

}
/**
 * Prepends a new column. If the new column doesn't match the current
 * height, the inserted column gets truncated or widened to match the
 * existing height.
 *
 * @param a The column to prepend.
 */
-(void)prependCol:(NSMutableArray *)colArray
{

}
/**
 * Flips rows with cols and vice versa.
 */
-(void)transpose
{

}
/**
 * Grants access to the the linear array which is used internally to
 * store the data in the two-dimensional array. Use with care for
 * advanced operations.
 */
-(NSMutableArray *)getArray
{

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
    
}

/**
 * @inheritDoc
 */
//public function clear():void
-(void)clear
{
//    _a = new Array(size);
    [_a removeAllObjects];//FIXME:equal to clear?
}

/**
 * @inheritDoc
 */
//public function getIterator():Iterator
-(id *)getIterator
{
//return new Array2Iterator(this);
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
}
#pragma mark Utility
/**
 * Prints out a string representing the current object.
 * 
 * @return A string representing the current object.
 */
-(NSString *)toString
{

}
/**
 * Prints out all elements (for debug/demo purposes).
 * 
 * @return A human-readable representation of the structure.
 */
-(NSString *)dump
{

}


@end
