package com.suckatmath.machinelearning.genetic.core 
{
	
	/**
	* Compares one Evolvable to another.  Used in TOURNAMENT selection.
	* GeneticEngine implements this with a simple getFitness comparison, used by default in TOURNAMENT selection
	* @author srs
	*/
	public interface EvolvableComparator 
	{
		/**
		 * Compare one Evolvable to another of the same type.  It is not necessarily an error to pass two different types of
		 * Evolvables, but it is discouraged.
		 * @param	e1
		 * @param	e2
		 * @return int < 0 if e1 is more fit than e2, 0 if they're equal, >0 if e2 is more fit than e1
		 */
		function compareFitness(e1:Evolvable, e2:Evolvable):int; 
		
	}
	
}