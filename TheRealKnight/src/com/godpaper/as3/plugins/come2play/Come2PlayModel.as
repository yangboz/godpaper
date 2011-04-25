package com.godpaper.as3.plugins.come2play
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.plugins.IPlugData;
	
	import mx.utils.ObjectUtil;
	
	
	/**
	 * Come2PlayModel.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Apr 25, 2011 3:01:26 PM
	 */   	 
	public class Come2PlayModel implements IPlugData
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var _boardID:String;
		private var _gameID:String;
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
		public function Come2PlayModel()
		{
			//TODO: implement function
		}
		
		public function set gameID(value:String):void
		{
			_gameID = value;
		}
		
		public function get gameID():String
		{
			return _gameID;
		}
		
		public function set boardID(value:String):void
		{
			_boardID = value;
		}
		
		public function get boardID():String
		{
			return _boardID;
		}
		
		public function get hasCaptureIndicator():Boolean
		{
			//TODO: implement function
			return false;
		}
		
		public function get hasCheckIndicator():Boolean
		{
			//TODO: implement function
			return false;
		}
		
		public function toString():String
		{
			return ObjectUtil.toString(this);
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