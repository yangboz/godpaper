package ptolemy.geom3D.platonic
{
	import ptolemy.geom3D.core.Point;
	import ptolemy.geom3D.core.Face;
	import ptolemy.geom3D.core.Solid;
	
	public class Tetrahedron extends Solid
	{
		public function Tetrahedron(sideLength:int)
		{
			var X:Number = sideLength/(2*Math.sqrt(2));
			var Y:Number = -X;
			
			var a:Point = new Point(X,X,X);
			var b:Point = new Point(Y,Y,X);
			var c:Point = new Point(Y,X,Y);
			var d:Point = new Point(X,Y,Y);
			
			var A:Face = new Face(a,b,c);
			var B:Face = new Face(a,b,d);
			var C:Face = new Face(a,c,d);
			var D:Face = new Face(b,c,d);
			
			super(A,B,C,D);
		}
	}
}