package com.suckatmath.machinelearning.markov 
{
	import de.polygonal.ds.Set;
	import flash.utils.Dictionary;
	
	/**
	* A simple markov chain which tracks distribution from arbitrary k-grams of tokens to the next token.
	* for efficiency, kgrams are implemented as bare arrays
	* 
	* @author srs
	*/
	public class MarkovChain 
	{
		/**
		 * last seen kgram.  initially empty.
		 */
		private	var currentgram:Array;
		
		/**
		 * Object used as associative array from kgram to TokenStats
		 */
		private var graph:Object; //from KGram to TokenStats
		
		/**
		 * size of kgrams.  used in init
		 */
		private var ksize:int; 
		
		/**
		 * set of all kgrams seen
		 */
		private var allGrams:Set;
		
		/**
		 * construct a new Markov Chain
		 * @param	k int size of kgrams
		 * @param	corpus Array of tokens to train on.
		 */
		public function MarkovChain(k:int = 1, corpus:Array = null) 
		{
			graph = new Object();
			allGrams = new Set();
			ksize = k;
			currentgram = new Array();
			if (corpus != null)
			{
				trainFromCorpus(corpus);
			}
		}
		
		/**
		 * setter for kgram size
		 */
		public function set k(ksize:int):void
		{
			ksize = k;
		}
		
		/**
		 * getter for kgram size
		 */
		public function get k():int
		{
			return ksize;
		}
		
		/**
		 * calculates and populates graph from a corpus
		 * subsequent calls will act as if they were part of the same corpus
		 * @param	corpus : Array of Tokens
		 */
		public function trainFromCorpus(corpus:Array):void
		{
			for (var i:int = 0; i < corpus.length; i++)
			{
				//get token, put entry in graph, alter currentgram.
				if (currentgram.length < ksize) //no complete gram yet
				{
					currentgram.push(corpus[i]);
				}else
				{
					var key:String = currentgram.toString();
					if (graph[key] == null)
					{
						//trace("adding stats for key: '" + key + "'");
						graph[key] = new TokenStats();
						allGrams.set(currentgram.concat()); //ghetto clone
						
					}
					TokenStats(graph[key]).addToken(corpus[i]);
					//trace("stats for key: " + graph[key]);
					currentgram.push(corpus[i]);
					currentgram.shift(); //remove first element.
				}
			}
		}
		
		/**
		 * return the probability of the given sequence
		 * @param	tokenSequence
		 * @return probability 0 to 1
		 */
		public function evaluateProb(tokenSequence:Array):Number
		{
			if (tokenSequence.length < ksize)
			{
				throw new ArgumentError("token sequence not long enough.  Must be at least: " + ksize);
			}
			var p:Number = 1;
			var currentgram:Array = new Array();
			var i:int;
			for (i = 0; i < ksize; i++)
			{
				currentgram.push(tokenSequence[i]);
			}
			var stats:TokenStats;
			for (i = ksize; i < tokenSequence.length; i++)
			{
				//get prob of token given current state.
				stats = graph[currentgram.toString()];
				if (stats == null)
				{
					return 0;
				}
				p *= stats.getProbability(tokenSequence[i]);
				currentgram.shift();
				currentgram.push(tokenSequence[i]);
				if (p == 0)
				{
					return 0;
				}
			}
			return p;
		}
		
		/**
		 * returns the sum of each transition's probability.
		 * @param	tokenSequence
		 * @return
		 */
		public function score(tokenSequence:Array):Number
		{
			if (tokenSequence.length < ksize)
			{
				throw new ArgumentError("token sequence not long enough.  Must be at least: " + ksize);
			}
			var p:Number = 0;
			var currentgram:Array = new Array();
			var i:int;
			for (i = 0; i < ksize; i++)
			{
				currentgram.push(tokenSequence[i]);
			}
			var stats:TokenStats;
			for (i = ksize; i < tokenSequence.length; i++)
			{
				//get prob of token given current state.
				stats = graph[currentgram.toString()];
				if (stats != null){
					p += stats.getProbability(tokenSequence[i]);
				}
				currentgram.shift();
				currentgram.push(tokenSequence[i]);
			}
			return p;
		}
		
		/**
		 * generate a sequence of tokens
		 * 
		 * @param max maximum number of tokens to generate
		 * @return Array of tokens.
		 */
		public function generateSequence(max:int = 100):Array
		{
			var toreturn:Array = new Array();
			var cgram:Array = allGrams.toArray()[Math.floor(Math.random() * allGrams.size)]; //pick random kgram
			//trace("generateSequence, random beginning kgram: " + cgram);
			var stats:TokenStats;
			var nextToken:*;
			for (var i:int = 0; i < max; i++)
			{
				stats = graph[cgram.toString()];
				//trace("stats: " + stats);
				if (stats == null)
				{
					return toreturn;
				}
				nextToken = stats.getRandomToken();
				if (nextToken == null)
				{
					return toreturn;
				}
				toreturn.push(nextToken.data);
				cgram.push(nextToken.data);
				cgram.shift();
			}
			return toreturn;
		}
		
	}
	
}