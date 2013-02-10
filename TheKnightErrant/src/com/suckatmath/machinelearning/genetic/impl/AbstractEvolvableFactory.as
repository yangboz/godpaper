package com.suckatmath.machinelearning.genetic.impl {
	import com.suckatmath.machinelearning.genetic.core.EvolvableFactory;
	import com.suckatmath.machinelearning.genetic.core.Evolvable;
	import com.suckatmath.machinelearning.genetic.core.Genome;
	
	/**
	* Convenience base class for EvolvableFactories.  Not required, but useful.
	* uses an example genome as a template.
	* Don't use this directly.  Extend it.
	* @author srs
	*/
	public class AbstractEvolvableFactory implements EvolvableFactory {
		
		/**
		 * template genome to use.  makeEvolvable can call newRandom on this.
		 */
		public var exampleGenome:Genome;
		
		/**
		 * 
		 * @param	g Genome to use as example
		 */
		public function AbstractEvolvableFactory(g:Genome) {
			exampleGenome = g;
		}
		
		/**
		 * create a new Evolvable
		 * @param	g - if not given, will use exampleGenome
		 */
		public function makeEvolvable(g:Genome = null):Evolvable {
			if (g == null) {
				g = exampleGenome.newRandom();
			}
			return buildEvolvable(g);
		}
		
		public function makeRandomEvolvable():Evolvable {
			return makeEvolvable();
		}
		
		/**
		 * As implemented, this is useless.  Override it with something that builds Evolvables you want.
		 * @param	g
		 * @return
		 */
		public function buildEvolvable(g:Genome):Evolvable {
			return new DefaultEvolvable();
		}
		
	}
	
}