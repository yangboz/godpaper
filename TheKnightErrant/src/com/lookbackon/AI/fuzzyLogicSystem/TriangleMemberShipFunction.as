package com.lookbackon.AI.fuzzyLogicSystem
{
	/**
	 * For instance the "north" lingustic value could have 
     * a Triangular membership function 
     * with parameter a=0°, b=90° and c=180°. 
     * This would mean that a 45° angle 
     * would have a 0.5 Membership to the linguistic value "north". 
     * 
	 * *******e.g.*****
	 * 
	 *        a
	 *      /   \	
	 *     b-----c
	 * 
	 * *****e.g.********
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class TriangleMemberShipFunction implements IMemberShipFunction
	{
		/*private var a:Number;
		private var b:Number;
		private var c:Number;*/
		
		/*public function TriangleMemberShipFunction(a:Number,b:Number,c:Number)
		{
			this.a = a;
			this.b = b;
			this.c = c;
		}
		
		public function memberShipOf(value:Number):Number
		{
			if ((a < value) && (value <= b))
				return (value - a) / (b - a);
			if ((b < value) && (value < c))
				return (c - value) / (c - b);
			return 0;
		}*/
		
		private var leftOffset:Number;
		private var rightOffset:Number;
		private var peakPoint:Number;
		
		public function TriangleMemberShipFunction(leftOffset:Number,b:Number,rightOffset:Number)
		{
			this.leftOffset = leftOffset;
			this.peakPoint = peakPoint;
			this.rightOffset = rightOffset;
		}
		
		public function memberShipOf(value:Number):Number
		{
			//check leftOffset or rightOffset equal to 0;
			if ( ((this.leftOffset==0) && (value == this.peakPoint)) 
				||((this.rightOffset==0) && (value == this.peakPoint))
				)
			{
				return 1.0;
			}
			//check less than peakpoint;
			if( (value<=this.peakPoint) && (value>=(this.peakPoint-this.leftOffset)) )
			{
				var gradLeft:Number = 1.0/this.leftOffset;
				return gradLeft *(value-(this.peakPoint-this.leftOffset));
			}
			//check more than peakpoint;
			else if( (value>this.peakPoint) && (value<(this.peakPoint+this.rightOffset)))
			{
				var gradRight:Number = 1.0/-this.rightOffset;
				return gradRight*(value-this.peakPoint)+1.0;
			}
			//others
			else
			{
				return 0;	
			}
			return 0;
		}
	}
}