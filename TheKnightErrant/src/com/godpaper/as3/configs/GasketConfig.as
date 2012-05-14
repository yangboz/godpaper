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
		public static var width:Number=48;
		public static var height:Number=48;
		public static var borderVisible:Boolean = false;//You'd beter set true for the purpose of debug view.
		public static var backgroundAlpha:Number=0.1;
		public static var contentBackgroundAlpha:Number=0.0;
		public static var borderAlpha:Number=1;
		//ObjectPool
		public static var maxPoolSize:uint=100;
		//toolTips
		public static var tipsVisible:Boolean = false;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------

		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		//
		public static function get growthValue():uint
		{
			return maxPoolSize>>1;
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

