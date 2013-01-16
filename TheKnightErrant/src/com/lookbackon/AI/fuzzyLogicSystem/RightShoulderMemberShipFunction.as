package com.lookbackon.AI.fuzzyLogicSystem
{
	import com.godpaper.as3.utils.LogUtil;
	
	import mx.logging.ILogger;

    /**
     * Right shoulder member ship functions
     * 
	 * *******e.g.*****
	 * 
	 *    a------   
	 *   /
	 *  b
	 * 
	 *******e.g.*******
	 * 
     * @author Knight.zhou
     * 
     */    
    public class RightShoulderMemberShipFunction implements IMemberShipFunction
    {
		private static const LOG:ILogger = LogUtil.getLogger(RightShoulderMemberShipFunction);
        private var peakPoint:Number;
        private var leftOffset:Number;
        private var rightOffset:Number;
        private var midPoint:Number;
        
        public function RightShoulderMemberShipFunction(leftOffset:Number,peakPoint:Number,rightOffset:Number)
        {
            this.peakPoint = peakPoint;
            this.leftOffset = leftOffset;
            this.rightOffset = rightOffset;
//            this.midPoint = (leftOffset+rightOffset)/2;
			this.midPoint = peakPoint+rightOffset/2;
        }

        public function memberShipOf(value:Number):Number
        {
            //check offset equal 0;
            if( (this.leftOffset==0) && (value==this.midPoint) ||
				(this.rightOffset==0) && (value==this.midPoint)
			  )
            {
                return 1.0;
            }
            //check value less than peak
            if( (value<=this.peakPoint) && (value>=(this.peakPoint-this.leftOffset)) )
            {
//				LOG.debug("current value:{0}||this.peakPoint-this.leftOffset:{1}",value,(this.peakPoint-this.leftOffset));
                var grad:Number = 1.0/this.leftOffset;
                return grad * (value-(this.peakPoint-this.leftOffset));
            }
            //check value more than peak
            else if( (value>this.peakPoint) && (value<=this.peakPoint+this.rightOffset) )
            {
                return 1.0;
            }
            return 0;
        }
        
    }
}