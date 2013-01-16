package com.suckatmath.machinelearning.genetic.core {
	
	/**
	* Genome encapsulates the serialized version of your Evolvables.  This should have all the information necessary to build a new Evolvable
	* @author srs
	*/
	public interface Genome {
		
		/**
		 * create a new genome based on this one with some probability of slight differences
		 * @param	probability - number between 0 and 1 representing the probability that the genome will mutate.
		 * @return Genome - new Genome
		 */
		function mutate(probability:Number):Genome;
		
		/**
		 * "sexual" reproduction.  constructs a new genome by taking parts of parents.
		 * 
		 * @param	others Array full of Genomes representing other parents.
		 * @param	np number of crossover points
		 * @return Genome - new Genome
		 */
		function crossover(others:Array, np:int):Genome;
		
		/**
		 * construct a new random Genome
		 * @return
		 */
		function newRandom():Genome;
		
		/**
		 * return a copy of this Genome
		 * @return
		 */
		function clone():Genome;
		
	}
	
}