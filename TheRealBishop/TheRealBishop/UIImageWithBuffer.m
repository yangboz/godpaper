#import "UIImageWithBuffer.h"


@implementation UIImageWithBuffer

@synthesize buffer;

- (void)dealloc{
	free(buffer);
    [super dealloc];
}

@end
