//
//  GP_IChessBoard.h
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-16.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GP_IType.h"

/**
 * A chess board is defined by a number of rows and columns, which may vary for different application levels. 
 * Chess board types(Bitboard,NumberBoard,GraphBoard,ArrayBoard...) 	
 */
@protocol GP_IChessBoard <GP_IType>
{

}
//
//--------------------------------------------------------------------------
//
//  Public properties
//
//-------------------------------------------------------------------------- 
//----------------------------------
//  background(CrossLines or Embbed image textures)
//----------------------------------
//		function set background(value:Image):void;
//		function get background():Image;
////----------------------------------
////  yAdjust(for pixel adjustment at y axis)
////----------------------------------
//function get yAdjust():Number;
//function set yAdjust(value:Number):void;
////----------------------------------
////  xAdjust(for pixel adjustment at x axis)
////----------------------------------
//function get xAdjust():Number;
//function set xAdjust(value:Number):void;
////----------------------------------
////  height(the height of ChessBoard)
////----------------------------------
//function get height():Number;
//function set height(value:Number):void;
////----------------------------------
////  width(the width of ChessBoard)
////----------------------------------
//function get width():Number;
//function set width(value:Number):void;
////----------------------------------
////  yOffset(the lattice of ChessBoard at y axis)
////----------------------------------
//function get yOffset():Number;
//function set yOffset(value:Number):void;
////----------------------------------
////  xOffset(the lattice of ChessBoard at x axis)
////----------------------------------
//function get xOffset():Number;
//function set xOffset(value:Number):void;
////----------------------------------
////  yScale(the scale rate of ChessBoard at y axis)
////----------------------------------
//function get yScale():Number;
//function set yScale(value:Number):void;
////----------------------------------
////  xScale(the scale rate of ChessBoard at x axis)
////----------------------------------
//function get xScale():Number;
//function set xScale(value:Number):void;
////----------------------------------
////  yLines(the number of lines displayed on ChessBoard at y axis)
////----------------------------------
//function get yLines():Number;
//function set yLines(value:Number):void;
////----------------------------------
////  xLines(the number of lines displayed on ChessBoard at x axis)
////----------------------------------
//function get xLines():Number;
//function set xLines(value:Number):void;
//
@end
