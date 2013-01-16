//
//  GP_ChessBoard.h
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-29.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import "GP_VisualElement.h"
#import "GP_IChessBoard.h"
/**
 * A chess board is defined by a number of rows and columns, which may vary for different application levels.   	
 * @author yangboz
 * @langVersion 3.0
 * @playerVersion 11.2+
 * @airVersion 3.2+
 * Created Apr 18, 2012 10:01:04 AM
 * @see http://wiki.starling-framework.org/manual/dynamic_textures
 */  
@interface GP_ChessBoard : GP_VisualElement <GP_IChessBoard>
{
    //
    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------
    //global board config.
//    private var _xLines:Number;
//    private var _yLines:Number;
//    //board scale
//    private var _xScale:Number;
//    private var _yScale:Number;
//    //board lattic
//    private var _xOffset:Number;
//    private var _yOffset:Number;
    //board size
    //		private var _width:Number;//Native
    //		private var _height:Number;//Native
    //board background
    //		private static var _backGround:Class;
    //board x,y position adjust
//    private var _xAdjust:Number;
//    private var _yAdjust:Number;
    //----------------------------------
    //  CONSTANTS
    //----------------------------------
    //
    //private static const LOG:ILogger = LogUtil.getLogger(ChessBoard);
    @private
        SPImage *background;
//        uint *yAdjust,*yLines,*yOffset,*yScale;
//        uint *xAdjust,*xLines,*xOffset,*xScale;
        NSString *_type;

}
//--------------------------------------------------------------------------
//
//  Constructor
//
//--------------------------------------------------------------------------
//public function ChessBoard(background:Texture=null)
-(void)ChessBoard:(SPTexture *)background;
//properties


@end
