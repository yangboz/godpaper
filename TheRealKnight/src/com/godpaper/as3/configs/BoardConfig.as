package com.godpaper.as3.configs
{

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------

	/**
	 * BoardConfig.as class.Global board configuration,(which one) set up at application's initialization stage.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jan 19, 2011 2:20:20 PM
	 * @history 2011-07-18,added connex directions flag.
	 */
	public class BoardConfig
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//global board config.
		private static var _xLines:Number;
		private static var _yLines:Number;
		//board scale
		private static var _xScale:Number=1;
		private static var _yScale:Number=1;
		//board lattic
		private static var _xOffset:Number;
		private static var _yOffset:Number;
		//board size
		private static var _width:Number;
		private static var _height:Number;
		//board background
//		private static var _backGround:Class;
		//board x,y position adjust
		private static var _xAdjust:Number=0;
		private static var _yAdjust:Number=0;
		//connex directions
		private static var _hConnex:Boolean=false; //horizontally connection flag.
		private static var _vConnex:Boolean=false; //vertically connection flag.
		private static var _fdConnex:Boolean=false; //forward diagonally connection flag.
		private static var _bdConnex:Boolean=false; //backward diagonally connection flag.
		private static var _numConnex:Number;//the number of connex in each direction.
		//----------------------------------
		//  CONSTANTS
		//----------------------------------

		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		//
		public static function get yAdjust():Number
		{
			return _yAdjust;
		}

		/**
		 * @param value the user defined value(in pixel) for y-axis based position ajustment.
		 */
		public static function set yAdjust(value:Number):void
		{
			_yAdjust=value;
		}

		//
		public static function get xAdjust():Number
		{
			return _xAdjust;
		}

		/**
		 * @param value the user defined value(in pixel) for x-axis based position ajustment.
		 */
		public static function set xAdjust(value:Number):void
		{
			_xAdjust=value;
		}

		public static function get height():Number
		{
			return _height;
		}

		public static function set height(value:Number):void
		{
			_height=value;
		}

		//
		public static function get width():Number
		{
			return _width;
		}

		public static function set width(value:Number):void
		{
			_width=value;
		}

		//
		public static function get yOffset():Number
		{
			return _yOffset;
		}

		public static function set yOffset(value:Number):void
		{
			_yOffset=value;
		}

		//
		public static function get xOffset():Number
		{
			return _xOffset;
		}

		public static function set xOffset(value:Number):void
		{
			_xOffset=value;
		}

		//
		public static function get yLines():Number
		{
			return _yLines;
		}

		public static function set yLines(value:Number):void
		{
			_yLines=value;
		}

		//
		public static function get xLines():Number
		{
			return _xLines;
		}

		public static function set xLines(value:Number):void
		{
			_xLines=value;
		}

		//
		public static function get yScale():Number
		{
			return _yScale;
		}

		public static function set yScale(value:Number):void
		{
			_yScale=value;
		}

		//
		public static function get xScale():Number
		{
			return _xScale;
		}

		public static function set xScale(value:Number):void
		{
			_xScale=value;
		}

		/**
		 * return backward diagonally connection flag value.
		 */		
		public static function get bdConnex():Boolean
		{
			return _bdConnex;
		}

		public static function set bdConnex(value:Boolean):void
		{
			_bdConnex=value;
		}

		/**
		 * return forward diagonally connection flag value.
		 */
		public static function get fdConnex():Boolean
		{
			return _fdConnex;
		}

		public static function set fdConnex(value:Boolean):void
		{
			_fdConnex=value;
		}

		/**
		 * return vertically connection flag value.
		 */
		public static function get vConnex():Boolean
		{
			return _vConnex;
		}

		public static function set vConnex(value:Boolean):void
		{
			_vConnex=value;
		}

		/**
		 * return horizontally connection flag value.
		 */
		public static function get hConnex():Boolean
		{
			return _hConnex;
		}

		public static function set hConnex(value:Boolean):void
		{
			_hConnex=value;
		}
		/**
		 * return the number of connex in each direction.
		 */		
		public static function get numConnex():Number
		{
			return _numConnex;
		}
		
		public static function set numConnex(value:Number):void
		{
			_numConnex = value;
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

