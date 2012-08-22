//
//  GP_Array3.h
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-8.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GP_Collection.h"
#import "GP_Array2.h"

@interface GP_Array3 : NSObject <GP_Collection>
{
//    private var _a:Array;
//    private var _w:int, _h:int, _d:int;
    @private
        NSMutableArray *_a;
        int _w,_h,_d;
}
//Properties
@property(assign) NSInteger width;
@property(assign) NSInteger height;
@property(assign) NSInteger depth;
//Methods
-(void)fill:(id)obj;

//public function Array3(w:int, h:int, d:int)
-(id)Array3:(int)w intValue:(int)h intValue:(int)d;

//public function fill(obj:*):void
-(void)fill:(id)obj;

//public function get(x:int, y:int, z:int):*
-(id)gett:(int)x intValue:(int)y intValue:(int)z;

//public function set(x:int, y:int, z:int, obj:*):void
-(void)sett:(int)x intValue:(int)y intValue:(int)z idValue:(id)obj;

//public function resize(w:int, h:int, d:int):void
-(void)resize:(int)w intValue:(int)h intValue:(int)d;

//public function getLayer(z:int):Array2
-(GP_Array2 *)getLayer:(int)z;

//public function getRow(z:int, y:int):Array
-(NSMutableArray *)getRow:(int)z intValule:(int)y;

//public function setRow(z:int, y:int, a:Array):void
-(void)setRow:(int)z intValue:(int)y arrayValue:(NSMutableArray *)a;

//public function getCol(z:int, x:int):Array
-(NSMutableArray *)getCol:(int)z intValue:(int)x;

//public function setCol(z:int, x:int, a:Array):void
-(void)setCol:(int)z intValue:(int)x arrayValue:(NSMutableArray *)a;

//public function getPile(x:int, y:int):Array
-(NSMutableArray *)getPile:(int)x intValue:(int)y;

//public function setPile(x:int, y:int, a:Array):void
-(void)setPile:(int)x intValue:(int)y arrayValue:(NSMutableArray *)a;

//public function toString():String
-(NSString *)toString;

//public function dump(z:int):String
-(NSString *)dump:(int)z;

@end
