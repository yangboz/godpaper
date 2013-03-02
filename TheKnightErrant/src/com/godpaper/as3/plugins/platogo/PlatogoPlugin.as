/**
 *  GODPAPER Confidential,Copyright 2012. All rights reserved.
 *
 *  Permission is hereby granted, free of charge, to any person obtaining
 *  a copy of this software and associated documentation files (the "Software"),
 *  to deal in the Software without restriction, including without limitation
 *  the rights to use, copy, modify, merge, publish, distribute, sub-license,
 *  and/or sell copies of the Software, and to permit persons to whom the
 *  Software is furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included
 *  in all copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 *  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 *  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
 *  IN THE SOFTWARE.
 */
package com.godpaper.as3.plugins.platogo
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.configs.IndicatorConfig;
	import com.godpaper.as3.core.FlexGlobals;
	import com.godpaper.as3.plugins.IPlug;
	import com.godpaper.as3.plugins.IPlugData;
	import com.godpaper.as3.utils.LogUtil;
//	import com.platogo.api.PlatogoAPI;
//	import com.platogo.api.enums.PlatogoStatus;
//	import com.platogo.api.vo.PlatogoResponse;
//	import com.platogo.components.GameHighscore;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import mx.logging.ILogger;
	import mx.utils.ObjectUtil;
	
	[Deprecated]
	/**
	 * PlatogoPlugin.as class.Deprecated this which using flash movie clip based component.
	 * @see http://www.platogo.com/wrapper/devcenter/articles/components
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Jun 25, 2012 1:58:05 PM
	 */   	 
	public class PlatogoPlugin implements IPlug
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var _model:PlatogoModel;
//		private var platogoAnimation:MovieClip;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(PlatogoPlugin);
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
		public function PlatogoPlugin(gameID:String="", boardID:String="")
		{
			_model = new PlatogoModel();
			_model.gameID = gameID;
			_model.boardID = boardID;
		}
		
		public function get data():IPlugData
		{
			return _model;
		}
		
		public function initialization():void
		{
//			PlatogoAPI.connect(uint(data.gameID),FlexGlobals.topLevelApplication.pluginStage.stage,connectedHandler);
			//
			IndicatorConfig.waiting = true;
			//
//			platogoAnimation = new PlatogoAnimation();
//			platogoAnimation.x = FlexGlobals.topLevelApplication.stage.stageWidth / 2;
//			platogoAnimation.y = FlexGlobals.topLevelApplication.stage.stageHeight / 2;
//			
//			platogoAnimation.addEventListener(Event.COMPLETE, completeListener, false, 0, true);
//			FlexGlobals.topLevelApplication.stage.addChild(platogoAnimation);
			
		}
		
		public function showData():Boolean
		{
//			LOG.debug(ObjectUtil.toString(PlatogoAPI.gameInformation) );
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
//		private function connectedHandler( response : PlatogoResponse ) : void
//		{
//			if ( response.status == PlatogoStatus.OK )
//			{
//				LOG.debug( "You are now connected to Platogo & the API is ready to be used." );
//			}
//			//
//			IndicatorConfig.waiting = false;
////			FlexGlobals.topLevelApplication.stage.removeChild(platogoAnimation);
//		}
		//
//		private function completeListener(event:Event):void 
//		{
//			platogoAnimation.removeEventListener(Event.COMPLETE, completeListener);
//			
//			trace("Platogo animation is completed - ready to continue game.");
//		}
	}
	
}