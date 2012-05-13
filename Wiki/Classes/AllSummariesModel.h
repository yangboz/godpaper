//
//  AllSummariesModel.h
//  GodpaperWiki
//
//  Created by zhou Yangbo on 12-4-29.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AllSummariesModel : NSObject
{
}

+(AllSummariesModel *)sharedInstance;

+(NSMutableDictionary *)getData;
+(void)setData:(NSMutableDictionary *)value;

@end
