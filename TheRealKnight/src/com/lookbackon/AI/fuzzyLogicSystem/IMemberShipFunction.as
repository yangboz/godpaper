package com.lookbackon.AI.fuzzyLogicSystem
{
	/**
	 * Define an interface that let you create your own membership function for the VariableValue.
	 * These functions take a crisp value(angle or others)
	 * as a parameter and output a number between 0 and 1.
	 * Each lingustic value has an assoicated MemberShip function.
	 * The idea behind the MemberShip function is to define 
	 * how much a crisp value is related to a specific lingustic value.
	 * The most common MemberShip functions are:
	 * Linear,
	 * Triangular,
	 * Tapezoidal(Left shoulder,right shoulder)
	 * 
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public interface IMemberShipFunction
	{
		function memberShipOf(value:Number):Number;
	}
}