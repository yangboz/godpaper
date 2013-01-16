//
//  GP_ChessBoard.m
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-29.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import "GP_ChessBoard.h"
#import "GP_BoardConfig.h"
#import "SPQuad.h"
#import "SHLine.h"
#import "GP_DefaultConstants.h"
/**
 * A chess board is defined by a number of rows and columns, which may vary for different application levels.   	
 * @author yangboz
 * @langVersion 3.0
 * @playerVersion 11.2+
 * @airVersion 3.2+
 * Created Apr 18, 2012 10:01:04 AM
 * @see http://wiki.starling-framework.org/manual/dynamic_textures
 */ 
@implementation GP_ChessBoard
@synthesize xAdjust,xLines,xOffset,xScale;
@synthesize yAdjust,yLines,yOffset,yScale;
//----------------------------------
//  background(CrossLines or Embbed image textures)
//----------------------------------
//private var _background:Image = null;

//public function get background():Image
-(SPImage *)background;
{
//    return _background;
    return background;
}

//public function set background(value:Image):void
-(void)setBackground:(SPImage *)background
{
//    if(value!=null)
//    {
//        if(this.contains(_background))
//        {
//            removeChild(_background);//Remove the existed background at first.
//        }
//        //set anew value
//        _background=value;
//        //Puts on background image.
//        //			var bg:Image = new Image(DefaultEmbededAssets.getTexture(DefaultConstants.IMG_BACK_GROUND));
//        //			addChild(bg);
//        //Display anew backgournd
//        addChild(_background);
//    }
}
//--------------------------------------------------------------------------
//
//  Constructor
//
//--------------------------------------------------------------------------
//public function ChessBoard(background:Texture=null)
-(void)ChessBoard:(SPTexture *)background
{
    //Binding to the global configured variables
//    var typeOfCheckering:Boolean = (BoardConfig.type==DefaultConstants.CHESS_BOARD_TYPE_CHECKERING);
//    BOOL typeOfCheckering = [[GP_BoardConfig type] isEqualToString:CHESS_BOARD_TYPE_CHECKERING];
//    this.xLines = typeOfCheckering?(BoardConfig.xLines+1):BoardConfig.xLines;//Chess board type adjust
//    self.xLines = typeOfCheckering?([GP_BoardConfig xLines]+1):[GP_BoardConfig xLines];
//    this.yLines = typeOfCheckering?(BoardConfig.yLines+1):BoardConfig.yLines;//Chess board type adjust
//    this.xLines = BoardConfig.xLines;
//    self.xLines = [GP_BoardConfig xLines];
    self.xLines = 4;
//    this.yLines = BoardConfig.yLines;
//    self.yLines = [GP_BoardConfig yLines];
    self.yLines = 4;
    //    this.xScale = BoardConfig.xScale;
//    this.yScale = BoardConfig.yScale;
//    this.xOffset = BoardConfig.xOffset;
//    this.yOffset = BoardConfig.yOffset;
//    //Does't work,the actual width and height changed every enterframe after the board added to stage.
//    //			this.width = BoardConfig.width;
//    //			this.height = BoardConfig.height;
//    this.xAdjust = BoardConfig.xAdjust;
//    this.yAdjust = BoardConfig.yAdjust;
//    //
//    super(background);
//    //
//    this.touchable = false;
    self.touchable = NO;
}
//--------------------------------------------------------------------------
//
//  Public methods
//
//--------------------------------------------------------------------------
//public function toString():String
-(NSString *)toString
{
    //return ObjectUtil.toString(this);
    return [super description];//TODO:customize description;
}
#pragma mark GP_IType
-(NSString *)type
{
    return _type;
}
-(void)setType:(NSString *)value
{
    _type = value;
}
//
-(SPRenderTexture *)getUpStateTexture:(unsigned int)bgColor numberVal:(float)bgAlpha uintVal:(unsigned int)borderColor numberVal:(float)borderAlpha
{
    return [super getUpStateTexture:bgColor numberVal:bgAlpha uintVal:borderColor numberVal:borderAlpha];
    // this is where the code of your game will start. 
    // in this sample, we add just a simple quad to see 
    // if it works.
    SPQuad *quad = [SPQuad quadWithWidth:self.width height:self.height];
    quad.color = 0x0000ff;
    quad.x = 0;
    quad.y = 0;
    [self addChild:quad];

    //SHLine testing.
    //initialize a line with a length of 100 pixels and thickness of 5 pixels
    SHLine *line = [SHLine lineWithLength:100 andThickness:5];
    
    //set the start color to red
    line.startColor = 0xff0000;
    
    //set the end color to blue
    line.endColor = 0x0000ff;
    
    //set the start opacity to 75%
    line.startAlpha = 0.75f;
    
    //set the end opacity to 25%
    line.endAlpha = 0.25f;
    
    //set the end destination to the bottom right corner of the screen
    line.x2 = 320;
    line.y2 = 480;
    
    //initialize another line with the coords (x, y, width, height)
    SHLine *line2 = [SHLine lineWithCoords:0:480:320:-480];
    
    //set the line thickness to 5 pixels
    line2.thickness = 5;
    
    //add the line to the stage
    [self addChild:line];
    //
    SPRenderTexture *texture = [SPRenderTexture textureWithWidth:self.width height:self.height fillColor:0xff0000];
    return texture;
}
@end
