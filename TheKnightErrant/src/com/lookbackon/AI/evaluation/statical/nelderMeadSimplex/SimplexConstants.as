package com.lookbackon.AI.evaluation.statical.nelderMeadSimplex
{
	/**
	 *
	 * @see  http://code.google.com/p/nelder-mead-simplex/
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class SimplexConstants
	{
		private var _value:Number;
		private var _initialPerturbation:Number;

		public function SimplexConstants(value:Number, initialPerturbation:Number)
		{
			_value = value;
			_initialPerturbation = initialPerturbation;
		}
		/// <summary>
		/// The value of the constant
		/// </summary>
		public function get value():Number
		{
			return _value;
		}
		public function set value(value:Number):void
		{
			_value = value;
		}
		// The size of the initial perturbation
		public function get initialPerturbation():Number
		{
			return _initialPerturbation;
		}
		public function set initialPerturbation(value:Number):void
		{
			_initialPerturbation = value;
		}
	}
}
