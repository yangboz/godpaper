package com.godpaper.as3.configs
{
	import com.godpaper.as3.core.IPiecesBox;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.starling.views.components.PiecesBox;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------

	/**
	 * PieceConfig.as class.Global chess piece configuration(factory,skin,etc..),(which one) set up at application's initialization stage.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jan 30, 2011 2:18:35 PM
	 * @history 06/17/2011 added scaleX/Y properties.
	 * @history 07/02/2011 added maxPoolSize(BLUE/RED),growthValue properties;
	 */
	public class PieceConfig
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private static var _factory:Class;
		private static var _usingDragProxy:Boolean;
		private static var _scaleX:Number=1.0;
		private static var _scaleY:Number=1.0;
		//ObjectPool
		private static var _maxPoolSizeBlue:uint=16;
		private static var _maxPoolSizeRed:uint=16;
		//PiecesBox data
		private static var _bluePieces:Vector.<ConductVO> = new Vector.<ConductVO>;
		private static var _redPieces:Vector.<ConductVO> = new Vector.<ConductVO>;
		private static var _bluePiecesBox:IPiecesBox;
		private static var _redPiecesBox:IPiecesBox;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------

		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		//	
		public static function get redPiecesBox():IPiecesBox
		{
			return _redPiecesBox;
		}

		public static function set redPiecesBox(value:IPiecesBox):void
		{
			_redPiecesBox = value;
		}
		//
		public static function get bluePiecesBox():IPiecesBox
		{
			return _bluePiecesBox;
		}

		public static function set bluePiecesBox(value:IPiecesBox):void
		{
			_bluePiecesBox = value;
		}
		//
		public static function get redPieces():Vector.<ConductVO>
		{
			return _redPieces;
		}
		//
		public static function get bluePieces():Vector.<ConductVO>
		{
			return _bluePieces;
		}
		//
		public static function get usingDragProxy():Boolean
		{
			return _usingDragProxy;
		}

		public static function set usingDragProxy(value:Boolean):void
		{
			_usingDragProxy=value;
		}

		//
		public static function get factory():Class
		{
			return _factory;
		}

		public static function set factory(value:Class):void
		{
			_factory=value;
		}

		//
		public static function get scaleY():Number
		{
			return _scaleY;
		}

		public static function set scaleY(value:Number):void
		{
			_scaleY=value;
		}

		//
		public static function get scaleX():Number
		{
			return _scaleX;
		}

		public static function set scaleX(value:Number):void
		{
			_scaleX=value;
		}
		//
		public static function get growthValue():uint
		{
			return _maxPoolSizeBlue>>1;
		}
		//
		public static function get maxPoolSizeBlue():uint
		{
			return _maxPoolSizeBlue;
		}
		
		public static function set maxPoolSizeBlue(value:uint):void
		{
			_maxPoolSizeBlue = value;
			//for loop initialize the blue pieces
			for(var i:int=0;i<value;i++)
			{
				_bluePieces.push(new ConductVO());
			}
		}
		//
		public static function get maxPoolSizeRed():uint
		{
			return _maxPoolSizeRed;
		}
		
		public static function set maxPoolSizeRed(value:uint):void
		{
			_maxPoolSizeRed = value;
			//for loop initialize the blue pieces
			for(var i:int=0;i<value;i++)
			{
				_redPieces.push(new ConductVO());
			}
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
		public function PieceConfig()
		{
		}
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

