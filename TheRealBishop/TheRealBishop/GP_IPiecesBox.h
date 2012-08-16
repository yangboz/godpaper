//
//  GP_IPiecesBox.h
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-16.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GP_IChessGasket.h"
#import "GP_IType.h"
/**
 * You can put chess pieces on/inside the box constrainted by the fixed area.
 */
@protocol GP_IPiecesBox <GP_IChessGasket,GP_IType>
{}
//
//--------------------------------------------------------------------------
//
//  Public properties
//
//-------------------------------------------------------------------------- 
//Each pieces box contains(receline) more than one chess pieces.
//function set childrenArea(value:Rectangle):void;
//function get childrenArea():Rectangle;
////
//function set chessPieces(value:Vector.<ChessPiece>):void;
//function get chessPieces():Vector.<ChessPiece>;
//
@end
