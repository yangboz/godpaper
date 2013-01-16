//
//  GP_ IChessPieceManager.h
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-25.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 * The interface of chess piece manager,which one delegate all kinds of chess piece command execution.
 * @author yangboz
 * @langVersion 3.0
 * @playerVersion 9.0
 * Created Feb 14, 2011 11:42:29 AM
 * @history 05/11/2011 split the indicateGaskets to indicateGasketsMove and indicateGasketsCapture functions;
 */
@protocol GP__IChessPieceManager <NSObject>
//
//----------------------------------
//  memento
//----------------------------------
/**
 * @return ChessPiecesMemento.
 */
//function get memento():ChessPiecesMemento;
-(ChessPiecesMemento *)memento;
/**
 * Using memento design pattern to implment make/unmake functions.
 * @param value
 */
//function set memento(value:ChessPiecesMemento):void
-(void)setMemento:(ChessPiecesMemento *)value;
//----------------------------------
//  previousMementos
//----------------------------------
/**
 * @return chess pieces' move history.
 */
//function get previousMementos():Array;
-(NSMutableArray *)previousMementos;
//----------------------------------
//  eatOffs
//----------------------------------
/**
 * @return the eaten chess pieces.
 */
//function get eatOffs():Vector.<ChessPiece>;
-(NSMutableArray *)eatOffs;
/**
 * @param value
 */
//function set eatOffs(value:Vector.<ChessPiece>):void;
-(void)setEatOffs:(NSMutableArray *)value;
//----------------------------------
//  isChecking
//----------------------------------
/**
 * @param value the checking status.
 */
//function set isChecking(value:Boolean):void;
-(void)isChecking:(BOOL)value;
/**
 * @return the checking status.
 */
//function get isChecking():Boolean;
-(BOOL)isChecking;
//--------------------------------------------------------------------------
//
//  Protected properties
//
//-------------------------------------------------------------------------- 
//
/**
 * @param conductVO the conduct value object of moving chess piece.
 * @return current chess piece's move validation result.
 */
//function doMoveValidation(conductVO:ConductVO):Boolean;
-(BOOL)doMoveValidation:(ConductVO *)conductVO;
/**
 * <b>Make Move</b> is a function inside a chess program to update the internal chess position
 * and its Board representation as well as associated </br>
 * or dependent state variables and data by a move made on the internal board,
 * such as zobrist keys to index the transposition table. </br>
 * That usually happens inside the Search algorithm, </br>
 * where the move acts like an edge connecting two nodes of a search tree,
 * a parent and a child node. </br>
 * Dependent on the design of the data structures
 * and the used search algorithms there are different approaches
 * with respect to randomly accessing aspects of nodes
 * and restoring the position while unmaking the move.
 *
 * @see http://chessprogramming.wikispaces.com/Make+Move
 * @param conductVO the conduct value object of moving chess piece.
 *
 */
//function makeMove(conductVO:ConductVO):void;
-(void)makeMove:(ConductVO *)conductVO;
/**
 *
 * <b>Unmake Move</b> is a function inside a chess program to update the internal chess position
 * and its Board representation as well as associated or dependent state variables
 * and data by a move unmade on the internal board. </br>
 * In unmake move, reversible aspects of a position can be incrementally updated by the inverse
 * or own inverse operation of Make Move. </br>
 * Irreversible aspects of a position, such as ep state,
 * castling rights and the halfmove clock are either restored from a stack (LIFO), </br>
 * or simply kept in arrays indexed by current search or game ply. </br>
 * Alternatively, one may capacitate the move with all the necessary information
 * to recover those irreversible aspects of a position as well.
 *
 * @see http://chessprogramming.wikispaces.com/Unmake+Move
 *
 * @param conductVO the conduct value object of moving chess piece.
 *
 */
//function unmakeMove(conductVO:ConductVO):void;
-(void)unmakeMove:(ConductVO *)conductVO;
//make move data and piece entity change behavior.
/**
 * @param conductVO
 */
//function applyMove(conductVO:ConductVO):void;
-(void)applyMove:(ConductVO *)conductVO;
//pluge to death.	
/**
 * @return none move status code.
 */
//function noneMove():int;
-(int)noneMove;
/**
 * @param gamePosition
 * @return will none move status flag.
 */
//function willNoneMove(gamePosition:PositionVO):Boolean;
-(BOOL)willNoneMove:(PositionVO *)gamePosition;
//
//function calculatePieceIndex(chessPiece:ChessPiece):int;
-(int)calculatePieceIndex:(ChessPiece *)chessPiece;
//
/**
 * @see Main.application1_creationCompleteHandler.createGasket().
 * @param legalMoves current chess piece's legal moves.
 *
 */
//		function indicateGaskets(legalMoves:BitBoard):void;
//function indicateGasketsMove(legalMoves:BitBoard):void;
-(void)indicateGasketsMove:(BitBoard *)legalMoves;
//function indicateGasketsCapture(legalCaptures:BitBoard):void;
-(void)indicateGasketsCapture:(BitBoard *)legalCaptures;
/**
 *
 * @param pieces execute check mate's chess pieces.
 * @param marshal blues'/reds' marshal bitboard.
 * @return the result of check pattern,if neccessary.
 *
 */
//function indicateCheck(pieces:Vector.<ChessPiece>, marshal:BitBoard):Boolean;	
-(BOOL)indicateCheck:(NSMutableArray *)pieces bitboard:(BitBoard *)marshal;
//
@end
