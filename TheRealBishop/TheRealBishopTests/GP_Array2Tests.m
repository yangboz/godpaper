//
//  GP_Array2Tests.m
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-9.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import "GP_Array2Tests.h"
#import "GP_Array2.h"

@implementation GP_Array2Tests

int _w,_h;
GP_Array2 *_a2;

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    _w = _h = 2;
    _a2 = [[GP_Array2 alloc] Array2:_w intValue:_h];
}

- (void)tearDown
{
    // Tear-down code here.
    _w = _h = 0;
    [_a2 release];
    //
    [super tearDown];
}

//- (void)testArray2:(int)w intValue:(int)h
- (void)testArray2
{
//    STFail(@"Unit tests are not implemented yet in TheRealBishopTests");
    STAssertTrue(_w==2,nil);
    STAssertTrue(_h==2,nil);
}
@end
