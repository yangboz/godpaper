#import <UIKit/UIKit.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

#import <Foundation/Foundation.h>


@interface UIImageWithBuffer : UIImage{
	GLubyte *buffer;
}
@property (nonatomic, assign) GLubyte *buffer;

@end
