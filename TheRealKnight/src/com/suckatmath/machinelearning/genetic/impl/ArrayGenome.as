package com.suckatmath.machinelearning.genetic.impl {
	import com.suckatmath.machinelearning.genetic.core.Gene;
	import com.suckatmath.machinelearning.genetic.core.Genome;
	
	/**
	* Basic array backed genome implementation.  Use this for collections of independently varying genes.
	* This is not a good match for genomes in which copying, swapping, or moving of genes.
	* @author srs
	*/
	public class ArrayGenome implements Genome {
		private var backing:Array; //of Gene
		
		/**
		 * number of genes
		 */
		public var length:int;
		
		/**
		 * example Gene to use for new random Genes
		 */
		public var exampleGene:Gene;
		
		/**
		 * create a new empty ArrayGenome
		 */
		public function ArrayGenome() {
			backing = new Array();
			length = 0;
		}
		
		/**
		 * set length
		 * 
		 */
		public function setLength(l:int):void {
			length = l;
		}
		
		/**
		 * set example Gene to use for new random genes
		 * @param	g
		 */
		public function setExampleGene(g:Gene):void {
			exampleGene = g;
		}
		
		/**
		 * create a copy of this genome with some probability of mutation.  Mutates at most 1 gene.
		 * @param	probability Number between 0 and 1
		 * @return
		 */
		public function mutate(probability:Number):Genome {
			var toreturn:ArrayGenome = this.clone() as ArrayGenome;
			var p:Number = Math.random();
			if (p < probability) //we do mutate
			{
				var i:int = Math.floor(Math.random() * length);
				toreturn.backing[i] = toreturn.backing[i].mutate();
			}
			return toreturn;
		}
		
		/**
		 * construct a new genome from this and others.
		 * @param	others
		 * @return
		 */
		public function crossover(others:Array, numpoints:int):Genome {
			var parents:Array;
			if (others.indexOf(this) == -1) {
				parents = others.concat(this);
			}else {
				parents = others;
			}
			var toreturn:ArrayGenome = new ArrayGenome();
			//pick numpoints indices between 0 and backing.length.
			if (numpoints > backing.length) {
				numpoints = backing.length;
			}
			var cps:Array = new Array(numpoints);
			for (var j:int = 0; j < numpoints; j++) {
				cps[j] = Math.floor(Math.random() * backing.length);
			}
			cps.sort(Array.NUMERIC);
			//trace("cps: " + cps);
			j = 0;
			var prev:int = -1;
			var p:ArrayGenome = parents[Math.floor(Math.random()*parents.length)];
			for (var i:int = 0; i < backing.length; i++) {
				if (i == cps[j]){
					p = parents[Math.floor(Math.random()*parents.length)];
					j++;
					while (cps[j] == prev) {
						j++;
						prev = cps[j];
					}
					prev = cps[j];
				}
				toreturn.backing[i] = p.backing[i];
			}
			return toreturn;
		}
		
		/**
		 * generate a new random genome.  Uses exampleGene to create random Genes
		 * @return Genome
		 */
		public function newRandom():Genome {
			var toreturn:ArrayGenome = new ArrayGenome();
			toreturn.setLength(length);
			for (var i:int = 0; i < length; i++) {
				toreturn.backing[i] = exampleGene.newRandom();
			}
			return toreturn;
		}
		
		/**
		 * generate a copy of this Genome.
		 * @return Genome
		 */
		public function clone():Genome {
			var toreturn:ArrayGenome = new ArrayGenome();
			toreturn.backing = this.backing.concat(); //ghetto clone.
			return toreturn;
		}
		
		/**
		 * get actual genes 
		 * @return Array
		 */
		public function getGenes():Array {
			return backing;
		}
		
		/**
		 * Return a string representation of this Genome
		 * @return String
		 */
		public function toString():String {
			var toreturn:String = "";
			for (var i:int = 0; i < backing.length; i++) {
				toreturn += backing[i].toString();
			}
			return toreturn;
		}
		
	}
	
}