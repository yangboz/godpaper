package com.godpaper.as3.consts
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.utils.Enum;
	/**
	 * DefaultTollgatesConstant.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Aug 9, 2011 2:27:52 PM
	 */   	 
	public class DefaultTollgatesConstant extends Enum
	{		
		//static construct.
		{initEnum(DefaultTollgatesConstant);}
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		//@see http://www.digital-eel.com/blog/qlng.htm
		//Tollgates name list as follows:
//		Suicide Discord
//		Horror Gib
//		Unnatural Base
//		Octagon Gibs
//		Abandoned Dream
//		Ziggurat Factory
//		Concrete Factory
//		Wicked Hell
//		Satan Madness
//		Grunt Hell
//		True Agony
//		True Hive
//		Lonely Grinder
//		Horror Temple 
//		public static const SuicideDiscord:DefaultTollgatesConstant = new DefaultTollgatesConstant(
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
		//public properties.
		public var searching:Class;
		public var evaluation:Class;
		public var learning:Class;
		public var fuzzyLogic:Class;
		public var tips:String;
		//
		final public function DefaultTollgatesConstant(searching:Class,evaluation:Class,learning:Class,fuzzyLogic:Class,tips:String)
		{
			this.searching = searching;
			this.evaluation = evaluation;
			this.learning = learning;
			this.fuzzyLogic = fuzzyLogic;
			this.tips = tips;
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