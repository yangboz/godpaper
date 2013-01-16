package com.lookbackon.AI.fuzzyLogicSystem
{
	/**
	 * Trapezoidal member ship function.
	 * 
	 * *****e.g.*******
	 * 
	 *     b------c     
	 *    /        \
	 *  a-----------d
	 * 
	 * *****e.g.*******
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class TrapezoidalMemberShipFunction implements IMemberShipFunction
	{
		private var a:Number;
		private var b:Number;
		private var c:Number;
		private var d:Number;
		
		public function TrapezoidalMemberShipFunction(a:Number,b:Number,c:Number,d:Number)
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
			else if(value>=b && value<c)
			{
				result = 1.0;
			}else if(value>=c && value<d)
			{
				result = (value - c) / (d - c);
			}
			//			LOG.debug("current value:{0}||result:{1}",value.toString(),result.toString());
			return result;
		}
	}
}