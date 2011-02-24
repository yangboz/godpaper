package com.godpaper.as3.errors
{
	import mx.utils.UIDUtil;

	/**
	 *
	 * Customize errors occured at CCJ.
	 *
	 * @author Knight.zhou
	 *
	 */	
	public class CcjErrors extends Error
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		public static const INITIALIZE_VIRTUAL_FUNCTION:String  = "Virtual function initialized!!!";
		public static const INITIALIZE_SINGLETON_CLASS:String   = "Singleton class initialized!!!";
		public static const INVALID_CHESS_VO:String 			= "Invalid chess value object initialized!";
		public static const INVALID_CHESS_PIECE_INDEX:String 	= "Invalid chess piece index!";
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function CcjErrors(message:String="", id:int=0)
		{
			//TODO: implement function
			super(message, id);
		}
	}
}

