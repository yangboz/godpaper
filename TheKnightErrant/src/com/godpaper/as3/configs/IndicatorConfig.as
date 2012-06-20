package com.godpaper.as3.configs
{
	import com.godpaper.as3.model.FlexGlobals;
	import com.godpaper.starling.views.popups.ComputerWinIndicatory;
	import com.godpaper.starling.views.popups.ThinkIndicatory;
	
	import org.josht.starling.foxhole.controls.Callout;
	import org.josht.starling.foxhole.core.PopUpManager;
	
	import starling.display.DisplayObject;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	/**
	 * IndicatorConfig.as class.All kinds of indicators configurations here.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jan 27, 2011 2:07:57 PM
	 */   	 
	public class IndicatorConfig
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//default 
		private static var _readOut:Boolean=false;
		//about chess check(chinese chess jam..)
		public static var check:Boolean=false;
		//about plugins(mochi..)
		public static var submitScore:Boolean=false;
		//about airport(utility,extreme,etc..)
		public static var airportUtility:Boolean=false;
		//about popup the computer win title window
		private static var _outcome:Boolean=false;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------

		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		public static function get outcome():Boolean
		{
			return _outcome;
		}
		private static var computerWinIndicatory:ComputerWinIndicatory;
		public static function set outcome(value:Boolean):void
		{
			_outcome = value;
			//Call out view(progress bar).
			if(value)
			{
				computerWinIndicatory = new ComputerWinIndicatory();
				Callout.show(computerWinIndicatory, FlexGlobals.gameScene.chessBoard, Callout.DIRECTION_ANY);
			}else
			{
				//				if(thinkIndicatoryPopup)
				//				{
				//					PopUpManager.removePopUp(computerWinIndicatory);	
				//				}
			}
		}
		//
		public static function get readOut():Boolean
		{
			return _readOut;
		}
		//
		private static var thinkIndicatory:ThinkIndicatory;
		public static function set readOut(value:Boolean):void
		{
			_readOut = value;
			//Call out view(progress bar).
			if(value)
			{
				thinkIndicatory = new ThinkIndicatory();
				Callout.show(thinkIndicatory, FlexGlobals.gameScene.chessBoard, Callout.DIRECTION_DOWN);
			}else
			{
				//				if(thinkIndicatoryPopup)
				//				{
				//					PopUpManager.removePopUp(thinkIndicatoryPopup);	
				//				}
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

