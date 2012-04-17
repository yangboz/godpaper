package com.lookbackon.AI.evaluation.statical.nelderMeadSimplex
{
	/**
	 *
	 * @see  http://code.google.com/p/nelder-mead-simplex/
	 *
	 * @author Knight.zhou
	 *
	 */	
	public class RegressionResult
	{
		private var _terminationReason:TerminationReason;
		private var _constants:Array;
		private var _errorValue:Number;
		private var _evaluationCount:int;

		public function RegressionResult( terminationReason:TerminationReason, 
			constants:Array, 
			errorValue:Number, 
			evaluationCount:int
			)
		{
			_terminationReason = terminationReason;
			_constants = constants;
			_errorValue = errorValue;
			_evaluationCount = evaluationCount;
		}

		public function get TerminationReason():TerminationReason
		{
			return _terminationReason;
		}

		public function get Constants():Array
		{
			return _constants;
		}

		public function get ErrorValue():Number
		{
			return _errorValue;
		}

		public function EvaluationCount():int
		{
			return _evaluationCount;
		}
	}
}
import com.godpaper.as3.utils.Enum;

internal class TerminationReason extends Enum
{
	{initEnum(TerminationReason);}//static construct.

	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	//
	public var MaxFunctionEvaluations:*;
	public var Converged:*;
	public var Unspecified:*;

	public function TerminationReason()
	{
		//TODO: implement function
		super();
	}
}


