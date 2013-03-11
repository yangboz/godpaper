package com.godpaper.as3.configs
{
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.core.IChessBoard;
	import com.godpaper.as3.views.components.ChessBoard;
	
	import starling.display.Image;

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
		private static var _yLines:Number=4;
		public static function get yLines():Number
		{
			return (BoardConfig.type!=DefaultConstants.CHESS_BOARD_TYPE_CHECKERING)?_yLines:(_yLines-1);
		}
		public static function set yLines(value:Number):void
		{
			_yLines = value;
		}
		//
		private static var _xLines:Number=4;
		public static function get xLines():Number
		{
			return (BoardConfig.type!=DefaultConstants.CHESS_BOARD_TYPE_CHECKERING)?_xLines:(_xLines-1);
		}
		public static function set xLines(value:Number):void
		{
			_xLines = value;
		}
		//board scale
		public static var xScale:Number=1;
		public static var yScale:Number=1;
		//board lattic
		public static var xOffset:Number=50;
		public static var yOffset:Number=50;
		//board size
		public static function get height():Number
		{
			return _yLines*BoardConfig.yOffset+BoardConfig.yAdjust*2;
		}
		//
		public static function get width():Number
		{
			return _xLines*BoardConfig.xOffset+BoardConfig.xAdjust*2;
		}
		//board background
//		private static var _backGround:Class;
		//board x,y position adjust
		public static var xAdjust:Number=50;
		public static var yAdjust:Number=50;
		//connex directions
		public static var hConnex:Boolean=false; //horizontally connection flag.
		public static var vConnex:Boolean=false; //vertically connection flag.
		public static var fdConnex:Boolean=false; //forward diagonally connection flag.
		public static var bdConnex:Boolean=false; //backward diagonally connection flag.
		public static var numConnex:Number;//the number of connex in each direction.
		//background image texture.
//		var chessBoardBackground:Image = new Image(AssetEmbedsDefault.getTexture(DefaultConstants.IMG_BACK_GROUND));
//		public static var backgroundImage:Image= null;//The chess board's backgroud texture;
		//
		public static var backgroundImageRequired:Boolean = false;
		public static function get backgroundImage():Image
		{
			if(!backgroundImageRequired) return null;
			return new Image(AssetEmbedsDefault.getTexture_cp_bg(DefaultConstants.IMG_BACK_GROUND));
		}
		//Pieces box relevant variables.
		public static var type:String = DefaultConstants.CHESS_BOARD_TYPE_INTERSECTION;//TODO:type customize.
		//----------------------------------
		//  CONSTANTS
		//----------------------------------

		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
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

