package com.godpaper.as3.configs
{
	import com.godpaper.as3.views.plugin.IPluginButtonBar;
	import com.godpaper.as3.views.plugin.PluginButtonBar;
	
	import starling.display.Image;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------

	/**
	 * PluginConfig.as class.Global plugin(mochimedia,facebook,sort of other sns) configuration(gameID,boardID,appID,etc..),(which one) set up at application's initialization stage.
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
		public static var gameID:String;
		public static var boardID:String;
		//Plugin button bar relevant properties.
		public static var buttonBarHeight:Number=50;
		//Customize implementation define
		public static var tabbarImpl:Class = PluginButtonBar;//Default
		public static var showStats:Boolean = true;//Displays the statistics box at a certain position.
		public static var PGN_file:String = null;//PGN file path required.
		public static var piecesBoxPosition:String = PBOX_AT_BOTTOM;
		public static var piecesBoxRequired:Boolean = false;//For partical chess board game with pieces box component view;
		public static var piecesBoxBgRed:String="PBOX_RED";//The chess pieces box 's backgroud texture;
		public static var piecesBoxBgBlue:String="PBOX_BLUE";//The chess pieces box 's backgroud texture;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		public static const PBOX_AT_LEFT:String = "on the left";//Pieces box on the left.
		public static const PBOX_AT_RIGHT:String = "on the right";
		public static const PBOX_AT_TOP:String = "on the up";
		public static const PBOX_AT_BOTTOM:String = "on the bottom";
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

