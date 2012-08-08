//
//  GPArray2.h
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-1.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GP_Collection.h"

@interface GP_Array2 : NSObject <GP_Collection>
{
    int _w,_h;
    BOOL _celled;
    
    @private 
        NSMutableArray *_a;
}

@property(assign) NSInteger width;
@property(assign) NSInteger height;

-(void)fill:(id)obj;

-(id)gett:(int)x intValue:(int)y;
-(void)sett:(int)x intValue:(int)y idValue:(id)obj;

-(void)setXs:(int)y arrayValue:(NSMutableArray *)objs;
-(void)setYs:(int)x arrayValue:(NSMutableArray *)objs;

-(void)resize:(int)w intValue:(int)h;

-(NSMutableArray *)getRow:(int)y;
-(void)setRow:(int)y arrayValue:(NSMutableArray *)rowArray;

-(NSMutableArray *)getCol:(int)x;
-(void)setCol:(int)x arrayValue:(NSMutableArray *)rolArray;

-(void)shiftLeft;
-(void)shiftRight;
-(void)shiftUp;
-(void)shiftDown;

-(void)appendRow:(NSMutableArray *)a;
-(void)prependRow:(NSMutableArray *)a;

-(void)appendCol:(NSMutableArray *)a;
-(void)prependCol:(NSMutableArray *)a;

-(void)transpose;

-(NSMutableArray *)getArray;

-(NSString *)toString;
-(NSString *)dump;

@property(readonly) NSInteger celled;
//Constructor
-(void)Array2:(int)w intValue:(int)h;

@end
