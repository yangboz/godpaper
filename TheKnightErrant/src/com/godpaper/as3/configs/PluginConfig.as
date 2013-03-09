package com.godpaper.as3.configs
{
	import com.godpaper.as3.views.plugin.IPluginButtonBar;
	import com.godpaper.as3.views.plugin.PluginButtonBar;

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

