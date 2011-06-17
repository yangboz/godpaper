package com.godpaper.as3.configs
{

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------

	/**
	 * PieceConfig.as class.Global chess piece configuration(factory,skin,etc..),(which one) set up at application's initialization stage.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jan 30, 2011 2:18:35 PM
	 * @history 06172011 added scaleX/Y properties.
	 */
	public class PieceConfig
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private static var _factory:Class;
		private static var _usingDragProxy:Boolean;
		private static var _scaleX:Number=1.0;
		private static var _scaleY:Number=1.0;

		//----------------------------------
		//  CONSTANTS
		//----------------------------------

		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		//	
		public static function get usingDragProxy():Boolean
		{
			return _usingDragProxy;
		}

		public static function set usingDragProxy(value:Boolean):void
		{
			_usingDragProxy=value;
		}

		//
		public static function get factory():Class
		{
			return _factory;
		}

		public static function set factory(value:Class):void
		{
			_factory=value;
		}

		//
		public static function get scaleY():Number
		{
			return _scaleY;
		}

		public static function set scaleY(value:Number):void
		{
			_scaleY=value;
		}

		//
		public static function get scaleX():Number
		{
			return _scaleX;
		}

		public static function set scaleX(value:Number):void
		{
			_scaleX=value;
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
		public function PieceConfig()
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

