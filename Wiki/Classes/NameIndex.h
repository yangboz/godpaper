//
//  NameIndex.h
//  GodpaperWiki
//
//  Created by zhou Yangbo on 11-10-17.
//  Copyright 2011 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NameIndex : NSObject {
	NSString *firstLetter;
	
	NSInteger sectionNum;
	NSInteger originIndex;
}

@property(nonatomic,retain) NSString *firstLetter;
@property(nonatomic) NSInteger sectionNum;
@property(nonatomic) NSInteger originIndex;

- (NSString *) getFirstLetter;

@end
