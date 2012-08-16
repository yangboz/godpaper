//
//  GP_IType.h
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-16.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 * This artifacts "type",it is not only a classfication of chess piece type,
 * but also sort some chess pieces' variety.
 */
@protocol GP_IType <NSObject>
{
    @private
        NSString *type;
}
//--------------------------------------------------------------------------
//
//  Public properties
//
//-------------------------------------------------------------------------- 
//function set type(value:String):void;
//function get type():String;
@property(nonatomic,retain) NSString *type;
//--------------------------------------------------------------------------
//
//  Public methods
//
//--------------------------------------------------------------------------
@end
