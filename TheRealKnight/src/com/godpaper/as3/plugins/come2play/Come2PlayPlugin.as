package com.godpaper.as3.plugins.come2play
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.plugins.IPlug;
	import com.godpaper.as3.plugins.IPlugData;
	import com.godpaper.as3.utils.LogUtil;
	
	import come2play_as3.api.AS3ScoreAPI;
	
	import mx.core.FlexGlobals;
	import mx.logging.ILogger;
	
	
	/**
	 * Come2PlayPlugin.as class.   	
	 * @see:http://www.come2play.com/
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Apr 25, 2011 3:01:03 PM
	 */   	 
	public class Come2PlayPlugin implements IPlug
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var _come2PlayModel:Come2PlayModel;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(Come2PlayPlugin);
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
		public function Come2PlayPlugin(gameID:String="",boardID:String="")
		{
			_come2PlayModel = new Come2PlayModel();
			_come2PlayModel.gameID = gameID;
			_come2PlayModel.boardID = boardID;
		}
		
		public function get data():IPlugData
		{
			return _come2PlayModel;
		}
		
		public function initialization():void
		{
			//
			AS3ScoreAPI.preload(
				FlexGlobals.topLevelApplication.pluginStage.stage,
				_come2PlayModel.gameID,//"4407",
				FlexGlobals.topLevelApplication.width,
				FlexGlobals.topLevelApplication.height,
				preloadCompleteHandler);
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
			//
			if(value.hasOwnProperty("score"))
			{
				AS3ScoreAPI.sendScore(value.score, sendScoreCompleteHandler); 
			}
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
		private function preloadCompleteHandler():void
		{
			LOG.info("preloadCompleteHandler!");
		}
		//
		private function sendScoreCompleteHandler():void
		{
			LOG.info("sendScoreCompleteHandler!");
		}
	}
	
}