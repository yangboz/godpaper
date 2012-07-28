package com.godpaper.as3.configs
{
	import com.godpaper.as3.core.FlexGlobals;
	import com.godpaper.as3.impl.AbstractChessVO;
	import com.godpaper.as3.views.popups.ComputerWinIndicatory;
	import com.godpaper.as3.views.popups.HumanWinIndicatory;
	import com.godpaper.as3.views.popups.ThinkIndicatory;
	
	import org.josht.starling.foxhole.controls.Callout;
	import org.josht.starling.foxhole.controls.popups.CalloutPopUpContentManager;
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
		private static var _submitScore:Boolean=false;
		//about airport(utility,extreme,etc..)
		public static var airportUtility:Boolean=false;
		//about popup the computer win title window
		private static var _outcome:Boolean=false;
		//call out(popup manager).
		private static var _callout:CalloutPopUpContentManager = new CalloutPopUpContentManager();
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
//				Callout.show(computerWinIndicatory, getChessBoard(), Callout.DIRECTION_ANY);
//				_callout.open(computerWinIndicatory,FlexGlobals.gameScene);
				PopUpManager.addPopUp(computerWinIndicatory);
			}else
			{
//				_callout.close();
				if(computerWinIndicatory)
				{
					PopUpManager.removePopUp(computerWinIndicatory);
				}
			}
		}

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
//				Callout.show(thinkIndicatory, getChessBoard(), Callout.DIRECTION_DOWN);
//				_callout.open(thinkIndicatory,FlexGlobals.gameScene);
				PopUpManager.addPopUp(thinkIndicatory);
			}else
			{
//				_callout.close();
				if(thinkIndicatory)
				{
					PopUpManager.removePopUp(thinkIndicatory);
				}
			}
		}
		//
		private static var humanWinIndicatory:HumanWinIndicatory;
		public static function get submitScore():Boolean
		{
			return _submitScore;
		}
		
		public static function set submitScore(value:Boolean):void
		{
			_submitScore = value;
			//Call out view(progress bar).
			if(value)
			{
				humanWinIndicatory = new HumanWinIndicatory();
				//				Callout.show(computerWinIndicatory, getChessBoard(), Callout.DIRECTION_ANY);
				//				_callout.open(computerWinIndicatory,FlexGlobals.gameScene);
				PopUpManager.addPopUp(humanWinIndicatory);
			}else
			{
				//				_callout.close();
				if(humanWinIndicatory)
				{
					PopUpManager.removePopUp(humanWinIndicatory);
				}
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
//		private static function getChessBoard():DisplayObject
//		{
//			return DisplayObject(FlexGlobals.gameScene.chessBoard);
//		}

	}

}

