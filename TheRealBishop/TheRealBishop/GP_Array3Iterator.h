//
//  GP_Array3Iterator.h
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-9.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GP_Iterator.h"

@interface GP_Array3Iterator : NSObject <GP_Iterator>
{
    @private
//    private var _values:Array;
//	private var _length:int;
//	private var _cursor:int;
        NSMutableArray *_values;
        int _length,_cursor;
}
//Method
-(void)Array3Iterator:(NSMutableArray *)a3;
@end
