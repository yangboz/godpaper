//
//  AllSummariesXMLParseProxy.h
//  GodpaperWiki
//
//  Created by zhou Yangbo on 12-4-29.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SummaryVO.h"

@interface AllSummariesXMLParseProxy : NSObject <NSXMLParserDelegate>
{
    // an ad hoc string to hold element value
	NSMutableString *currentElementValue;
	
	//VO
	SummaryVO *summaryVO;
	//array of category objects
	NSMutableDictionary *summaryVOs;
}

@property(nonatomic,retain) SummaryVO *summaryVO;
@property(nonatomic,retain) NSMutableDictionary *summaryVOs;

-(void)parseApiXML:(NSURL *) url;


@end
