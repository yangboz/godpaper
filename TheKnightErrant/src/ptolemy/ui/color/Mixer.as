package ptolemy.ui.color
{
	public class Mixer
	{
		
		public static function SimpleMix(a:uint, b:uint, values:int = 10, inclusive:Boolean = false):Array
		{
			if (values<0) 
				values = 2;
			else
				values++;
			
			var aR:int = (a&0xFF000000)>>>24;
			var aG:int = (a&0x00FF0000)>>>16;
			var aB:int = (a&0x0000FF00)>>>8;
			var aA:int = (a&0x000000FF);
						
			var dR:int = ((b&0xFF000000)>>>24) - aR;
			var dG:int = ((b&0x00FF0000)>>>16) - aG;
			var dB:int = ((b&0x0000FF00)>>>8) - aB;
			var dA:int = (b&0x000000FF) - aA;
						
			var i:int;
			var c:uint;
			var n:Number;
			var arr:Array = new Array();
			if (inclusive) arr.push(a);
			for (i=1;i<values;i++)
			{
				n = i/values;
				
				c = Math.floor(aR+dR*n);
				c <<= 8;
				c += Math.floor(aG+dG*n);
				c <<= 8;
				c += Math.floor(aB+dB*n);
				c <<= 8;
				c += Math.floor(aA+dA*n);
				arr.push(c);
			}
			if (inclusive) arr.push(b);
			return arr;
		}
		
		public static function SingleMix(a:uint, b:uint, proportion:Number):uint
		{
			if (proportion>1) proportion = 1;
			if (proportion<0) proportion = 0;
			
			var aR:int = (a&0xFF000000)>>>24;
			var aG:int = (a&0x00FF0000)>>>16;
			var aB:int = (a&0x0000FF00)>>>8;
			var aA:int = (a&0x000000FF);
						
			var dR:int = ((b&0xFF000000)>>>24) - aR;
			var dG:int = ((b&0x00FF0000)>>>16) - aG;
			var dB:int = ((b&0x0000FF00)>>>8) - aB;
			var dA:int = (b&0x000000FF) - aA;
			
			var c:uint;
			c = Math.floor(aR+dR*proportion);
			c <<= 8;
			c += Math.floor(aG+dG*proportion);
			c <<= 8;
			c += Math.floor(aB+dB*proportion);
			c <<= 8;
			c += Math.floor(aA+dA*proportion);
			
			return c;
		}
	}
}