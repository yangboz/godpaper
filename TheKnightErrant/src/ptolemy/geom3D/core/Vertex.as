package ptolemy.geom3D.core
{
	public class Vertex extends Point
	{
		public function Vertex()
		{
			super();
		}
		
		// disable setting of x,y and z directly - will be done through internal update mechamism
		
		public override function set x(n:Number):void {}
		public override function set y(n:Number):void {}
		public override function set z(n:Number):void {}
		
	}
}