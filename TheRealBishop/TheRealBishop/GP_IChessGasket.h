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
#import "GP_IChessPiece.h"
#import "SPImage.h"
/**
 * The interface of ChessGasket.Abstarct the chess gasket foundation and properties.
 */
@protocol GP_IChessGasket <GP_IVisualElement,GP_IPosition,GP_IDragdropable>
{
    @private
        IChessPiece *chessPiece;
        BOOL tipsVisible,borderVisible;
        NSNumber *borderAlpha,*contentBackgroundAlpha,
    *backgroundAlpha;
        SPImage *background;
        ConductVO *conductVO;
}
//
/--------------------------------------------------------------------------
//
//  Public properties
//--------------------------------------------------------------------------
//Each chess gasket contains only one chess piece.
//function get chessPiece():IChessPiece;
//function set chessPiece(value:IChessPiece):void;
@property(nonatomic,retain) IChessPiece *chessPiece;
////
//function get conductVO():ConductVO;
@property(readonly,retain)ConductVO *conductVO;
////global configure variables;
//function get tipsVisible():Boolean
//function set tipsVisible(value:Boolean):void;
@property(nonatomic,retain) BOOL tipsVisible;
////
//function get borderAlpha():Number;
//function set borderAlpha(value:Number):void;
@property(nonatomic,retain) NSNumber *borderAlpha;
////
//function get contentBackgroundAlpha():Number;
//function set contentBackgroundAlpha(value:Number):void;
@property(nonatomic,retain) NSNumber *contentBackgroundAlpha;
////
//function get backgroundAlpha():Number;
//function set backgroundAlpha(value:Number):void;
@property(nonatomic,retain) NSNumber *backgroundAlpha;
////
//function get borderVisible():Boolean;
//function set borderVisible(value:Boolean):void;
@property(nonatomic,retain) BOOL borderVisible;
////
//function set background(value:Image):void;
//function get background():Image;
@property(nonatomic,retain) SPImage *background;
//
@end
