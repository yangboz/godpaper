package com.lookbackon.AI.fuzzyLogicSystem
{
	/**
	 * Lingustic variables:
	 * these are simply variables whoes values are lingustic.
	 * e.g.:for the lingustic variable "direction" the possible values
	 * could be "north","west","south","east".
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class Variable
	{
		protected var values:Array;
		public function Variable()
		{
			values = [];
		}
		
		public function addValue(value:VariableValue):void
		{
			values.push( value );
		}
		
		public function gett(index:String):VariableValue
		{
			for each( var value:VariableValue  in values)
			{
				if(value.value == index)
				{
					return value;
				}
			}
			return null;
		}
	}
}