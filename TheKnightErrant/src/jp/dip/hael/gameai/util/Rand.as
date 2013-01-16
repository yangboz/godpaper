package jp.dip.hael.gameai.util
{
	
	public class Rand
	{
		
		/**
		 * (-1.0, 1.0)の浮動小数乱数
		 */
		public static function rand2():Number
		{
			return Math.random()*2.0 - 1.0;
		}
		
		/**
		 * (lower, upper)の浮動小数乱数
		 */
		public static function realRange(lower:Number, upper:Number):Number
		{
//			var range:Number = upper + Math.abs(lower);
//			return Math.random()*range + lower;
			return Math.random()*(upper + Math.abs(lower)) + lower;
		}
		
		/**
		 * [min, max]の整数乱数
		 */
		public static function intRange(min:int, max:int):int
		{
//			var range:Number = max+1 + Math.abs(min);
//			var r:Number = Math.random()*range + min;
//			return Math.floor(r);
			return new int(Math.floor(Math.random()*(max+1 + Math.abs(min)) + min));
		}
		
		/**
		 * [0, length)の整数乱数
		 */
		public static function index(length:int):int
		{
			return new int(Math.floor(Math.random()*length));
		}
	}
}


