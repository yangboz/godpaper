//
//  SHLine.h
//  Sparrow
//
//  Created by Shilo White on 1/11/11.
//  Copyright 2011 Shilocity Productions. All rights reserved.
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the Simplified BSD License.
//

#import <Foundation/Foundation.h>
#import "SPDisplayObject.h"
#import "SPRenderSupport.h"

#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@interface SHLine : SPDisplayObject {
  @protected
	float mVertexCoords[4];
    uint mVertexColors[2];
	float mVertexAlpha[2];
	float mThickness;
}

@property (nonatomic, assign) float x2;
@property (nonatomic, assign) float y2;
@property (nonatomic, assign) uint color;
@property (nonatomic, assign) uint startColor;
@property (nonatomic, assign) uint endColor;
@property (nonatomic, assign) float startAlpha;
@property (nonatomic, assign) float endAlpha;
@property (nonatomic, assign) float thickness;

- (SHLine *)initWithSize:(float)length;
- (SHLine *)initWithLength:(float)length andThickness:(float)thickness;
- (SHLine *)initWithCoords:(float)x1 :(float)y1 :(float)x2 :(float)y2;
- (SHLine *)initWithCoords:(float)x1 :(float)y1 :(float)x2 :(float)y2 andThickness:(float)thickness;

+ (SHLine *)lineWithLength:(float)length;
+ (SHLine *)lineWithLength:(float)length andThickness:(float)thickness;
+ (SHLine *)lineWithCoords:(float)x1 :(float)y1 :(float)x2 :(float)y2;
+ (SHLine *)lineWithCoords:(float)x1 :(float)y1 :(float)x2 :(float)y2 andThickness:(float)thickness;
@end
