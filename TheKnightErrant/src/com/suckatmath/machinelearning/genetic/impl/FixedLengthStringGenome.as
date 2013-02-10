package com.suckatmath.machinelearning.genetic.impl {
	import com.suckatmath.machinelearning.genetic.core.Genome;
	
	/**
	* An entire Genome based on a single backing String
	* @author srs
	*/
	public class FixedLengthStringGenome implements Genome {
		/**
		 * length of backing string
		 */
		public var length:int;
		
		/**
		 * backing string
		 */
		public var content:String;
		
		/**
		 * alphabet of valid letters
		 */
		public var alphabet:String; 
		
		/**
		 * array of functions used to mutate.  only one will be used for a given mutation
		 */
		private var mutateFuncs:Array = [transcriptionError, transcriptionError, shiftForward, shiftBack]; 
		
		/**
		 * create a new FixedLengthStringGenome
		 * @param	l int length
		 * @param	ab String alphabet
		 * @param	c String content - if null, will be random
		 */
		public function FixedLengthStringGenome(l:int = 0, ab:String = "abcdefghijklmnopqrstuvwxyz", c:String = null) {
			length = l;
			alphabet = ab;
			if (c == null) {
				content = makeRandomContent();
			}else {
				content = c.concat();
			}
		}
		
		/**
		 * fill content with random letters from alphabet
		 * @return
		 */
		private function makeRandomContent():String {
			var c:String = "";
			for (var i:int = 0; i < length; i++) {
				c += alphabet.charAt(Math.floor(Math.random() * alphabet.length));
			}
			return c;
		}
		
		/**
		 * return a new FixedLengthStringGenome copy, possibly mutated
		 * @param	probability Number
		 * @return FixedLengthStringGenome as Genome
		 */
		public function mutate(probability:Number):Genome
		{
			var toreturn:FixedLengthStringGenome = this.clone() as FixedLengthStringGenome;
			if (Math.random() < probability)
			{
				//pick a function
				var func:Function = mutateFuncs[Math.floor(Math.random() * mutateFuncs.length)];
				toreturn = func();
			}
			return toreturn;
		}
		
		/**
		 * at arbitrary index, pick arbitary length, copy rest of content forward length chars.
		 * eg: 'abcdefghij' -> 'abcdghijij'
		 *          ^ ^
		 * @param	probability
		 * @return
		 */
		private function shiftForward():Genome
		{
			var idx:int = Math.floor(Math.random() * content.length);
			var extent:int = Math.floor(Math.random() * (content.length - idx)); //int between 0 and however many chars there are after idx
			var toreturn:FixedLengthStringGenome = this.clone() as FixedLengthStringGenome;
			var before:String = toreturn.content.slice(0, idx);
			var dup:String = content.substring(idx + extent);
			var after:String = content.substring(content.length - extent);
			toreturn.content = before + dup + after;
			return toreturn;
		}
		
		/**
		 * at arbitary index, pick arbitrary length, copy first part back length chars.
		 * eg: 'abcdefghij' -> 'ababcdghij'
		 *          ^ ^ 
		 * @param	probability
		 * @return
		 */
		private function shiftBack():Genome
		{
			var idx:int = Math.floor(Math.random() * content.length);
			var extent:int = Math.floor(Math.random() * (idx)); //int between 0 and idx.  how many chars to delete
			var toreturn:FixedLengthStringGenome = this.clone() as FixedLengthStringGenome;
			var before:String = toreturn.content.slice(0, idx - extent); 
			var dup:String = content.substring(0, extent);
			var after:String = content.substring(idx);
			toreturn.content = before + dup + after;
			return toreturn;
		}
		
		/**
		 * returns a mutated copy, with a single letter replaced by a random letter from alphabet
		 * @return FixedLengthStringGenome as Genome
		 */
		private function transcriptionError():Genome {
			var toreturn:FixedLengthStringGenome = this.clone() as FixedLengthStringGenome;
			var before:String;
			var after:String;
			var i:int = Math.floor(Math.random() * length);
					//trace("mutating " + content.charAt(i) + " at " + i);
					//toreturn.content[i] = alphabet.charAt(Math.floor(Math.random() * alphabet.length));
					before = toreturn.content.slice(0, i);
					if (i < content.length - 1){
						after = toreturn.content.slice( i+1, content.length); //should be rest of the string
					}else {
						after = "";
					}
					//trace("before: " + before + ", after: " + after);
					toreturn.content = before + alphabet.charAt(Math.floor(Math.random() * alphabet.length)) + after;
			//trace("this: " + content + ", toreturn: " + toreturn.content);
			return toreturn;
		}
		
		/**
		 * "sexual" reproduction.  Combines this Genome with others by splicing together parts at crossover points
		 * @param	others Array of FixedLengthStringGenome parents
		 * @param	np int number of crossover points
		 * @return FixedLengthStringGenome as Genome
		 */
		public function crossover(others:Array, np:int):Genome {
			var parents:Array;
			if (others.indexOf(this) == -1) {
				parents = others.concat(this);
			}else {
				parents = others;
			}
			var toreturn:FixedLengthStringGenome = this.clone() as FixedLengthStringGenome;
			toreturn.content = "";
			var cps:Array = new Array(np);
			//pick np crossover points.
			for (var j:int = 0; j < np; j++) {
				cps[j] = Math.floor(Math.random() * length);
			}
			cps.sort(Array.NUMERIC);
			//trace("cps: " + cps);
			//at each sort point, pick a parent and use that parent's content
			j = 0;
			var prev:int = -1;
			var pickidx:int = Math.floor(Math.random() * parents.length);
			//trace("pickidx: " + pickidx);
			var p:FixedLengthStringGenome = parents[pickidx];
			for (var i:int = 0; i < length; i++) {
				if (i == cps[j])
				{
					pickidx = Math.floor(Math.random() * parents.length);
					//trace("pickidx: " + pickidx);
					p = parents[pickidx];
					//trace("p: " + p);
					j++;
					while (prev == cps[j]) {
						j++;
						prev = cps[j];
					}
					prev = cps[j];
				}
				toreturn.content += p.content.charAt(i);
			}
			return toreturn;
		}
		
		/**
		 * return a copy of this Genome
		 * @return
		 */
		public function clone():Genome {
			var toreturn:FixedLengthStringGenome = new FixedLengthStringGenome(length, alphabet, content);
			return toreturn;
		}
		
		/**
		 * return a new FixedLengthStringGenome filled with random letters from alphabet
		 * @return
		 */
		public function newRandom():Genome {
			return new FixedLengthStringGenome(length, alphabet);
		}
		
		/**
		 * returns String representation
		 * @return
		 */
		public function toString():String {
			return content;
		}
		
	}
	
}