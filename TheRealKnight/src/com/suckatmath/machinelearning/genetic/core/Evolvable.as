package com.suckatmath.machinelearning.genetic.core {
	
	/**
	* Defines methods used by the GeneticEngine to perform the genetic algorithm.  
	* Implement this in your classes which you'd like to optimize.
	* 
	* @author srs
	*/
	public interface Evolvable {
		
		
		/**
		 * gets the genome used to generate this evolvable, and mutate/combine to create a new genome for next generation
		 * @return 
		 */
		function getGenome():Genome;
		
		/**
		 * The scale of this number is arbitrary.  0-1 will work just as well as -100000 - 100000 or other range
		 * Used directly in Roulette selection with proportional selection,
		 * but only in ranking for default Tournament selection.
		 * You can define a different EvolvableComparator for Tournament which does not use this at all.
		 * 
		 * @return Number
		 */
		function getFitness():Number;
		
	}
	
}