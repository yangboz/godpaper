package com.lookbackon.AI.evaluation.fuzzy
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.model.vos.PositionVO;
	import com.lookbackon.AI.evaluation.IEvaluation;
	import com.godpaper.as3.consts.DefaultPiecesConstants;
	
	/**
	 * FuzzyImportantEvaluation.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Aug 24, 2011 6:35:07 PM
	 */   	 
	public class FuzzyImportantEvaluation implements IEvaluation
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
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
		public function FuzzyImportantEvaluation()
		{
		}
		
		public function doEvaluation(conductVO:ConductVO, gamePosition:PositionVO):int
		{
			//Todo:doEvaluation about assumpted conductVO;
			var importantValue:int = DefaultPiecesConstants[conductVO.target.type].important.gett(conductVO.nextPosition.x,conductVO.nextPosition.y);
			var fuzzyImportValue:int = DefaultPiecesConstants[conductVO.target.type].convertedImportant.gett(conductVO.nextPosition.x,conductVO.nextPosition.y);
			//TODO:dynamic omenVO value to be calculated. 
			//precies evaluation value.
			return importantValue+fuzzyImportValue;
			//			return _positionEvaluation;
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