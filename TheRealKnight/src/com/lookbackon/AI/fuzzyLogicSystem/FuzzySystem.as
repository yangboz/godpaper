package com.lookbackon.AI.fuzzyLogicSystem
{
	/**
	 * This class lets you define a set of rules.
	 * all defining the same crisp variable and calculate
	 * the aggregated crisp output.
	 * e.g.:
	 * system.addRule(new FuzzyRule(15, new Array(  "north", "left" ) ));
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class FuzzySystem implements IFuzzyBasicComparisonRules
	{
		private var rules:Array;
		private var boundarys:Array;
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function FuzzySystem()
		{
			rules  = [];
			boundarys = [
				11111,//11111
				22222,//22222
				33333,//33333
				44444,//44444
				55555 //55555
				];
		}
		//----------------------------------
		//  addRule(native)
		//----------------------------------
		public function addRule(rule:FuzzyRule):void
		{
			rules.push( rule );
		}
		//----------------------------------
		//  crispOutput(native)
		//----------------------------------
		private function crispOutput(sets:Array):Number
		{
			var vals:Number=0.0000;
			var weights:Number=0.0000;
			for each(var rule:FuzzyRule in rules)
			{
				weights += rule.getWeight( sets );
				vals += rule.getWeight( sets )*rule.crispOutput;
			}
			return vals/weights;
		}
		//----------------------------------
		//  crispOutputWarpper(native)
		//----------------------------------
		public function crispOutputWarpper(sets:Array):Number
		{
			var result:Number = crispOutput(sets);
			if( this.isEqual(result)!= -1)
			{
				return result;	
			}else
			{
				var greaterThan:Number = this.isGreaterThan(result);
				var lessThan:Number = this.isLessThan(result);
//				trace("isGreaterThan:",greaterThan);
//				trace("crispOutput:",result);
//				trace("isLessThan:",lessThan);
				var closeToSomeOne:Number;
				if((lessThan-result)>=(result-greaterThan))
				{
					closeToSomeOne = greaterThan;
				}else
				{
					closeToSomeOne = lessThan;
				}
//				trace("isCloseToSomeOne:",closeToSomeOne);
				return closeToSomeOne;
			}
			return -1;
		}
		//----------------------------------
		//  isGreaterThan(implement)
		//----------------------------------
		public function isGreaterThan(value:Number):Number
		{
			for(var i:int=0;i<boundarys.length;i++)
			{
				if(value>boundarys[i])
				{
					return boundarys[i];
				}
			}
			return -1;
		}
		//----------------------------------
		//  isLessThan(implement)
		//----------------------------------
		public function isLessThan(value:Number):Number
		{
			for(var i:int=0;i<boundarys.length;i++)
			{
				if(value<boundarys[i])
				{
					return boundarys[i];
				}
			}
			return -1;
		}
		//----------------------------------
		//  isEqual(implement)
		//----------------------------------
		public function isEqual(value:Number):Number
		{
			for(var i:int=0;i<boundarys.length;i++)
			{
				if(value==boundarys[i])
				{
					return boundarys[i];
				}
			}
			return -1;
		}


	}
}