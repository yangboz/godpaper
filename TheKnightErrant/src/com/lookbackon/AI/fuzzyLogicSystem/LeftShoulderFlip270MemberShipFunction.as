package com.lookbackon.AI.fuzzyLogicSystem
{
    /**
     * Left shoulder flip 270 degree member ship functions
     * 
	 *******e.g.*******
	 * 
	 * a----b
	 * |    |
	 * |    d
	 * |  * 
	 * c     
	 * 
	 *******e.g.*******
	 * 
     * @author Knight.zhou
     * 
     */    
    public class LeftShoulderFlip270MemberShipFunction implements IMemberShipFunction
    {
        private var peakPoint:Number;
        private var upOffset:Number;
        private var downOffset:Number;
        
        public function LeftShoulderFlip270MemberShipFunction(upOffset:Number,peakPoint:Number,downOffset:Number)
        {
            this.peakPoint = peakPoint;
            this.upOffset = upOffset;
            this.downOffset = downOffset;
        }

        public function memberShipOf(value:Number):Number
        {
            //check offset equal 0;
            if( (this.downOffset==0) && (value==this.peakPoint)
				||(this.upOffset==0) && (value==this.peakPoint)  
			  )
            {
                return 1.0;
            }
            //check value more than peak
            if( (value>=this.peakPoint) && (value<=(this.peakPoint+this.upOffset)) )
            {
				return 1.0;
            }
            //check value less than peak
            else if( (value<this.peakPoint) && (value>(this.peakPoint-this.downOffset)))
            {
				var grad:Number = -(1.0/this.downOffset);
				return grad * (value-this.peakPoint)+1.0;
            }
            return 0;
        }
        
    }
}