//
//  GP_Array3Iterator.h
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-9.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GP_Iterator.h"
#import "GP_Array3.h"
#import "GP_Array3Iterator.h"

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
-(GP_Array3Iterator *)Array3Iterator:(GP_Array3 *)a3;
@end
