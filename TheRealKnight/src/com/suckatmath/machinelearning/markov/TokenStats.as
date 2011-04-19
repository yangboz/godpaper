package com.suckatmath.machinelearning.markov 
{
	import de.polygonal.ds.HashMap;
	
	/**
	* collection of tokens and associated stats and utility methods
	* @author srs
	*/
	public class TokenStats 
	{
		/**
		 * all tokens seen from this point in graph, * -> TokenEntry
		 * 
		 */
		private var tokens:HashMap;
		
		/**
		 * total number of tokens seen from tis point in graph
		 */
		private var total:int;
		
		/**
		 * constructor
		 */
		public function TokenStats() 
		{
			tokens = new HashMap();
			total = 0;
		}
		
		/**
		 * add a token for data.  increments existing TokenEntry if already seen
		 * @param	t:* data
		 */
		public function addToken(t:*):void
		{
			//trace("adding token " + t);
			var tkn:TokenEntry = tokens.find(t);
			if (tkn == null)
			{
				tkn = new TokenEntry(t);
				tokens.insert(t, tkn);
			}else
			{
				tkn.increment();
			}
			total++;
		}
		
		/**
		 * get probability of a token
		 * @param	t:*
		 * @return
		 */
		public function getProbability(t:*):Number
		{
			var tkn:TokenEntry = tokens.find(t);
			if (tkn == null)
			{
				return 0;
			}else
			{
				return tkn.weight / total;
			}
		}
		
		/**
		 * get a random token by weighted random choice.
		 * @return
		 */
		public function getRandomToken():*{
			var tknArray:Array = tokens.toArray();
			if (tknArray.length == 0)
			{
				return null;
			}
			tknArray.sort(compareWeights);
			var n:Number = Math.random()*total; 
			var sum:Number = 0;
			for (var i:int = 0; i < tknArray.length; i++)
			{
				sum += tknArray[i].weight;
				if (sum > n)
				{
					return tknArray[i];
				}
			}
			return null;
		}
		
		/**
		 * compares to TokenEntries by weight
		 * @param	a TokenEntry
		 * @param	b TokenEntry
		 * @return
		 */
		private function compareWeights(a:TokenEntry, b:TokenEntry):int
		{
			return a.weight - b.weight; //backwards?
		}
		
		/**
		 * get a string representation
		 * @return
		 */
		public function toString():String
		{
			return tokens.toArray().toString();
		}
		
	}
	
}