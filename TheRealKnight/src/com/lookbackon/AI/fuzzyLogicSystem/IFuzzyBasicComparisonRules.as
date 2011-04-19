package com.lookbackon.AI.fuzzyLogicSystem
{
	/**
	 * The IFuzzyBasicComparisonRulses interface works on the idea
	 * that it can be inherited by any object that we wish to implement to.
	 * The reason to use an interface is because at this moment in time 
	 * we don't know what class the interface is going to be used 
	 * in nor if the rules for the comparisons is even going to be used 
	 * between objects that are of the same type. 
	 * I think I should make it specifically clear at this point 
	 * that what the interface implements is not the rule itself, 
	 * because at this very low level of dealing with a simple number, 
	 * it would involve too much twisting logic into the class to make it work. 
	 * The idea being that at some point a class would use the FuzzyDouble class 
	 * and deal with the Fuzzy Double depending on the rules set within the object. 
	 * So at this point, we are merely setting the rules that the type 
	 * is supposed to adhere to.
	 *  
	 * @author knight.zhou
	 * 
	 * @see http://www.codeproject.com/KB/recipes/fuzzylogicvadaline.aspx
	 */	
	public interface IFuzzyBasicComparisonRules
	{
		function isGreaterThan(value:Number):Number;
		
		function isLessThan(value:Number):Number;
		
		function isEqual(value:Number):Number;
	}
}