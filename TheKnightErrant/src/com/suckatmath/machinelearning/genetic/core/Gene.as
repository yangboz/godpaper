package com.suckatmath.machinelearning.genetic.core {
	
	/**
	* It is not necessary to use this interface if you define your own implementations of Genome, however it can be convenient
	* @author srs
	*/
	public interface Gene {
		
		/**
		 * return a slight variation of this Gene in a new Gene instance
		 * @return Gene
		 */
		function mutate():Gene;
		
		/**
		 * create and return a new random Gene
		 * 
		 * @return Gene
		 */
		function newRandom():Gene;
		
	}
	
}