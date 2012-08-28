package ptolemy.geom3D.platonic
{
	import ptolemy.geom3D.core.Face;
	import ptolemy.geom3D.core.Point;

	public class Octahedron extends Platonic
	{
		public function Octahedron(sideLength:int)
		{
			var X:Number = sideLength / Math.sqrt(2);
			var Y:Number = -X;

			var a:Point = new Point(X, 0, 0);
			var b:Point = new Point(0, X, 0);
			var c:Point = new Point(0, 0, X);
			var d:Point = new Point(Y, 0, 0);
			var e:Point = new Point(0, Y, 0);
			var f:Point = new Point(0, 0, Y);

			var A:Face = new Face(b, a, c);
			var B:Face = new Face(b, a, f);
			var C:Face = new Face(b, c, d);
			var D:Face = new Face(b, d, f);
			var E:Face = new Face(e, f, d);
			var F:Face = new Face(e, f, a);
			var G:Face = new Face(e, c, a);
			var H:Face = new Face(e, c, d);

			super(sideLength, A, B, C, D, E, F, G, H);
		}
	}
}