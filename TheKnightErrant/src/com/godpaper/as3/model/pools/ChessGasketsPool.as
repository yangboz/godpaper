package com.godpaper.as3.model.pools
{
	import com.godpaper.as3.configs.GasketConfig;
	import com.godpaper.as3.core.IChessGasket;
	import com.godpaper.as3.views.components.ChessGasket;
	
	import flash.geom.Point;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Reusing objects reduces the need to instantiate objects, which can be expensive. 
	 * It also reduces the chances of the garbage collector running, which can slow down your application. 
	 * The following code illustrates the object pooling technique:  	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jul 2, 2011 10:59:45 AM
	 * @see http://help.adobe.com/en_US/as3/mobile/WS948100b6829bd5a6-19cd3c2412513c24bce-8000.html
	 * @see http://en.wikipedia.org/wiki/Object_pool_pattern
	 */   	 
	public class ChessGasketsPool
	{		
		private static var MAX_VALUE:uint; 
		private static var GROWTH_VALUE:uint; 
		private static var counter:uint; 
		private static var pool:Vector.<ChessGasket>; 
		private static var currentSprite:ChessGasket; 
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
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
		//
		public static function initialize( maxPoolSize:uint, growthValue:uint ):void 
		{ 
			MAX_VALUE = maxPoolSize; 
			GROWTH_VALUE = growthValue; 
			counter = maxPoolSize; 
			
			var i:uint = maxPoolSize; 
			
			pool = new Vector.<ChessGasket>(MAX_VALUE); 
			while( --i > -1 ) 
				pool[i] = getChessGasket(); 
		} 
		//
		public static function get():ChessGasket 
		{ 
			if ( counter > 0 ) 
				return currentSprite = pool[--counter]; 
			
			var i:uint = GROWTH_VALUE; 
			while( --i > -1 ) 
				pool.unshift ( getChessGasket() ); 
			counter = GROWTH_VALUE; 
			return get(); 
			
		} 
		//
		public static function dispose(disposed:ChessGasket):void 
		{ 
			pool[counter++] = disposed; 
		} 

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
		private static function getChessGasket():ChessGasket
		{
			var Impl:Class = GasketConfig.implement;
			return new Impl(null,"",null);//upState:Texture=null, text:String="", downState:Texture=null
		}
	}
	
}