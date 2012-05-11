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
		public static var xLines:Number=4;
		public static var yLines:Number=4;
		//board scale
		public static var xScale:Number=1;
		public static var yScale:Number=1;
		//board lattic
		public static var xOffset:Number=50;
		public static var yOffset:Number=50;
		//board size
		public static var width:Number=300;
		public static var height:Number=400;
		//board background
//		private static var _backGround:Class;
		//board x,y position adjust
		public static var xAdjust:Number=10;
		public static var yAdjust:Number=10;
		//connex directions
		public static var hConnex:Boolean=false; //horizontally connection flag.
		public static var vConnex:Boolean=false; //vertically connection flag.
		public static var fdConnex:Boolean=false; //forward diagonally connection flag.
		public static var bdConnex:Boolean=false; //backward diagonally connection flag.
		public static var numConnex:Number;//the number of connex in each direction.
		//----------------------------------
		//  CONSTANTS
		//----------------------------------

		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		//
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

