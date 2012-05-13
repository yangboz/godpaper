//
//  SummaryVO.m
//  GodpaperWiki
//
//  Created by zhou Yangbo on 12-4-29.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import "SummaryVO.h"

@implementation SummaryVO

@synthesize title,summary;

-(void) dealloc
{
	[title release];
	[summary release];
	[super dealloc];
}

@end
