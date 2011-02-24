package com.godpaper.as3.messages
{

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------

	/**
	 * ConductMessage.as class.
	 * /********************************************************
	 * This is the message that is instatiated and dispatched.
	 * It is meant to request an RSS Feed.
	 * Parsley uses primarely the class type to select what Command
	 * to execute, but it recognizes that you could also have the same
	 * class and wish to invoke different Commands depending on some
	 * values of this class.  So it also uses a selector property of this class.
	 * Somewhat similar to the Event type selector, but without the same limitations.
	 *
	 * For more Parsley Examples visit artinflex.blogspot.com
	 * /********************************************************
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Feb 15, 2011 4:29:14 PM
	 */
	public class ConductMessage
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var _brevity:String;

		//----------------------------------
		//  CONSTANTS
		//----------------------------------

		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		public function get brevity():String
		{
			return _brevity;
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
		public function ConductMessage(brevity:String)
		{
			_brevity=brevity;
		}
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
	/***********************
	 *  In parsley the Selector can be any property name.  You must use
	 * types that are easily compared by value and not by reference.
	 * You simply tag the property with the Selector tag to indicate to
	 * Parsley that this is the property you wish to use as selector.
	 */
//		[Selector]

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

