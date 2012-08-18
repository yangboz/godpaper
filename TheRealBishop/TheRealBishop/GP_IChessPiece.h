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
{
    @private
        ChessAgent *agent;
        IChessVO *chessVO;
        OmenVO *omenVO;
}
//
//function set agent(value:ChessAgent):void;
//function get agent():ChessAgent;
@property(nonatomic,retain) ChessAgent *agent;
//
//function set chessVO(value:IChessVO):void;
//function get chessVO():IChessVO;
@property(nonatomic,retain) IChessVO *chessVO;
//
//function set omenVO(value:OmenVO):void;
//function get omenVO():OmenVO;
@property(nonatomic,retain) OmenVO *omenVO;
//
@end
