package com.godpaper.as3.plugins.mochi
{
	import com.godpaper.as3.plugins.IPlugData;
	
	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	
	import mochi.as3.MochiDigits;
	
	import mx.utils.ObjectUtil;


	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	/**
	 * MochiModel.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Dec 23, 2010 1:06:55 PM
	 */
	public class MochiModel implements IPlugData
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//
		public var score:MochiDigits=new MochiDigits(); //the player's score to submit (integer, or time in milliseconds)
		public var name:String=""; //the player's name
		//
		public var storeItemsRegister:Dictionary=new Dictionary();
		//
		private var _gameID:String="";
		private var _boardID:String="";
		//----------------------------------
		//  CONSTANTS
		//----------------------------------

		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		//
		public function get boardID():String
		{
			return _boardID;
		}

		public function set boardID(value:String):void
		{
			_boardID = value;
		}
		//
		public function get gameID():String
		{
			return _gameID;
		}

		public function set gameID(value:String):void
		{
			_gameID = value;
		}
		//
		public function get hasCaptureIndicator():Boolean
		{
			return storeItemsRegister.hasOwnProperty("abfa5115d7c3dc75"); //chess piece capture indicator id.
		}

		//
		public function get hasCheckIndicator():Boolean
		{
			return storeItemsRegister.hasOwnProperty("8661560570f7f8e6"); //chess piece check indicator id.
		}
		
		//
		public function get hasMoveIndicator():Boolean
		{
			//TODO: implement function
			return false;
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
		public function MochiModel()
		{
			//The [Init] metadata tells Parsley to call the annotated method after
			//an instance of this object is created and configured.
			score.setValue(0);
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		public function toString():String
		{
			return ObjectUtil.toString(this);
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
	}

}


