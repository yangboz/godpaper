#import "SPImage.h"
#import "SPTexture.h"
#import "SPRenderSupport.h"
#import "SPDisplayObject.h"
#import "SPMatrix.h"
#import "SPMacros.h"
#import "UIImageWithBuffer.h"

#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/EAGLDrawable.h>





@interface SPBitmapData : SPImage {
	GLuint fboFramebuffer;
	GLuint fboTexture;
	GLint oldFramebuffer;
	SPRenderSupport *renderSupport;
	BOOL locked;
	BOOL isScrolling;
	GLuint scrollTexture;
	
	BOOL hasSecondaryFBO;
	GLuint secondaryFBO;
	SPTexture *secondaryFBOTexture;
}

- (void)bindFBO;
- (void)clear;
- (void)floodFill:(UIColor*)color;
- (void)drawDisplayObject:(SPDisplayObject*)drawItem;
- (void)floodFillWithDisplayObject:(SPDisplayObject*)drawItem;
- (void)lock;
- (void)unlock;
- (UIImageWithBuffer*)createImage;

@end
