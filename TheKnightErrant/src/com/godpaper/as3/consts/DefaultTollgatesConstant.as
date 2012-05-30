package com.godpaper.as3.consts
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	import com.godpaper.as3.utils.Enum;
	import com.lookbackon.AI.evaluation.fuzzy.FuzzyImportantEvaluation;
	import com.lookbackon.AI.evaluation.linear.LinearEvaluation;
	import com.lookbackon.AI.searching.AttackFalse;
	import com.lookbackon.AI.searching.MiniMax;
	import com.lookbackon.AI.searching.RandomWalk;
	import com.lookbackon.AI.searching.ShortSighted;

	/**
	 * DefaultTollgatesConstant.as class which providing easy tollgate configuration.	
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
		public static const SuicideDiscord:DefaultTollgatesConstant = new DefaultTollgatesConstant(RandomWalk,LinearEvaluation,null,null,"Suicide Discord",10,AssetEmbedsDefault.ICON_TOLLGATE_01);
		public static const HorrorGib:DefaultTollgatesConstant = new DefaultTollgatesConstant(ShortSighted,LinearEvaluation,null,null,"Horror Gib",30,AssetEmbedsDefault.ICON_TOLLGATE_02);
		public static const UnnaturalBase:DefaultTollgatesConstant = new DefaultTollgatesConstant(AttackFalse,LinearEvaluation,null,null,"Unnatural Base",55,AssetEmbedsDefault.ICON_TOLLGATE_03);
		public static const OctagonGibs:DefaultTollgatesConstant = new DefaultTollgatesConstant(MiniMax,LinearEvaluation,null,null,"Octagon Gibs",85,AssetEmbedsDefault.ICON_TOLLGATE_04);
		public static const AbandonedDream:DefaultTollgatesConstant = new DefaultTollgatesConstant(MiniMax,FuzzyImportantEvaluation,null,null,"Abandoned Dream",100,AssetEmbedsDefault.ICON_TOLLGATE_05);
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
		public var score:Number;
		public var icon:Class;
		//
		final public function DefaultTollgatesConstant(searching:Class,evaluation:Class,learning:Class,fuzzyLogic:Class,tips:String,score:Number,icon:Class)
		{
			this.searching = searching;
			this.evaluation = evaluation;
			this.learning = learning;
			this.fuzzyLogic = fuzzyLogic;
			this.tips = tips;
			this.score = score;
			this.icon = icon;
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