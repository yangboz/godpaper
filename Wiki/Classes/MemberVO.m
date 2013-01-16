//
//  MemberVO.m
//  GodpaperWiki
//
//  Created by zhou Yangbo on 11-12-4.
//  Copyright 2011 GODPAPER. All rights reserved.
//

#import "MemberVO.h"


@implementation MemberVO

@synthesize cm;

- (void) dealloc {
	
	[cm release];
	
	[super dealloc];
}

@end
