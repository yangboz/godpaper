package com.suckatmath.machinelearning.genetic.impl {
	import com.suckatmath.machinelearning.genetic.core.Evolvable;
	import com.suckatmath.machinelearning.genetic.core.Genome;
	
	/**
	* Factory to create EvolvableStrings
	* @author srs
	*/
	public class EvolvableStringFactory extends AbstractEvolvableFactory{

		/**
		 * create a new EvolvableStringFactory
		 */
		public function EvolvableStringFactory() {
			super(null);
			//exampleGenome = new FixedLengthStringGenome(EvolvableString.goal.length, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ., ");
			//exampleGenome = new FixedLengthStringGenome(EvolvableString.goal.length, getAlphabetFromString(EvolvableString.goal));
			exampleGenome = new FixedLengthStringGenome(EvolvableString.goal.length, EvolvableString.goal);
		}
		
		/**
		 * get string with only unique letters from input.
		 * @param	st
		 * @return String
		 */
		private function getAlphabetFromString(st:String):String
		{
			var toreturn:String = "";
			for (var i:int = 0; i < st.length; i++)
			{
				if (toreturn.indexOf(st.charAt(i)) == -1)
				{
					toreturn += st.charAt(i);
				}
			}
			return toreturn;
		}
		
		/**
		 * builds an EvolvableString from a FixedLengthStringGenome
		 * @param	g FixedLengthStringGenome as Genome
		 * @return EvolvableString as Evolvable
		 */
		public override function buildEvolvable(g:Genome):Evolvable {
			var toreturn:EvolvableString = new EvolvableString();
			toreturn.setGenome(g);
			return toreturn;
		}
		
	}
	
}