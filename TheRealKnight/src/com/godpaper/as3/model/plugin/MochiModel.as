package com.godpaper.as3.model.plugin
{
	import com.godpaper.as3.errors.DefaultErrors;

	import de.polygonal.ds.HashMap;

	import flash.display.MovieClip;

	import mochi.as3.MochiDigits;


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
	public class MochiModel
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
		public var storeItemsRegister:HashMap=new HashMap();

		//----------------------------------
		//  CONSTANTS
		//----------------------------------

		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		//
		public function get hasCaptureIndicator():Boolean
		{
			return (null != storeItemsRegister.find("abfa5115d7c3dc75")); //chess piece capture indicator id.
		}

		//
		public function get hasCheckIndicator():Boolean
		{
			return (null != storeItemsRegister.find("8661560570f7f8e6")); //chess piece check indicator id.
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

		}

		/**
		 * The [Init] metadata tells Parsley to call the annotated method after
		 * an instance of this object is created and configured.
		 */
		[Init]
		public function init():void
		{
			score.setValue(0);
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


