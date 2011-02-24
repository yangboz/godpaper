package com.lookbackon.AI.fuzzyLogicSystem
{
	

	/**
	 * Define a linguistic value and has an IMemberShipFunction
	 * that define a MemberShip function for the sepcific value.
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class VariableValue
	{
		private var memberShip:IMemberShipFunction;
		private var _value:String;
		public function get value():String
		{
			return _value;
		}

		public function VariableValue(valueS:String,memberShip:IMemberShipFunction)
		{
			this._value = valueS;
			this.memberShip = memberShip;
		}
		
		public function memberShipOf(valueN:Number):Number
		{
			return memberShip.memberShipOf(valueN);
		}
	}
}