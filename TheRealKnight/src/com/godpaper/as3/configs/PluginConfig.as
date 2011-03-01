package com.godpaper.as3.configs
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------

	/**
	 * PluginConfig.as class.Global plugin(mochimedia,facebook,sns) configuration(gameID,boardID,etc..),(which one) set up at application's initialization stage.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jan 30, 2011 3:38:44 PM
	 */   	 
	public class PluginConfig
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private static var _mochiGameID:String;
		private static var _mochiBoardID:String;
		private static var _mochiIcons:Object;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------

		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		//
		public static function get mochiBoardID():String
		{
			return _mochiBoardID;
		}

		public static function set mochiBoardID(value:String):void
		{
			_mochiBoardID = value;
		}
		//
		public static function get mochiGameID():String
		{
			return _mochiGameID;
		}

		public static function set mochiGameID(value:String):void
		{
			_mochiGameID = value;
		}
		//for embeded assets.
		public static function get mochiIcons():Object
		{
			return _mochiIcons;
		}

		public static function set mochiIcons(value:Object):void
		{
			_mochiIcons = value;
		}
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//-------------------------------------------------------------------------- 

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function PluginConfig()
		{
		}     	
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

