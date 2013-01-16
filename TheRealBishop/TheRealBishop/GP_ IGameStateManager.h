//
//  GP_ IGameStateManager.h
//  TheRealBishop
//
//  Created by zhou Yangbo on 12-8-25.
//  Copyright (c) 2012年 GODPAPER. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 * The interface of game manager,which one deletate all kinds of game command executions.
 * @author yangboz
 * @langVersion 3.0
 * @playerVersion 9.0
 * Created Feb 14, 2011 11:54:50 AM
 */
@protocol GP__IGameStateManager <NSObject>
//--------------------------------------------------------------------------
//
//  Public properties
//
//-------------------------------------------------------------------------- 

//----------------------------------
//  get Game Phase
//----------------------------------
/**
 * The game phase is decided by how many pieces both sides have left.
 * @param gamePosition the current game position information.
 * @return the current game position's game phase.
 */
//function get phase():uint;
-(unsigned int)phase;
//function get level():int;
-(unsigned int)level;
//function set level(value:int):void;
-(void)setLevel:(int)value;
////
//function get isRunning():Boolean;
-(BOOL)isRunning;
//function set isRunning(value:Boolean):void;
-(void)isRunning:(BOOL)value;
//----------------------------------
//  game side info
//----------------------------------
//function get isBlueSide():Boolean;
-(BOOL)isBlueSide;
//function get isRedSide():Boolean;
-(BOOL)isRedSide;
//function get isGreenSide():Boolean;
-(BOOL)isGreenSide;
//--------------------------------------------------------------------------
//
//  Public methods
//
//--------------------------------------------------------------------------
//----------------------------------
//  startGame
//----------------------------------
//function start():void;
-(void)start;
//----------------------------------
//  restartGame
//----------------------------------
//function restart():void;
-(void)restart;
//----------------------------------
//  computerWin
//----------------------------------
//function computerWin():void;
-(void)computerWin;
//----------------------------------
//  humanWin
//----------------------------------
//function humanWin():void;
-(void)humanWin;
//----------------------------------
//  anotherHumanWin
//----------------------------------
//function anotherHumanWin():void;
-(void)anotherHumanWin;
//----------------------------------
//  isComputerTurnNow
//----------------------------------
//function isComputerTurnNow():void;
-(void)isComputerTurnNow;
//----------------------------------
//  isHumanTurnNow
//----------------------------------
//function isHumanTurnNow():void;
-(void)isHumanTurnNow;
//----------------------------------
//  isAnotherHumanTurnNow
//----------------------------------
//function isAnotherHumanTurnNow():void;
-(void)isAnotherHumanTurnNow;
//----------------------------------
//  getRolePlaying
//----------------------------------
//function getRolePlaying(flagMask:uint):Boolean;
-(void)getRolePlaying:(unsigned int)flagMask;
//
@end
