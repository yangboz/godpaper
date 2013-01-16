package com.lookbackon.AI.fuzzyLogicSystem
{
	/**
	 * These are sets whose elements are all the possible linguistic 
	 * value of a specific linguistic variable,each assoicated 
	 * with a MemberShip function value of the same Crisp value.
	 * e.g.:the set defined by the direction linguistic variable
	 * and the crisp value 80° would be
	 * (direction, 80°) :== {(north, 0.9),(west,0),(south,0),(east,0.1)}
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class FuzzySet
	{
		private var variable:Variable;
		private var crispValue:Number;
		
		public function FuzzySet(variable:Variable,crispValue:Number)
		{
			this.variable = variable;
			this.crispValue = crispValue;
		}
		
		public function getMemberShip(value:String):Number
		{
			var variableValue:VariableValue = variable.gett(value);
			if(variableValue!=null)
			{
				return variableValue.memberShipOf(crispValue);
			}else
			{
				throw new Error("INVALID_FUZZY_LOGIC_VALUE");
			}
			return -1;
		}
			
	}
}