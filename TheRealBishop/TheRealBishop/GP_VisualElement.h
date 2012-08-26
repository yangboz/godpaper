//
//  GP_VisualElement.h
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-25.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//
#import "SPTexture.h"
#import "SPButton.h"
#import "GP_IVisualElement.h"

@interface GP_VisualElement : SPButton <GP_IVisualElement>
{
    @private
        NSString *_uid,*label;
        SPTexture *defaultUpState;
}
//
//public function get uid():String
//public function set uid(value:String):void
@property(nonatomic,retain)NSString *uid;
//
//public function get label():String
//public function set label(value:String):void
@property(nonatomic,retain)NSString *label;
//public function VisualElement(upState:Texture=null, label:String="", downState:Texture=null)
-(void)VisualElement:(SPTexture *)upState strValue:(NSString *)labell textureVal:(SPTexture *)downState;
//public function toString():String
-(NSString *)toString;
//protected function getUpStateTexture(bgColor:uint,bgAlpha:Number,borderColor:uint,borderAlpha:Number):Texture
-(SPTexture *)getUpStateTexture:(unsigned int)bgColor numberVal:(NSNumber *)bgAlpha uintVal:(unsigned int)borderColor numberVal:(NSNumber *)borderAlpha;
//
@end
