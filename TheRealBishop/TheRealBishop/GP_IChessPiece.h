//
//  GP_IChessPiece.h
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-16.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GP_IPosition.h"
#import "GP_IType.h"
#import "GP_IVisualElement.h"
#import "GP_IChessVO.h"
/**
 * The interface of ChessPiece include all of interface relatived to it.
 */
@protocol GP_IChessPiece <GP_IVisualElement,GP_IPosition,GP_IType>
//
//function set agent(value:ChessAgent):void;
-(void)setAgent:(ChessAgent *)value;
//function get agent():ChessAgent;
-(ChessAgent *)agent;
//
//function set chessVO(value:IChessVO):void;
-(void)setChessVO:(IChessVO *)value;
//function get chessVO():IChessVO;
-(IChessVO *)chessVO;
//
//function set omenVO(value:OmenVO):void;
-(void)setOmenVO:(OmenVO *)value;
//function get omenVO():OmenVO;
-(OmenVO *)omenVO;
//
@end
