package come2play_as3.api.auto_copied
{
/**
 * Implementation of the Park Miller (1988) "minimal standard" linear 
 * congruential pseudo-random number generator.
 * 
 * For a full explanation visit: http://www.firstpr.com.au/dsp/rand31/
 * 
 * The generator uses a modulus constant (m) of 2^31 - 1 which is a
 * Mersenne Prime number and a full-period-multiplier of 16807.
 * Output is a 31 bit unsigned integer. The range of values output is
 * 1 to 2,147,483,646 (2^31-1) and the seed must be in this range too.
 * 
 * David G. Carta's optimisation which needs only 32 bit integer math,
 * and no division is actually *slower* in flash (both AS2 & AS3) so
 * it's better to use the double-precision floating point version.
 * 
 * @author Michael Baczynski, www.polygonal.de
 */
	public class RandomGenerator
	{
		/**
		 * set seed with a 31 bit unsigned integer
		 * between 1 and 0X7FFFFFFE inclusive. don't use 0!
		 */
		private var seed:uint;
		public function RandomGenerator(seed:uint) {
			if (seed==0) throw new Error("Do not use a seed of 0!");
			this.seed = seed;
		}
		
		/**
		 * generator:
		 * new-value = (old-value * 16807) mod (2^31 - 1)
		 */
		private function nextUint():uint {
			return seed = (seed * 16807) % 2147483647;			
		}
		public function nextInt():int {
			return int(nextUint());
		}
		public function nextInRange(fromInclusive:int, toExclusive:int):int {
			var delta:int = toExclusive - fromInclusive;
			if (delta<=0) throw new Error("toExclusive must be bigger than fromInclusive!");
			var rand:int = Math.abs( nextUint() % delta );
			return rand + fromInclusive;
		}
	}
}