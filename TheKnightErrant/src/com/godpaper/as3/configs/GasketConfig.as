package com.godpaper.as3.configs
{
	import com.godpaper.as3.views.components.ChessGasket;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------

	/**
	 * GasketConfig.as class.Global chess piece's gasket configuration(width,height,border,alpha,etc..),(which one) set up at application's initialization stage.
	 * @see http://en.wikipedia.org/wiki/Object_pool_pattern
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Feb 15, 2011 2:35:39 PM
	 * </time> 07/02/2011 added maxPoolSize,growthValue properties;
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
		public static var borderVisible:Boolean = false;//You'd better set true for the purpose of debug view.
		public static var backgroundAlpha:Number=0.1;
		public static var contentBackgroundAlpha:Number=0.0;
		public static var borderAlpha:Number=1;
		//ObjectPool
		//toolTips
		public static var maxPoolSize:uint=100;//Notice:Object pools full of objects with dangerously stale state are sometimes called object cesspools and regarded as an anti-pattern.
		public static var tipsVisible:Boolean = false;
		//Customize implement
		public static var implement:Class = ChessGasket;//Default,customize shoule override the getUpTexture().
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

