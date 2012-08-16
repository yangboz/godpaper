//
//  GP_IChessGasket.h
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-16.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GP_IVisualElement.h"
#import "GP_IPosition.h"
#import "GP_IDragdropable.h"
/**
 * The interface of ChessGasket.Abstarct the chess gasket foundation and properties.
 */
@protocol GP_IChessGasket <GP_IVisualElement,GP_IPosition,GP_IDragdropable>
{}
//
/--------------------------------------------------------------------------
//
//  Public properties
//--------------------------------------------------------------------------
//Each chess gasket contains only one chess piece.
//function get chessPiece():IChessPiece;
//function set chessPiece(value:IChessPiece):void;
////
//function get conductVO():ConductVO;
////global configure variables;
//function get tipsVisible():Boolean
//function set tipsVisible(value:Boolean):void;
////
//function get borderAlpha():Number;
//function set borderAlpha(value:Number):void;
////
//function get contentBackgroundAlpha():Number;
//function set contentBackgroundAlpha(value:Number):void;
////
//function get backgroundAlpha():Number;
//function set backgroundAlpha(value:Number):void;
////
//function get borderVisible():Boolean;
//function set borderVisible(value:Boolean):void;
////
//function set background(value:Image):void;
//function get background():Image;
//
@end
