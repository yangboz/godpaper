package ptolemy.geom3D.platonic
{
	import ptolemy.geom3D.core.Face;
	import ptolemy.geom3D.core.Point;
	
	public class Icosahedron extends Platonic
	{
		private static const root5:Number = Math.sqrt(5);
		
		public function Icosahedron(sideLength:int)
		{
			var n:Number = sideLength/2;
			var X:Number= n*(1+root5)/2;
			var Y:Number= -X;
			var Z:Number= n;
			var W:Number= -n;
			
			var a:Point = new Point(X,Z,0);
			var b:Point = new Point(Y,Z,0);
			var c:Point = new Point(X,W,0);
			var d:Point = new Point(Y,W,0);
			var e:Point = new Point(Z,0,X);
			var f:Point = new Point(Z,0,Y);
			var g:Point = new Point(W,0,X);
			var h:Point = new Point(W,0,Y);
			var i:Point = new Point(0,X,Z);
			var j:Point = new Point(0,Y,Z);
			var k:Point = new Point(0,X,W);
			var l:Point = new Point(0,Y,W);
			
			var A:Face = new Face(a,i,e);
			var B:Face = new Face(a,f,k);
			var C:Face = new Face(c,e,j);
			var D:Face = new Face(c,l,f);
			var E:Face = new Face(b,g,i);
			var F:Face = new Face(b,k,h);
			var G:Face = new Face(d,j,g);
			var H:Face = new Face(d,h,l);
			var I:Face = new Face(a,k,i);
			var J:Face = new Face(b,i,k);
			var K:Face = new Face(c,j,l);
			var L:Face = new Face(d,l,j);
			var M:Face = new Face(e,c,a);
			var N:Face = new Face(f,a,c);
			var O:Face = new Face(g,b,d);
			var P:Face = new Face(h,d,b);
			var Q:Face = new Face(i,g,e);
			var R:Face = new Face(j,e,g);
			var S:Face = new Face(k,f,h);
			var T:Face = new Face(l,h,f);
			
			super(sideLength,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T);
		}
		
	}
}