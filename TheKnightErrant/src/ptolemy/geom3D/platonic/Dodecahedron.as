package ptolemy.geom3D.platonic
{
	import ptolemy.geom3D.core.Face;
	import ptolemy.geom3D.core.Point;
	
	public class Dodecahedron extends Platonic
	{
		private static const root5:Number = Math.sqrt(5);
		private static const phi:Number = (1 + root5) / 2;
		private static const phibar:Number = (1 - root5) / 2;
			
		public function Dodecahedron(sideLength:int)
		{
			var X:Number = sideLength/(root5-1);
			var Y:Number = X*phi;
			var Z:Number = X*phibar;
			var S:Number = -X;
			var T:Number = -Y;
			var W:Number = -Z;
			
			var a:Point = new Point(X,X,X); // 0	a
			var b:Point = new Point(X,X,S); // 1	b
			var c:Point = new Point(X,S,X); // 2	c
			var d:Point = new Point(X,S,S); // 3	d
			var e:Point = new Point(S,X,X); // 4	e
			var f:Point = new Point(S,X,S); // 5	f
			var g:Point = new Point(S,S,X); // 6	g
			var h:Point = new Point(S,S,S); // 7	h
			var i:Point = new Point(W,Y,0); // 8	i
			var j:Point = new Point(Z,Y,0); // 9	j
			var k:Point = new Point(W,T,0); // 10	k
			var l:Point = new Point(Z,T,0); // 11	l
			var m:Point = new Point(Y,0,W); // 12	m
			var n:Point = new Point(Y,0,Z); // 13	n
			var o:Point = new Point(T,0,W); // 14	o
			var p:Point = new Point(T,0,Z); // 15	p
			var q:Point = new Point(0,W,Y); // 16	q
			var r:Point = new Point(0,Z,Y); // 17	r
			var s:Point = new Point(0,W,T); // 18	s
			var t:Point = new Point(0,Z,T); // 19	t
			
			var A:Face = new Face(b,i,a,m,n);
			var B:Face = new Face(e,j,f,p,o);
			var C:Face = new Face(c,k,d,n,m);
			var D:Face = new Face(h,l,g,o,p);
			var E:Face = new Face(c,m,a,q,r);
			var F:Face = new Face(b,n,d,t,s);
			var G:Face = new Face(e,o,g,r,q);
			var H:Face = new Face(h,p,f,s,t);
			var I:Face = new Face(e,q,a,i,j);
			var J:Face = new Face(c,r,g,l,k);
			var K:Face = new Face(b,s,f,j,i);
			var L:Face = new Face(h,t,d,k,l);
			
			super(sideLength,A,B,C,D,E,F,G,H,I,J,K,L);
		}
	}
}