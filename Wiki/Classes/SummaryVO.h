//
//  SummaryVO.h
//  GodpaperWiki
//
//  Created by zhou Yangbo on 12-4-29.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SummaryVO : NSObject
{
    NSString *title;
    NSString *summary;
}

@property(nonatomic,retain) NSString *title;
@property(nonatomic,retain) NSString *summary;

@end
