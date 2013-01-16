package ptolemy.geom3D.unfolding
{
	import ptolemy.Maths;
	import ptolemy.geom3D.core.Face;
	import ptolemy.geom3D.core.JoinedFace;
	import ptolemy.geom3D.core.RegularFace;
	import ptolemy.geom3D.core.Solid;
	
	public class Octahedron extends Solid
	{
		private var _sideLength:int;
		private var _prongLength:int;
		private var _dihedralProportion:Number;
		private var _prongComplement:Number;		// the distance from the center of eahc pentagon to the midpoint of each of its edges
		private var _distance:Number;				// the distance from the center of the dodecahedron to the center of each pentagon
		private var _proportion:Number;
		
		private var _controller:RegularFace;
		private var _angle:Number;
		private var _padding:int = 0;
		
		public function Octahedron(sideLength:int, dihedralProportion:Number = 1)
		{
			var cosAngle:Number = -1/3;
			
			/**/
			_angle = Math.acos(cosAngle);
			_sideLength = sideLength;
			_dihedralProportion = dihedralProportion;
			_prongComplement = Maths.sin30*_prongLength;
			_distance = _prongComplement*Math.tan(_angle/2);
			_proportion = proportion;
			
			_controller = new RegularFace(3,sideLength,_angle,dihedralProportion);
			
			var B:Face = new JoinedFace(_controller,_controller.points[0],_controller.points[1],3,_angle);
			var C:Face = new JoinedFace(_controller,_controller.points[1],_controller.points[2],3,_angle);
			var D:Face = new JoinedFace(_controller,_controller.points[2],_controller.points[0],3,_angle);
			
			var E:Face = new JoinedFace(B,B.points[2],B.points[0],3,_angle,true);
			var F:Face = new JoinedFace(C,C.points[2],C.points[0],3,_angle,true);
			var G:Face = new JoinedFace(D,D.points[2],D.points[0],3,_angle,true);
			
			var H:Face = new JoinedFace(G,G.points[2],G.points[0],3,_angle);
			
			super(_controller,B,C,D,E,F,G,H);
			/**/
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
		
		public function get padding():Number { return _padding; }
		public function set padding(n:Number):void
		{
			if (_padding==n) return;
			_padding = n;
			
			var i:int;
			//var dj:Join;
			//var dm:Master;
			
			for (i=0;i<faces.length;i++)
			{
			//	dj = faces[i] as Join;
			//	if (dj!=null) dj.padding = n
			//	
			//	dm = faces[i] as Master;
			//	if (dm!=null) dm.padding = n;
			}
		}
		
	}
}