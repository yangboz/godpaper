#import "RestClient.h"
#import "RestClientBlockRunner.h"
#import "RestClientURLConnectionInvocation.h"
#import "NSData+Base64.h"
#import "NSString+SBJSON.h"

@implementation RestClient

@synthesize prefix, headers, blockRunner;

- (id) init {
  self = [super init];
  self.prefix = @"";
  headers = [[NSDictionary alloc] init];
  blockRunner = [[RestClientBlockRunner alloc] init];
  return self;
}

- (id) initWithPrefix:(NSString *)aPrefix andHeaders:(NSDictionary *)someHeaders {
  self = [super init];
  self.prefix = aPrefix;
  self.headers = someHeaders;
  blockRunner = [[RestClientBlockRunner alloc] init];
  return self;
}

-(void)addHeaders:(NSMutableURLRequest*)request {
  NSEnumerator *enumerator = [headers keyEnumerator];
  id key;
  while ((key = [enumerator nextObject])) {
    [request setValue:[headers objectForKey:key]  forHTTPHeaderField:key];
  }
  // [request setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]  forHTTPHeaderField:@"X-MaptiniVersion"];
  // [request setValue:[[UIDevice currentDevice] model]                                          forHTTPHeaderField:@"X-MaptiniPlatform"];
  // [request setValue:userAPIToken                                                             forHTTPHeaderField:@"X-MaptiniToken"];
}

- (NSMutableURLRequest *)newRequest:(NSString*)method
                                 path:(NSString*)path
                                 body:(NSString*)body {
  NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
  [request setURL:[NSURL URLWithString:[NSMutableString stringWithFormat:@"%@%@", prefix, path]]];
  [request setHTTPMethod:method];
  if (body) {
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
    [request setValue:[NSString stringWithFormat:@"%d", [data length]] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"text/x-json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:data];
  }
  [self addHeaders:request];
  return request;
}  

-(NSString *)execute:(NSString*)method path:(NSString*)path body:(NSString*)body {
	NSMutableURLRequest* request = [self newRequest:method path:path body:body];

  NSHTTPURLResponse *response = nil;
  NSError *error = nil;
  NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
  [request release];
  if (RC_LOG) {
    if (body) {
      NSLog(@"%@ %@%@ => %i\n : %@", method, prefix, path, [response statusCode], body);
    } else if ([path hasSuffix:@"/version.json"]) {
      // ignore
    } else {
      NSLog(@"%@ %@%@ => %i", method, prefix, path, [response statusCode]);
    }
  }
  
  if (error) {
    if (RC_LOG) {NSLog(@"Rest Client Error UserInfo: %@", error.userInfo);}
    @throw [NSException exceptionWithName:[error localizedFailureReason] 
                                   reason:[error localizedDescription]
                                 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:
                                           error, @"error",
                                           [NSNumber numberWithInt:[error code]], @"errorCode",
                                           path, @"path",
                                           body, @"body",
                                           nil]];
  } else if ([response statusCode] == 200) {
    return [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    
  } else {
    NSString *rawResponse = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    NSLog(@"raw response : %@", rawResponse);
    NSString *errorMessage = [RestClientURLConnectionInvocation parseError:rawResponse];

    if (RC_LOG) {NSLog(@"Rest Client Error StatusCode: %i : %@", [response statusCode], errorMessage);}
    @throw [NSException exceptionWithName:errorMessage
                                   reason:errorMessage
                                 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:
                                           [NSNumber numberWithInt:[response statusCode]], @"statusCode",
                                           path, @"path",
                                           body, @"body",
                                           errorMessage, NSLocalizedDescriptionKey,
                                           nil]];
  }
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
  NSLog(@"You got challenged");
}

- (NSString *) get:(NSString *)path {
  return [self execute:@"GET" path:path body:nil];
}

- (NSString *)get:(NSString *)path withBody:(NSString *)body {
  return [self execute:@"GET" path:path body:nil];
}

- (NSString *) post:(NSString *)path withBody:(NSString *)body {
  return [self execute:@"POST" path:path body:body];
}

- (NSString *)put:(NSString *)path withBody:(NSString *)body {
  return [self execute:@"PUT" path:path body:body];
}

- (NSString *)delete:(NSString *)path withBody:(NSString *)body{
  return [self execute:@"DELETE" path:path body:body];
}

- (NSString*) delete:(NSString *)path {
  return [self execute:@"DELETE" path:path body:nil];
}

- (void)startWaiting {
  [UIApplication sharedApplication].networkActivityIndicatorVisible = true;
  [[NSNotificationCenter defaultCenter] postNotificationName:RestClientStartWaiting object:nil];
}

- (void)stopWaiting {
  [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
  [[NSNotificationCenter defaultCenter] postNotificationName:RestClientStopWaiting object:nil];
}

- (void)executeAsync:(NSString*)method
                path:(NSString*)path
                body:(NSString*)body
                wait:(BOOL)wait
             success:(void (^)(id))onSuccess
               error:(void (^)(NSError *))onError {
  NSMutableURLRequest *request = [self newRequest:method path:path body:body];
  RestClientURLConnectionInvocation *invocation = [[RestClientURLConnectionInvocation alloc] initWithRequest:request
                                                                                        wait:wait
                                                                                     success:onSuccess 
                                                                                       error:onError];
  [invocation start];
  [request release];
  [invocation release];
}

- (void) get:(NSString *)path wait:(BOOL)wait success:(void (^)(id))onSuccess error:(void (^)(NSError *))onError{
  [self executeAsync:@"GET" path:path body:nil wait:wait success:onSuccess error:onError];
}

- (void) post:(NSString *)path withBody:(NSString*)body wait:(BOOL)wait success:(void (^)(id))onSuccess error:(void (^)(NSError *))onError{
  [self executeAsync:@"POST" path:path body:body wait:wait success:onSuccess error:onError];
}

- (void) put:(NSString *)path withBody:(NSString*)body wait:(BOOL)wait success:(void (^)(id))onSuccess error:(void (^)(NSError *))onError{
  [self executeAsync:@"PUT" path:path body:body wait:wait success:onSuccess error:onError];
}

- (void) delete:(NSString *)path wait:(BOOL)wait success:(void (^)(id))onSuccess error:(void (^)(NSError *))onError{
  [self executeAsync:@"DELETE" path:path body:nil wait:wait success:onSuccess error:onError];
}

-(void)dealloc {
  self.prefix = nil;
  self.headers = nil;
  self.blockRunner = nil;
	[super dealloc];
}

@end
