package com.suckatmath.machinelearning.genetic.core {
	
	/**
	* creates new Evolvables from Genomes
	* @author srs
	*/
	public interface EvolvableFactory {

		/**
		 * 
		 * @param	g:Genome may be null - generate a valid evolvable anyway.
		 * @return Evolvable
		 */
		function makeEvolvable(g:Genome = null):Evolvable;
		
		/**
		 * 
		 * @return Evolvable from random genome
		 */
		function makeRandomEvolvable():Evolvable;
		
	}
	
}