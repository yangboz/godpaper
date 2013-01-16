package com.suckatmath.machinelearning.markov 
{
	
	/**
	* represents a token in a markov chain
	* @author srs
	*/
	public class TokenEntry 
	{
		/**
		 * content of this token
		 */
		public var data:*;
		
		/**
		 * number of times the token has been seen here
		 */
		private var count:int;
		
		/**
		 * construct a new TokenEntry representing some arbitrary data
		 * @param	d:* data
		 */
		public function TokenEntry(d:*) 
		{
			data = d;
			count = 1;
		}
		
		/**
		 * get number of times the token has been seen in this context
		 */
		public function get weight():int
		{
			return count;
		}
		
		/**
		 * increase weight
		 */
		public function increment():void
		{
			count++;
		}
		
		/**
		 * return a string representation of this token
		 * @return
		 */
		public function toString():String
		{
			return "data: " + data + ", weight: " + count;
		}
		
	}
	
}