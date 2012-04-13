package com.lookbackon.AI.fuzzyLogicSystem
{
	import com.godpaper.as3.utils.LogUtil;
	
	import mx.logging.ILogger;

	/**
	 * Fuzzy rules are basically if<condition> then <decision>.
	 * The condition part is,for this example ,
	 * in form of <linguistic variable 1> = <linguistic value 1> 
	 * AND <linguistic variable 2> = <linguistic value 2> AND...
	 * the decision part,in this Fuzzy system,
	 * is a assignment of a crisp value.
	 * e.g.: IF direction=north AND direction=west  THEN  turn:=-15°
	 * new FuzzyRule( 15, new Array( "east", "left" ))
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class FuzzyRule
	{
		private static const LOG:ILogger = LogUtil.getLogger(FuzzyRule);
		private var ifValues:Array;
		private var crispResult:Number;
		private var vars:Array;
		
		public function FuzzyRule(crispResult:Number,ifValues:Array,vars:Array=null)
		{
			this.crispResult = crispResult;
			this.ifValues = ifValues;
			this.vars = vars;
		}
		
		public function addIfValue(value:String):void
		{
			ifValues.push( value );
		}
		
		public function getWeight(sets:Array):Number
		{
			var res:Number = 1;
			var i:Number = 0;
			for each(var ifValue:String in ifValues)
			{
				var fs:FuzzySet = sets[i] as FuzzySet;
//				LOG.debug("fs.getMemberShip({0}):{1}",ifValue,fs.getMemberShip(ifValue));
				res *= fs.getMemberShip(ifValue);
				i++;
			}
			return res;
		}
		
		public function get crispOutput():Number
		{
			return crispResult;
		}
	}
}