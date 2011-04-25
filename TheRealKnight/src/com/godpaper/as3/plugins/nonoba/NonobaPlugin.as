package com.godpaper.as3.plugins.nonoba
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.plugins.IPlug;
	import com.godpaper.as3.plugins.IPlugData;
	
	
	/**
	 * NonobaPlugin.as class.   	
	 * @see:http://www.nonoba.com/developers/documentation/actionscript3
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Apr 25, 2011 3:32:13 PM
	 */   	 
	public class NonobaPlugin implements IPlug
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var _model:NonobaModel;
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
		public function NonobaPlugin()
		{
			//TODO: implement function
		}
		
		public function get data():IPlugData
		{
			//TODO: implement function
			return null;
		}
		
		public function initialization():void
		{
			//TODO: implement function
		}
		
		public function showData():Boolean
		{
			//TODO: implement function
			return false;
		}
		
		public function showStore():Boolean
		{
			//TODO: implement function
			return false;
		}
		
		public function showLeaderboard(value:Object):Boolean
		{
			//TODO: implement function
			return false;
		}
		
		public function showLoginWidget():Boolean
		{
			//TODO: implement function
			return false;
		}
		
		public function saveData(value:Object):Boolean
		{
			//TODO: implement function
			return false;
		}
		
		public function submitData(value:Object):Boolean
		{
			//TODO: implement function
			return false;
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