//
//  GP_IChessVO.h
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-16.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 * The interface of chess pieces,about occupy,moves,captures.
 * @see http://chess.dubmun.com/bitboard.html
 */
@protocol GP_IChessVO <NSObject>
{}
//for initialization.
//function initialization(rowIndex:int, colIndex:int,flag:int=0,identifier:String=""):void;
////spaces occupied by red/blue pieces:
//function set occupies(value:BitBoard):void;
//function get occupies():BitBoard;
////legal moves for these chess types.
//function set moves(value:BitBoard):void;
//function get moves():BitBoard;
////red/blue piece positions to compute captures.
//function set captures(value:BitBoard):void;
//function get captures():BitBoard;
////legal moves for these chess types that can keep "marshal" safty.
//function set defends(value:BitBoard):void;
//function get defends():BitBoard;
@end
