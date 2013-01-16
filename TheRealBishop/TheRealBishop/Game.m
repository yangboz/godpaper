//
//  Game.m
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-15.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import "Game.h"
#import "GP_ChessBoard.h"

#define USE_DEPTH_BUFFER 1
#define DEGREES_TO_RADIANS(__ANGLE) ((__ANGLE) / 180.0 * M_PI)

@implementation Game

-(id)initWithWidth:(float)width height:(float)height
{
    if (self == [super initWithWidth:width height:height]) {
        // this is where the code of your game will start. 
        // in this sample, we add just a simple quad to see 
        // if it works.
        SPQuad *quad = [SPQuad quadWithWidth:self.stage.width height:self.stage.height];
        quad.color = 0xffff00;
        quad.x = 0;
        quad.y = 0;
        [self addChild:quad];
                
        //Try to fix up the error(8CD6 (GL_FRAMEBUFFER_INCLOMPLETE_ATTACHMENT) )
        //@see http://stackoverflow.com/questions/8990770/failed-to-make-complete-framebuffer-object-8cd6-ios-programmatically-created-o
        [self setupView];
        [self checkGLError:YES];
        //Chess board test
        SPImage *background = [SPImage imageWithContentsOfFile:@"background_chinese_chess_jam.png"];
        [self addChild:background];
//        SPTexture *bgTexture = [SPTexture textureWithContentsOfFile:@"background_chinese_chess_jam.png"];
//        GP_ChessBoard *board = [[GP_ChessBoard alloc] init];
//        GP_ChessBoard *board = [[GP_ChessBoard alloc] initWithUpState:bgTexture];
//        [board setLabel:@"GP_ChessBoard"];
//        [self addChild:board];
    }
    return self;
}

-(void)destroyFrameBuffer
{
    //Tear down GL
//    if (defaultFramebuffer)
//    {
//        glDeleteFramebuffersOES(1, &defaultFramebuffer);
//        defaultFramebuffer = 0;
//    }
//    
//    if (colorRenderbuffer)
//    {
//        glDeleteRenderbuffersOES(1, &colorRenderbuffer);
//        colorRenderbuffer = 0;
//    }
}

-(void)createFrameBuffer
{
    // Create default framebuffer object. The backing will be allocated for the current layer in -resizeFromLayer
//    glGenFramebuffersOES(1, &defaultFramebuffer);
//    glBindFramebufferOES(GL_FRAMEBUFFER_OES, defaultFramebuffer);
//    
//    glGenRenderbuffersOES(1, &colorRenderbuffer);
//    glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
//    
//    glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, colorRenderbuffer);
}
//@see http://www.cocoachina.com/wiki/index.php?title=OpenGL_ES_00_-_Xcode_Project_Set_Up
//- (void)drawView {
//    [EAGLContext setCurrentContext:context];   
//    glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
//    glViewport(0, 0, backingWidth, backingHeight);
//    glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
//    [context presentRenderbuffer:GL_RENDERBUFFER_OES];
//}

- (void)setupView {
    const GLfloat zNear = 0.1, zFar = 1000.0, fieldOfView = 60.0;
    GLfloat size;
    glEnable(GL_DEPTH_TEST);
    glMatrixMode(GL_PROJECTION);
    size = zNear * tanf(DEGREES_TO_RADIANS(fieldOfView) / 2.0);
//    size = zNear * tanf([self degreesToRadians:fieldOfView] / 2.0);
    // This give us the size of the iPhone display
    CGRect rect = CGRectMake([[self bounds] x], [[self bounds] y], [[self bounds] width], [[self bounds] height]);
    glFrustumf(-size, size, -size / (rect.size.width / rect.size.height), size / (rect.size.width / rect.size.height), zNear, zFar);
    glViewport(0, 0, rect.size.width, rect.size.height);
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
}

-(void)checkGLError:(BOOL)visibleCheck {
    GLenum error = glGetError();
    switch (error) {
        case GL_INVALID_ENUM:
            NSLog(@"GL Error: Enum argument is out of range");
            break;
        case GL_INVALID_VALUE:
            NSLog(@"GL Error: Numeric value is out of range");
            break;
        case GL_INVALID_OPERATION:
            NSLog(@"GL Error: Operation illegal in current state");
            break;
        case GL_STACK_OVERFLOW:
            NSLog(@"GL Error: Command would cause a stack overflow");
            break;
        case GL_STACK_UNDERFLOW:
            NSLog(@"GL Error: Command would cause a stack underflow");
            break;
        case GL_OUT_OF_MEMORY:
            NSLog(@"GL Error: Not enough memory to execute command");
            break;
        case GL_NO_ERROR:
            if (visibleCheck) {
                NSLog(@"No GL Error");
            }
            break;
        default:
            NSLog(@"Unknown GL Error");
            break;
    }
}
//Utils
-(CGFloat) degreesToRadians:(CGFloat) degrees
{
    return degrees * M_PI / 180;
};

-(CGFloat) radiansToDegrees:(CGFloat) radians
{
    return radians * 180 / M_PI;
};

@end
