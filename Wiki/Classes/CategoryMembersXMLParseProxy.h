//
//  CategoryMembersXMLParseProxy.h
//  GodpaperWiki
//
//  Created by zhou Yangbo on 11-12-4.
//  Copyright 2011 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MemberVO.h"

@class MemberVO;

@interface CategoryMembersXMLParseProxy : NSObject <NSXMLParserDelegate> {

	// an ad hoc string to hold element value
	NSMutableString *currentElementValue;
	
	//VO
	MemberVO *member;
	//array of category objects
	NSMutableArray *members;
	
}

@property(nonatomic,retain) MemberVO *member;
@property(nonatomic,retain) NSMutableArray *members;

-(void)parseApiXML:(NSURL *) url;

@end
