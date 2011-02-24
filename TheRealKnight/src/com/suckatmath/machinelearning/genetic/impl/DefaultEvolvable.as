package com.suckatmath.machinelearning.genetic.impl {
	import com.suckatmath.machinelearning.genetic.core.Evolvable;
	import com.suckatmath.machinelearning.genetic.core.Genome;
	import flash.errors.IllegalOperationError;
	
	/**
	* Useless empty implementation of Evolvable.  Only exists for compilation purposes.
	* @author srs
	*/
	public class DefaultEvolvable implements Evolvable {
		
		public function DefaultEvolvable() {
			
		}
		
		public function getGenome():Genome {
			throw new IllegalOperationError("DefaultEvolvables are useless.  Implement your own");
			return null;
		}
		
		public function setGenome(g:Genome):void {
			throw new IllegalOperationError("DefaultEvolvables are useless.  Implement your own");
		}
		
		public function getFitness():Number {
			throw new IllegalOperationError("DefaultEvolvables are useless.  Implement your own");
			return NaN;
		}
		
		public function setFitness(f:Number):void {
			throw new IllegalOperationError("DefaultEvolvables are useless.  Implement your own");
		}
		
	}
	
}