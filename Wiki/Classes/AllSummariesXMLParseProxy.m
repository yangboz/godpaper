//
//  AllSummariesXMLParseProxy.m
//  GodpaperWiki
//
//  Created by zhou Yangbo on 12-4-29.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import "AllSummariesXMLParseProxy.h"

//
//  AllImagesXMLParseProxy.m
//  GodpaperWiki
//
//  Created by zhou Yangbo on 11-12-8.
//  Copyright 2011 GODPAPER. All rights reserved.
//

#import "AllSummariesXMLParseProxy.h"
#import "AllSummariesModel.h"

@implementation AllSummariesXMLParseProxy

@synthesize summaryVO,summaryVOs;


-(AllSummariesXMLParseProxy *)initXMLParser
{
	[super init];
	//init array of category objects
	summaryVOs = [[NSMutableDictionary alloc] init];
	//
	return self;
}

-(void)parseApiXML:(NSURL *)url
{
	//create and init NSXMLParser object
	NSXMLParser *nsXmlParser = [[NSXMLParser alloc] initWithContentsOfURL: url];
	//create and init our delegate
	AllSummariesXMLParseProxy *parser = [[AllSummariesXMLParseProxy alloc] initXMLParser];
	//set delegate
	[nsXmlParser setDelegate:parser];
	//parsing...
	BOOL success = [nsXmlParser parse];
	if (success) {
		NSLog(@"No errors - images count : %i", [[parser summaryVOs] count]);
	}else {
		NSLog(@"Error parsing document!!!");
	}
	
	//release 
	[nsXmlParser release];
	//store this images to singleton model.
	[AllSummariesModel setData:[[parser summaryVOs] copy]];
}
//NSXMLParse delegate functions here.
//  <c>INDEX</c>

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName 
	attributes:(NSDictionary *)attributeDict   
{
	if (qName) elementName = qName;
	if (elementName) [currentElementValue appendString:@""];
	//
	if ([elementName isEqualToString:@"article"]) {
		NSLog(@"image element found – create a new instance of ImageVO class...");
		summaryVO = [[SummaryVO alloc] init];
		//We do not have any attributes in the user elements, but if
		// you do, you can extract them here: 
		summaryVO.title = [attributeDict objectForKey:@"title"];
		summaryVO.summary = [attributeDict objectForKey:@"summary"];
		//NSString *title = [attributeDict objectForKey:@"title"]; 
		NSLog(@"summary element attribute(name) found:%@",[summaryVO title]);
		NSLog(@"summary element attribute(url) found:%@",[summaryVO summary]);
        
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName
{
	if ([elementName isEqualToString:@"query"]) {
		// We reached the end of the XML document
		return;
	}
	if ([elementName isEqualToString:@"summaries"]) {
		// We are done with user entry – add the parsed subject 
		// object to our user array
		//[imageVOs addObject:imageVO];
		NSArray* subStrings = [[summaryVO title] componentsSeparatedByString:@"."]; //@exampel:老虎棋.png
		NSString *trimedName = [[subStrings objectAtIndex:0] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		NSLog(@"Trimed name:%@",trimedName);
		[summaryVOs setValue:[summaryVO title] forKey:trimedName];
		//NSLog(@"imageVOs:%@",imageVOs);
		//NSString *imgUrl = [summaryVO objectForKey:trimedName];
		//NSLog(@"GetObjectByTrimedName:%@",imgUrl);
		// release category object
		[summaryVO release];
		summaryVO = nil;
	} else {
		// The parser hit one of the element values. 
		// This syntax is possible because SubjectVO object 
		// property names match the XML subject element names   
		[summaryVO setValue:currentElementValue forKey:elementName];
		//NSLog(@"current category:%@",[member cm]);
	}
	
	NSLog(@"Current elementName:%@",elementName);
	
	[currentElementValue release];
	currentElementValue = nil;
}

//- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
//{
//	if (!currentElementValue) {
//		// init the element string with the value     
//		currentElementValue = [[NSMutableString alloc] initWithString:@""];
//	}
//	// append value to the element string   
//	[currentElementValue appendString:string];
//	NSLog(@"Processing value for : %@", string);
//	//NSLog(@"Processing currentElementValue : %@", currentElementValue);
//}

//
-(void) parserDidStartDocument:(NSXMLParser *)parser {
	NSLog(@"parserDidStartDocument!!!"); 	
}

-(void) parserDidEndDocument: (NSXMLParser *)parser {
	NSLog(@"parserDidEndDocument!!!"); 
}

@end