package com.suckatmath.machinelearning.genetic.impl {
	import com.suckatmath.machinelearning.genetic.core.Evolvable;
	import com.suckatmath.machinelearning.genetic.core.Genome;
	import com.suckatmath.machinelearning.markov.MarkovChain;
	import flash.utils.Dictionary;
	
	/**
	* Stupid little example evolvable.  Fitness is how "close" the string is to the goal string
	* Useful only for demonstrating genetic algorithms, since gaol is already known
	* @author Default
	*/
	public class EvolvableString implements Evolvable {
		/**
		 * goal string.  By default: "I will here give a brief sketch of the progress of opinion on the Origin of Species"
		 */
		public static var goal:String = "I will here give a brief sketch of the progress of opinion on the Origin of Species";
		
		/**
		 * map from String to letter totals
		 */
		private static var goalDistribution:Dictionary = initStatic(); 
		
		/**
		 * markov chain used to score individuals
		 */
		private static var mchain:MarkovChain = new MarkovChain(1, goal.split(""));
		
		/**
		 * fitness of this EvolvableString
		 * stored as a property for memo-ization since fitness calculation is expensive
		 */
		private var fitness:Number;
		
		/**
		 * calculates letter distribution of the goal for scoring purposes
		 * @return Dictionary
		 */
		private static function initStatic():Dictionary{
			var tot:int;
			var gd:Dictionary = new Dictionary();
			for (var i:int = 0; i < goal.length; i++)
			{
				if (gd[goal.charAt(i)] == undefined)
				{
					tot = 1;
				}else
				{
					tot = gd[goal.charAt(i)] + 1;
				}
				gd[goal.charAt(i)] = tot;
			}
			return gd;
		}
		
		/**
		 * genome used to build this EvolvableString
		 */
		public var genome:FixedLengthStringGenome;
		
		/**
		 * create a new EvolvableString
		 */
		public function EvolvableString() {
			fitness = -1;
		}
		
		/**
		 * set the genome of this EvolvableString
		 * @param	g FixedLengthStringGenome
		 */
		public function setGenome(g:Genome):void {
			genome = g as FixedLengthStringGenome;
		}
		
		/**
		 * get the FixedLengthStringGenome backing
		 * @return FixedLengthStringGenome as Genome
		 */
		public function getGenome():Genome {
			return genome;
		}
		
		/**
		 * calculates fitness, or returns saved fitness value
		 * uses markov chain, letter distributions, and absolute letter placement
		 * @return Number
		 */
		public function getFitness():Number {
		   if (fitness == -1){
			fitness = mchain.score(genome.content.split("")) + getFitness2();
			fitness = Math.pow(fitness, 8)/1000000000000; //pow to exaggerate proportional differences
		   }
		   return fitness;
		}
		
		/**
		 * calculates fitness based only on letter distribution and letter placement
		 * @return Number
		 */
		private function getFitness2():Number {
			//we determine fitness score by the following
			//each letter in the genome is given 1 point if it appears in the goal (up to number of times in goal)
			//and 5 additional points if it is in the correct place.
			var letter:String;
			var letterTots:Dictionary = new Dictionary(); //from letter to total.
			var score:Number = 0;
			var letterTot:int;
			for (var i:int = 0; i < genome.length; i++) {
				letter = genome.content.charAt(i);
				if (letterTots[letter] == undefined)
				{
					letterTot = 0;
					letterTots[letter] = 1;
				}else
				{
					letterTot = letterTots[letter];
					letterTots[letter] = letterTot + 1;
				}
				if (goalDistribution[letter] > letterTot) //if goal has more of letter than genome so far
				{
					score += 1;
				}
				if (goal.charAt(i) == letter) {
					score+=1;
				}
			}
			return score;
			
		}
		
		/**
		 * return min of 2 values
		 * @param	a int
		 * @param	b int
		 * @return int
		 */
		private function min2(a:int, b:int):int
		{
			if (a < b)
			{
				return a;
			}else
			{
				return b;
			}
		}
		
		/**
		 * return min of 3 values
		 * @param	a int
		 * @param	b int
		 * @param	c int
		 * @return int
		 */
		private function min3(a:int, b:int, c:int):int
		{
			return min2(min2(a, b), c);
		}
		
		/**
		 * return a String representation
		 * @return
		 */
		public function toString():String
		{
			return "EvolvableString:'"+genome.content+"' fitness:"+getFitness();
		}
		
	}
	
}