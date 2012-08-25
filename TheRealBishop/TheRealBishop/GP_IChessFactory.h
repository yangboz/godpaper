//
//  GP_IChessFactory.h
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-25.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GP_IChessPiece.h"
#import "GP_IChessGasket.h"
#import "GP_IChessVO.h"
#Import "GP_IChessBoard.h"
/**
 * The interface of ChessFactory.as;
 * @author yangboz
 * @langVersion 3.0
 * @playerVersion 9.0
 * Created Jan 27, 2011 4:34:33 PM
 * @history 04/27/2012 createChessBoard func added.
 */
@protocol GP_IChessFactory <NSObject>
//
//function createChessPiece(position:Point, flag:int=0):IChessPiece;
-(GP_IChessPiece *)createChessPiece:(CGPoint *)position intVal:(int)flag;
//function createChessGasket(position:Point):IChessGasket;
-(IChessGasket *)createChessGasket:(CGPoint *)position;
//function generateChessVO(conductVO:ConductVO):IChessVO;
-(IChessVO *)generateChessVO:(ConductVO *)conductVO;
//function generateOmenVO(conductVO:ConductVO):OmenVO;
-(OmenVO *)generateOmenVO:(ConductVO *)conductVO
//function createChessBoard(type:String):IChessBoard;
-(IChessBoard *)createChessBoard:(NSString *)type;
//
@end
