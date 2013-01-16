package ptolemy.geom3D.unfolding
{
	public interface Iunfolding
	{
		
		function arrangement(i:int):void;
		
		function get proportion():Number;
		function set proportion(n:Number):void;
		
		function get drawCenters():Boolean;
		function set drawCenters(b:Boolean):void;
		
		function get colors():Array;
		function set colors(arr:Array):void;
	}
}