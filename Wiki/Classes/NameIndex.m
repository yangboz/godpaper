//
//  NameIndex.m
//  GodpaperWiki
//
//  Created by zhou Yangbo on 11-10-17.
//  Copyright 2011 GODPAPER. All rights reserved.
//

#import "NameIndex.h"
#import "Pinyin.h"

@implementation NameIndex

@synthesize firstLetter;
@synthesize sectionNum,originIndex;

- (NSString *) getFirstLetter
{
	if ([firstLetter canBeConvertedToEncoding:NSASCIIStringEncoding]) {
		return firstLetter;
	}else { //None english.
		Pinyin *pinyin = [[Pinyin alloc] init];
		//return the english alphabet
		return [NSString stringWithFormat:@"%c",[pinyin pinyinFirstLetter:[firstLetter characterAtIndex:0]]];
		//
		[pinyin release];
	}


}

-(void) dealloc
{
	[firstLetter release];
	
	[super dealloc];
}

@end
