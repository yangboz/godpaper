package com.suckatmath.machinelearning.genetic.impl {
	import com.suckatmath.machinelearning.genetic.core.Gene;
	
	/**
	* Gene consisting of a fixed length String
	* @author Default
	*/
	public class FixedLengthStringGene implements Gene{
		
		/**
		 * how many chars in the string
		 */
		public var length:int;
		
		/**
		 * String to use as a alphabet of valid chars
		 */
		public var alphabet:String; 
		
		/**
		 * contains actual gene info
		 */
		public var content:String; 
		
		/**
		 * create a new FixedLengthStringGene
		 * @param	l int length of Gene
		 * @param	a String alphabet
		 */
		public function FixedLengthStringGene(l:int, a:String) {
			length = l;
			alphabet = a;
			content = new String();
			
			initialize();
		}
		
		/**
		 * fills content with random letters from alphabet
		 */
		private function initialize():void {
			for (var i:int = 0; i < length; i++) {
				content += randomLetter();
			}
		}
		
		/**
		 * get a random letter from alphabet
		 * @return String a single letter
		 */
		private function randomLetter():String {
			return alphabet.charAt(Math.floor(Math.random() * alphabet.length));
		}
		
		/**
		 * implementation of Gene.mutate.  Creates a new FixedLengthStringGene slightly different from this one
		 * @return FixedLengthStringGene
		 */
		public function mutate():Gene {
			var f:FixedLengthStringGene = new FixedLengthStringGene(length, alphabet);
			f.content = this.content.concat(""); //ghetto clone
			var prob:Number = 1 / length; // probability that any one letter will differ
			var p:Number;
			var before:String;
			var after:String;
			for (var i:int = 0; i < length; i++) {
				p = Math.random();
				if (p < prob) {
					before = f.content.slice(0, i);
					if (i < f.content.length - 1){
						after = f.content.slice( i+1, f.content.length); //should be rest of the string
					}else {
						after = "";
					}
					//trace("mutate! " + f.toString()+" before:"+before+" after:"+after);
					f.content = before + randomLetter() + after;
					//trace("f: " + f);
					
				}
			}
			return f;
		}
		
		/**
		 * build a new random FixedLengthStringGene
		 * @return FixedLengthStringGene as Gene
		 */
		public function newRandom():Gene {
			var f:FixedLengthStringGene = new FixedLengthStringGene(length, alphabet);
			return f;
		}
		
		/**
		 * return a String representation.
		 * @return
		 */
		public function toString():String {
			return "(" + content + ")";
		}
	}
	
}