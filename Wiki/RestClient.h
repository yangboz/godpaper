#define RC_LOG 1                                 // turn this on to turn on rest client logging
#define RestClientStartWaiting @"CMStartWaiting" // this NSNotification will be fired before an asynchronous call if wait == true
#define RestClientStopWaiting @"CMStopWaiting"   // this NSNotification will be fired after an asynchronous call if wait == false

@class RestClientBlockRunner;

@interface RestClient : NSObject {
  NSString *prefix;
  NSDictionary *headers;
  RestClientBlockRunner *blockRunner;
}

@property (nonatomic, retain) NSString* prefix;
@property (nonatomic, retain) NSDictionary* headers;
@property (nonatomic, retain) RestClientBlockRunner *blockRunner;

- (id)init;
- (id)initWithPrefix:(NSString *)prefix andHeaders:(NSDictionary *)headers;

- (NSString *)get:(NSString *)path;
- (NSString *)post:(NSString *)path withBody:(NSString *)body;
- (NSString *)put:(NSString *)path withBody:(NSString *)body;
- (NSString *)delete:(NSString *)path withBody:(NSString *)body;
- (NSString *)delete:(NSString *)path;

//async methods

- (void)get:    (NSString *)path                                wait:(BOOL)wait success:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;
- (void)post:   (NSString *)path withBody:(NSString *)body      wait:(BOOL)wait success:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;
- (void)put:    (NSString *)path withBody:(NSString *)body      wait:(BOOL)wait success:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;
- (void)delete: (NSString *)path                                wait:(BOOL)wait success:(void(^)(id))onSuccess error:(void(^)(NSError *))onError;

@end
