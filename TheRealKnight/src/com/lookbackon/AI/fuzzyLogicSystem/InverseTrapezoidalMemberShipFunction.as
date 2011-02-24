package com.lookbackon.AI.fuzzyLogicSystem
{
	import com.godpaper.as3.utils.LogUtil;
	
	import mx.logging.ILogger;

	/**
	 * Inverse trapezoidal member ship function.
	 * 
	 * ******e.g.*******
	 * 
	 *  a-----------d 
	 *    \		   /	
	 *     b------c
	 * 
	 * *****e.g.********
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class InverseTrapezoidalMemberShipFunction implements IMemberShipFunction
	{
		private static const LOG:ILogger = LogUtil.getLogger(InverseTrapezoidalMemberShipFunction);
		private var a:Number;
		private var b:Number;
		private var c:Number;
		private var d:Number;
		
		public function InverseTrapezoidalMemberShipFunction(a:Number,b:Number,c:Number,d:Number)
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
			if( value>=a && value<b)
			{
				result = (b - value) / (b - a);
			}
			else if(value>=b && value<=c)
			{
				result = 1.0;
			}else if(value>c && value<=d)
			{
				result = (value - c) / (d - c);
			}else
			{
			    result = 0.0;
			}
//			LOG.debug("current value:{0}||result:{1}",value.toString(),result.toString());
			return result;
		}
	}
}