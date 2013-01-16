package ptolemy.geom3D.unfolding
{
	import ptolemy.geom3D.core.Face;
	import ptolemy.geom3D.core.JoinedFace;
	import ptolemy.geom3D.core.RegularFace;
	import ptolemy.geom3D.core.Solid;
	
	public class Dodecahedron extends Solid
	{
		private var _controller:RegularFace;		// the face which is the center controller
		
		private var _sideLength:int;				// the side length of each pentagon
		private var _prongLength:Number;			// the distance from the center of each pentagon to each of its vertices
		private var _prongComplement:Number;		// the distance from the center of eahc pentagon to the midpoint of each of its edges
		private var _distance:Number;				// the distance from the center of the dodecahedron to the center of each pentagon
		private var _proportion:Number;				// a value between 0 and ±1, where 0 is a net and ±1 is the dodecahedron
		
		private var _angle:Number;					// the dihedral angle that closes the polyhedron when proportion is ±1
		
		public function Dodecahedron(sideLength:int, proportion:Number = 1)
		{
			var cos108:Number = Math.cos(3*Math.PI/5);
			var mSquared:Number = 2*(1-cos108);
			var xSquared:Number = (3-2*cos108)/4;
			var cosAngle:Number = 1-(mSquared/(2*xSquared));
			
			_angle = Math.acos(cosAngle);
			_sideLength = sideLength;
			_prongLength = _sideLength/(2*Math.sin(Math.PI/5));
			_prongComplement = Math.sqrt(_prongLength*_prongLength - (_sideLength*_sideLength)/4);
			_distance = _prongComplement*Math.tan(_angle/2);
			_proportion = proportion;
			
			_controller = new RegularFace(5,sideLength,0,0,_distance*_proportion);
			
			var B:Face = new JoinedFace(_controller,_controller.points[0],_controller.points[1],5,_angle);
			var C:Face = new JoinedFace(_controller,_controller.points[1],_controller.points[2],5,_angle);
			var D:Face = new JoinedFace(_controller,_controller.points[2],_controller.points[3],5,_angle);
			var E:Face = new JoinedFace(_controller,_controller.points[3],_controller.points[4],5,_angle);
			var F:Face = new JoinedFace(_controller,_controller.points[4],_controller.points[0],5,_angle);
			var G:Face = new JoinedFace(B,B.points[2],B.points[3],5,_angle,true);
			var H:Face = new JoinedFace(C,C.points[2],C.points[3],5,_angle,true);
			var I:Face = new JoinedFace(D,D.points[2],D.points[3],5,_angle,true);
			var J:Face = new JoinedFace(E,E.points[2],E.points[3],5,_angle,true);
			var K:Face = new JoinedFace(F,F.points[2],F.points[3],5,_angle,true);
			var L:Face = new JoinedFace(I,I.points[2],I.points[3],5,_angle);
			
			super(_controller,B,C,D,E,F,G,H,I,J,K,L);
		}
		
		public function get proportion():Number { return _proportion; }
		public function set proportion(n:Number):void
		{
			if (_proportion==n) return;
			_proportion = n;
			
			// update the z position of the controller so that the center of rotation is always in the center of the
			// polyhedron
			_controller.z = _distance*_proportion;
			
			var i:int;
			var dj:JoinedFace;
			
			n = Math.PI - (Math.PI - _angle)*_proportion;
			
			//	update the dihedral angles which are used to derive the position of the face from its joinedTo face
			for (i=0;i<faces.length;i++)
			{
				dj = faces[i] as JoinedFace;
				if (dj==null) continue;
				
				dj.dihedral = n;
			}
		}
	}
}