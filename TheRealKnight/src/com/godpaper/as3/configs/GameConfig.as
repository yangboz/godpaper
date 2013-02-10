package com.godpaper.as3.configs
{
	import com.godpaper.as3.consts.DefaultTollgatesConstant;
	import com.godpaper.as3.core.IChessPieceManager;
	import com.godpaper.as3.core.IGameStateManager;
	import com.godpaper.as3.business.managers.GameStateManagerDefault;

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
		private static var _tollgates:Vector.<DefaultTollgatesConstant> = new Vector.<DefaultTollgatesConstant>();
		//
		private static var _chessPieceManager:IChessPieceManager;
		private static var _gameStateManager:IGameStateManager = new GameStateManagerDefault();
		//The game play mode(computer vs human,human vs human);
		private static var _playMode:String = HUMAN_VS_COMPUTER;
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
		//  tollgates(read-only)
		//----------------------------------
		public static function get tollgates():Vector.<DefaultTollgatesConstant>
		{
			//push the default tollgates.
			_tollgates.push(
				DefaultTollgatesConstant.SuicideDiscord,
				DefaultTollgatesConstant.HorrorGib,
				DefaultTollgatesConstant.UnnaturalBase,
				DefaultTollgatesConstant.OctagonGibs,
				DefaultTollgatesConstant.AbandonedDream
			);
			//
			return _tollgates;
		}
		
//		public static function set tollgates(value:Vector.<DefaultTollgatesConstant>):void
//		{
//			_tollgates = value;
//		}
		//----------------------------------
		//  turnFlag(read-write)
		//----------------------------------
		public static function get turnFlag():int
		{
			return _turnFlag;
		}
		/**
		 * @param value of who is first turn-now.
		 */		
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
		//  playMode(read-only)
		//----------------------------------
		/**
		 * The human vs human feature under construction. 
		 */		
		public static function get playMode():String
		{
			return _playMode;
		}
//		public static function set playMode(value:String):void
//		{
//			_playMode = value;
//		}
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

