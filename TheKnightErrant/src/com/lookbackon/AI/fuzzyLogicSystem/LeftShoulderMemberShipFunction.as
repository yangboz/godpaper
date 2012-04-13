package com.lookbackon.AI.fuzzyLogicSystem
{
    /**
     * Left shoulder member ship functions
     * 
	 *******e.g.*******
	 * 
	 * -------a 
	 *         \
	 * 			b
	 * 
	 *******e.g.*******
	 * 
     * @author Knight.zhou
     * 
     */    
    public class LeftShoulderMemberShipFunction implements IMemberShipFunction
    {
        private var peakPoint:Number;
        private var leftOffset:Number;
        private var rightOffset:Number;
//        private var midPoint:Number;
        
        public function LeftShoulderMemberShipFunction(leftOffset:Number,peakPoint:Number,rightOffset:Number)
        {
            this.peakPoint = peakPoint;
            this.leftOffset = leftOffset;
            this.rightOffset = rightOffset;
//            this.midPoint = (leftOffset+rightOffset)/2;
//			this.midPoint = peakPoint-leftOffset/2;
        }

        public function memberShipOf(value:Number):Number
        {
            //check offset equal 0;
            if( (this.rightOffset==0) && (value==this.peakPoint)
				||(this.leftOffset==0) && (value==this.peakPoint)  
			  )
            {
                return 1.0;
            }
            //check value more than peak
            if( (value>=this.peakPoint) && (value<=(this.peakPoint+this.rightOffset)) )
            {
                var grad:Number = -(1.0/this.rightOffset);
                return grad * (value-this.peakPoint)+1.0;
            }
            //check value less than peak
            else if( (value<this.peakPoint) && (value>=(this.peakPoint-this.leftOffset)))
            {
                return 1.0;
            }
            return 0;
        }
        
    }
}