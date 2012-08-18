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
{
    @private
        BitBoard *occupies,*moves,*captures,*defends;
        
}
//for initialization.
//function initialization(rowIndex:int, colIndex:int,flag:int=0,identifier:String=""):void;
-(void)initialization:(int)rowIndex intValue:(int)colIndex intValue:(int)flag strValue:(NSString *)identifier; 
////spaces occupied by red/blue pieces:
//function set occupies(value:BitBoard):void;
//function get occupies():BitBoard;
@property(nonatomic,retain) BitBoard *occupies;
////legal moves for these chess types.
//function set moves(value:BitBoard):void;
//function get moves():BitBoard;
@property(nonatomic,retain) BitBoard *moves;
////red/blue piece positions to compute captures.
//function set captures(value:BitBoard):void;
//function get captures():BitBoard;
@property(nonatomic,retain) BitBoard *captures;
////legal moves for these chess types that can keep "marshal" safty.
//function set defends(value:BitBoard):void;
//function get defends():BitBoard;
@property(nonatomic,retain) BitBoard *defends;
@end
