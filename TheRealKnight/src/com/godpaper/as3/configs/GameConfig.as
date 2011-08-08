package com.godpaper.as3.configs
{
	import com.godpaper.as3.core.IChessPieceManager;
	import com.godpaper.as3.core.IGameStateManager;
	import com.godpaper.as3.impl.GameStateManagerDefault;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------

	/**
	 * GameConfig.as class. Global game configuration,(which one) set up at application's initialization stage.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jan 20, 2011 11:34:56 AM
	 */
	public class GameConfig
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//global game config.
		private static var _turnFlag:int;
		private static var _tollgates:Array;
		private static var _tollgateTips:Array;
		//
		private static var _chessPieceManager:IChessPieceManager;
		private static var _gameStateManager:IGameStateManager = new GameStateManagerDefault();
		//The game play mode(computer vs human,human vs human);
		private static var _playMode:String = HUMAN_VS_COMPUTER;
		//the interval score of each tollgate.
		private static var _scoreInterval:Number = 10;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		public static const HUMAN_VS_COMPUTER:String = "human vs computer.";
		public static const HUMAN_VS_HUMAN:String = "human vs human.";
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		//----------------------------------
		//  scoreInterval(read-write)
		//----------------------------------
		public static function get scoreInterval():Number
		{
			return _scoreInterval;
		}
		
		public static function set scoreInterval(value:Number):void
		{
			_scoreInterval = value;
		}
		//----------------------------------
		//  tollgateTips(read-write)
		//----------------------------------
		public static function get tollgateTips():Array
		{
			return _tollgateTips;
		}

		public static function set tollgateTips(value:Array):void
		{
			_tollgateTips=value;
		}

		//----------------------------------
		//  tollgates(read-write)
		//----------------------------------
		public static function get tollgates():Array
		{
			return _tollgates;
		}

		public static function set tollgates(value:Array):void
		{
			_tollgates=value;
		}

		//----------------------------------
		//  turnFlag(read-write)
		//----------------------------------
		public static function get turnFlag():int
		{
			return _turnFlag;
		}

		public static function set turnFlag(value:int):void
		{
			_turnFlag=value;
		}

		//----------------------------------
		//  gameStateManager(read-write)
		//----------------------------------
		public static function get gameStateManager():IGameStateManager
		{
			return _gameStateManager;
		}

		public static function set gameStateManager(value:IGameStateManager):void
		{
			_gameStateManager=value;
		}

		//----------------------------------
		//  chessPieceManager(read-write)
		//----------------------------------
		public static function get chessPieceManager():IChessPieceManager
		{
			return _chessPieceManager;
		}

		public static function set chessPieceManager(value:IChessPieceManager):void
		{
			_chessPieceManager=value;
		}
		//----------------------------------
		//  playMode(read-write)
		//----------------------------------
		public static function get playMode():String
		{
			return _playMode;
		}
		public static function set playMode(value:String):void
		{
			_playMode = value;
		}
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//-------------------------------------------------------------------------- 

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------


	}

}

