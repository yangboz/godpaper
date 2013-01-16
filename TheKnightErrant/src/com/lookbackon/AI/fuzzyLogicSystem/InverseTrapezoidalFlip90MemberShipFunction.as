package com.lookbackon.AI.fuzzyLogicSystem
{
	import com.godpaper.as3.utils.LogUtil;
	
	import mx.logging.ILogger;

	/**
	 * Inverse trapezoidal member ship function.
	 * 
	 * ******e.g.*******
	 * 
	 *     b
	 *    /|
	 *   / |
	 * a   |
	 * |   |
	 * |   |
	 * c   |
	 *   \ |
	 *    \|
	 *     d
	 * 
	 * *****e.g.********
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class InverseTrapezoidalFlip90MemberShipFunction implements IMemberShipFunction
	{
		private static const LOG:ILogger = LogUtil.getLogger(InverseTrapezoidalMemberShipFunction);
		private var a:Number;
		private var b:Number;
		private var c:Number;
		private var d:Number;
		
		public function InverseTrapezoidalFlip90MemberShipFunction(a:Number,b:Number,c:Number,d:Number)
		{
			this.a = a;
			this.b = b;
			this.c = c;
			this.d = d;
		}
		
		public function memberShipOf(value:Number):Number
		{
			var result:Number=0;
			
			if( ((a==b)&&(value==a))
				|| ((c==d)&&(value==c))
			)
			{
				result = 1.0;
			}
			if( value>a && value<=b)
			{
				result = (b - value) / (b - a);
			}
			else if(value>c && value<=a)
			{
				result = 1.0;
			}else if(value>d && value<=c)
			{
				result = (value - d) / (c - d);
			}else
			{
			    result = 0;
			}
//			LOG.debug("current value:{0}||result:{1}",value.toString(),result.toString());
			return result;
		}
	}
}