package com.godpaper.as3.configs
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------

	/**
	 * GasketConfig.as class.Global chess piece's gasket configuration(width,height,border,alpha,etc..),(which one) set up at application's initialization stage.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Feb 15, 2011 2:35:39 PM
	 * @history 07/02/2011 added maxPoolSize,growthValue properties;
	 */   	 
	public class GasketConfig
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private static var _width:Number=50;
		private static var _height:Number=50;
		private static var _borderVisible:Boolean=false;//You'd beter set true for the purpose of debug view.
		private static var _backgroundAlpha:Number=0.0;
		private static var _contentBackgroundAlpha:Number=0.0;
		private static var _borderAlpha:Number=1;
		//ObjectPool
		private static var _maxPoolSize:uint=100;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------

		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		//
		public static function get borderAlpha():Number
		{
			return _borderAlpha;
		}

		public static function set borderAlpha(value:Number):void
		{
			_borderAlpha = value;
		}
		//
		public static function get contentBackgroundAlpha():Number
		{
			return _contentBackgroundAlpha;
		}

		public static function set contentBackgroundAlpha(value:Number):void
		{
			_contentBackgroundAlpha = value;
		}
		//
		public static function get backgroundAlpha():Number
		{
			return _backgroundAlpha;
		}

		public static function set backgroundAlpha(value:Number):void
		{
			_backgroundAlpha = value;
		}
		//
		public static function get borderVisible():Boolean
		{
			return _borderVisible;
		}

		public static function set borderVisible(value:Boolean):void
		{
			_borderVisible = value;
		}
		//	
		public static function get height():Number
		{
			return _height;
		}

		public static function set height(value:Number):void
		{
			_height = value;
		}
		//
		public static function get width():Number
		{
			return _width;
		}

		public static function set width(value:Number):void
		{
			_width = value;
		}
		//
		public static function get growthValue():uint
		{
			return maxPoolSize>>1;
		}
		//
		public static function get maxPoolSize():uint
		{
			return _maxPoolSize;
		}
		
		public static function set maxPoolSize(value:uint):void
		{
			_maxPoolSize = value;
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

