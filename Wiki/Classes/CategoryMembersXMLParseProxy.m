//
//  CategoryMembersXMLParseProxy.m
//  GodpaperWiki
//
//  Created by zhou Yangbo on 11-12-4.
//  Copyright 2011 GODPAPER. All rights reserved.
//

#import "CategoryMembersXMLParseProxy.h"
#import "CategoryMembersModel.h"


@implementation CategoryMembersXMLParseProxy

@synthesize member,members;


-(CategoryMembersXMLParseProxy *)initXMLParser
{
	[super init];
	//init array of category objects
	members = [[NSMutableArray alloc] init];
	//
	return self;
}

-(void)parseApiXML:(NSURL *)url
{
	//create and init NSXMLParser object
	NSXMLParser *nsXmlParser = [[NSXMLParser alloc] initWithContentsOfURL: url];
	//create and init our delegate
	CategoryMembersXMLParseProxy *parser = [[CategoryMembersXMLParseProxy alloc] initXMLParser];
	//set delegate
	[nsXmlParser setDelegate:parser];
	//parsing...
	BOOL success = [nsXmlParser parse];
	if (success) {
		NSLog(@"No errors - categories count : %i", [[parser members] count]);
	}else {
		NSLog(@"Error parsing document!!!");
	}
	
	//release 
	[nsXmlParser release];
	//store this members to singleton model.
	[CategoryMembersModel setData:[[parser members] copy]];
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
	if ([elementName isEqualToString:@"cm"]) {
		NSLog(@"category element found – create a new instance of MemberVO class...");
		member = [[MemberVO alloc] init];
		//We do not have any attributes in the user elements, but if
		// you do, you can extract them here: 
		member.cm = [attributeDict objectForKey:@"title"];
		//NSString *title = [attributeDict objectForKey:@"title"]; 
		NSLog(@"category element attribute found:%@",[member cm]);
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
	if ([elementName isEqualToString:@"cm"]) {
		// We are done with user entry – add the parsed subject 
		// object to our user array
		[members addObject:member];
		// release category object
		[member release];
		member = nil;
	} else {
		// The parser hit one of the element values. 
		// This syntax is possible because SubjectVO object 
		// property names match the XML subject element names   
		[member setValue:currentElementValue forKey:elementName];
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
