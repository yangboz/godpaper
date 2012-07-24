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
		public static var xLines:Number=4;
		public static var yLines:Number=4;
		//board scale
		public static var xScale:Number=1;
		public static var yScale:Number=1;
		//board lattic
		public static var xOffset:Number=50;
		public static var yOffset:Number=50;
		//board size
		public static function get height():Number
		{
			return (BoardConfig.yLines-1)*BoardConfig.yOffset+BoardConfig.yAdjust*2;
		}
		//
		public static function get width():Number
		{
			return (BoardConfig.xLines-1)*BoardConfig.xOffset+BoardConfig.xAdjust*2;
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
		public static var backgroundImage:Image= null;//The chess board's backgroud texture;
		//Pieces box relevant variables.
		public static var piecesBoxRequired:Boolean = false;//For partical chess board game with pieces box component view;
		public static var piecesBoxBgImage:Image=null;//The chess pieces box 's backgroud texture;
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

