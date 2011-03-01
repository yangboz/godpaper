package com.godpaper.as3.core
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------

	/**
	 * The interface of game manager,which one deletate all kinds of game command executions.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Feb 14, 2011 11:54:50 AM
	 */
	public interface IGameStateManager
	{
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
		function get phase():uint;
		//
		function get level():int;
		function set level(value:int):void;
		//
		function get isRunning():Boolean;
		function set isRunning(value:Boolean):void;
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  startGame
		//----------------------------------
		function start():void;
		//----------------------------------
		//  restartGame
		//----------------------------------
		function restart():void;
		//----------------------------------
		//  computerWin
		//----------------------------------
		function computerWin():void;
		//----------------------------------
		//  humanWin
		//----------------------------------
		function humanWin():void;
		//----------------------------------
		//  anotherHumanWin
		//----------------------------------
		function anotherHumanWin():void;
		//----------------------------------
		//  isComputerTurnNow
		//----------------------------------
		function isComputerTurnNow():void;
		//----------------------------------
		//  isHumanTurnNow
		//----------------------------------
		function isHumanTurnNow():void;
		//----------------------------------
		//  isAnotherHumanTurnNow
		//----------------------------------
		function isAnotherHumanTurnNow():void;
	}
}

