//
//  GPArray2Iterator.h
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-6.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GP_Iterator.h"
#import "GP_Array2.h"

@interface GP_Array2Iterator : NSObject <GP_Iterator>
{
@private
    GP_Array2 *_a2;
    int _xCursor,_yCursor;
}
//Methods
-(id)Array2Iterator:(GP_Array2 *)a2;
@end
