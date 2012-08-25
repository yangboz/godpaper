//
//  GP_IUID.h
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-16.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  The IUID interface defines the interface for objects that must have 
 *  Unique Identifiers (UIDs) to uniquely identify the object.
 *  UIDs do not need to be universally unique for most uses in Flex.
 *  One exception is for messages send by data services.
 */
@protocol GP_IUID <NSObject>
//--------------------------------------------------------------------------
//
//  Properties
//
//--------------------------------------------------------------------------

//----------------------------------
//  uid
//----------------------------------
/**
 *  The unique identifier for this object.
 */
//function get uid():String;
-(NSString *)uid;
//function set uid(value:String):void;
-(void)setUid:(NSString *)value;
//
@end
