package ptolemy.geom3D.platonic
{
	import ptolemy.geom3D.core.Point;
	import ptolemy.geom3D.core.Face;
	import ptolemy.geom3D.core.Solid;
	
	public class Cube extends Solid
	{
		public function Cube(sideLength:int)
		{
			var X:Number = 0.5*sideLength;
			var Y:Number = -0.5*sideLength;
			
			var a:Point = new Point(Y,Y,Y);
			var b:Point = new Point(X,Y,Y);
			var c:Point = new Point(Y,X,Y);
			var d:Point = new Point(Y,Y,X);
			var e:Point = new Point(X,X,Y);
			var f:Point = new Point(X,Y,X);
			var g:Point = new Point(Y,X,X);
			var h:Point = new Point(X,X,X);
			
			var A:Face = new Face(a,b,e,c);
			var B:Face = new Face(a,b,f,d);
			var C:Face = new Face(a,c,g,d);
			var D:Face = new Face(h,f,d,g);
			var E:Face = new Face(h,e,b,f);
			var F:Face = new Face(h,e,c,g);
			
			super(A,B,C,D,E,F);
		}
	}
}