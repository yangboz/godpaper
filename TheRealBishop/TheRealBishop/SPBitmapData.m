#import "SPBitmapData.h"

const CGFloat *rgba;

@implementation SPBitmapData

- (id)initWithTexture:(SPTexture*)texture {
	self = [super initWithTexture:texture];
	renderSupport = [[SPRenderSupport alloc] init];
	locked = NO;
	isScrolling = NO;
	[self bindFBO]; // will bind the texture to a frambuffer so that we can draw to it.
    return self;
}

- (void)bindFBO {
	glGetIntegerv(GL_FRAMEBUFFER_BINDING_OES, &oldFramebuffer);
	// create framebuffer
	glGenFramebuffersOES(1, &fboFramebuffer);
	glBindFramebufferOES(GL_FRAMEBUFFER_OES, fboFramebuffer);
	glFramebufferTexture2DOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_TEXTURE_2D, self.texture.textureID, 0);
	GLuint status = glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES);
	if (status != GL_FRAMEBUFFER_COMPLETE_OES) {
		NSLog(@"Could not create the FBO");
	}
	// switch back to the old framebuffer
	glBindFramebufferOES(GL_FRAMEBUFFER_OES, oldFramebuffer);
}

- (void)clear{
	[self lock];

	glClearColor(0.0, 0.0, 0.0, 0.0);
	glClear(GL_COLOR_BUFFER_BIT);
	
	[self unlock];
}

- (void)floodFill:(UIColor*)color{
	[self lock];
	
	rgba = CGColorGetComponents(color.CGColor);
	glClearColor(rgba[0], rgba[1], rgba[2], 1);
	glClear(GL_COLOR_BUFFER_BIT);
	
	[self unlock];
}

- (void)drawDisplayObject:(SPDisplayObject*)drawItem{
	[self lock];
	
	glPushMatrix();
    glLoadIdentity();
	
	float x = drawItem.x;
	float y = drawItem.y;
	float rotation = drawItem.rotation;
	float scaleX = drawItem.scaleX;
	float scaleY = drawItem.scaleY;
	
	// translate
	if (x != 0.0f || y != 0.0f){
		glTranslatef(x, y, 0);
	}
	if (rotation != 0.0f){
		glRotatef(SP_R2D(rotation), 0.0f, 0.0f, 1.0f);
	}
	if (scaleX != 0.0f || scaleY != 0.0f){
		glScalef(scaleX, scaleY, 1.0f);
	} 
	[renderSupport bindTexture:nil];
	[drawItem render:renderSupport];

	glPopMatrix();
	[self unlock];
}

- (void)floodFillWithDisplayObject:(SPDisplayObject*)drawItem{
	[self lock];
	
	glPushMatrix();
    glLoadIdentity();
	
	int countX = ceil(self.texture.width/drawItem.width);
	int countY = ceil(self.texture.height/drawItem.height);
	[renderSupport bindTexture:nil];
	for (int y=0; y<countY; y++){
		for(int x=0; x<countX; x++){
			glLoadIdentity();
			glTranslatef((float)x * drawItem.width, (float)y * drawItem.height, 0);
			[drawItem render:renderSupport];
		}
	}
	
	glPopMatrix();
	[self unlock];
}

- (void)lock{
	locked = YES;
	glGetIntegerv(GL_FRAMEBUFFER_BINDING_OES, &oldFramebuffer);
	// switch to the texture's framebuffer for rendering
	glBindFramebufferOES(GL_FRAMEBUFFER_OES, fboFramebuffer);
    glEnable(GL_TEXTURE_2D);
    glEnable(GL_BLEND);
	glMatrixMode(GL_PROJECTION);
    glLoadIdentity(); 
	glViewport(0, 0, self.width, self.height);
	glOrthof(0.0f, self.width, 0.0f, self.height, -1.0f, 1.0f);
	glMatrixMode(GL_MODELVIEW);
	glBlendFunc(GL_ONE, GL_SRC_ALPHA);
}

- (void)unlock{
	locked = NO;
	glDisable(GL_TEXTURE_2D);
    glDisable(GL_BLEND);
	// switch back to the old framebuffer
	glBindFramebufferOES(GL_FRAMEBUFFER_OES, oldFramebuffer);
}

- (UIImageWithBuffer*)createImage{
	[self lock];
	int register w4 = self.texture.width * 4;
	NSInteger myDataLength = self.texture.width * self.texture.height * 4;
	GLubyte *buffer = (GLubyte *) malloc(myDataLength);
	glReadPixels(0 ,0, self.texture.width, self.texture.height, GL_RGBA,GL_UNSIGNED_BYTE, buffer);
	// create the image
	CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, buffer, myDataLength, NULL);//make data provider
	int bitsPerComponent = 8;
	int bitsPerPixel = 32;
	int bytesPerRow = w4;
	CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
	CGBitmapInfo bitmapInfo = kCGImageAlphaLast;
	CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
	CGImageRef imageRef = CGImageCreate(self.texture.width, self.texture.height, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpaceRef, bitmapInfo, provider, NULL, NO, renderingIntent);
    UIImageWithBuffer *img = [[UIImageWithBuffer alloc] initWithCGImage:imageRef];
	img.buffer = buffer;
	CGImageRelease(imageRef);
	CGColorSpaceRelease(colorSpaceRef);
	CGDataProviderRelease(provider);
	[self unlock];
	return [img autorelease];
}

- (void)dealloc{
	glDeleteFramebuffersOES(1, &fboFramebuffer);
    [super dealloc];
}

@end
