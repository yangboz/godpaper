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

@property(assign) NSInteger width;
@property(assign) NSInteger height;

-(void)fill:(id *)obj;

-(id *)get:(int)x intValue:(int)y;
-(void)set:(int)x intValue:(int)y;

-(void)setXs:(int)y arrayValue:(NSMutableArray *)xArray;
-(void)setYs:(int)x arrayValue:(NSMutableArray *)yArray;

-(void)resize:(int)width intValue:(int)height;

-(NSMutableArray *)getRow:(int)y;
-(void)setRow:(int)y arrayValue:(NSMutableArray *)rowArray;

-(NSMutableArray *)getCol:(int)y;
-(void)setCol:(int)x arrayValue:(NSMutableArray *)rolArray;

-(void)shiftLeft;
-(void)shiftRight;
-(void)shiftUp;
-(void)shiftDown;

-(void)appendRow:(NSMutableArray *)rowArray;
-(void)prependRow:(NSMutableArray *)rowArray;

-(void)appendCol:(NSMutableArray *)colArray;
-(void)prependCol:(NSMutableArray *)colArray;

-(void)transpose;

-(NSMutableArray *)getArray;

-(NSString *)toString;
-(NSString *)dump;

@property(readonly) NSInteger celled;


@end
