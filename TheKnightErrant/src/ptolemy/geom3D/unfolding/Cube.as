package ptolemy.geom3D.unfolding
{
	import ptolemy.Maths;
	import ptolemy.geom3D.core.*;

	import flash.display.Graphics;
	
	public class Cube extends Solid implements Iunfolding
	{
		private var _controller:RegularFace;		// the face which is the center controller
		
		private var _sideLength:int;				// the side length of each pentagon
		private var _prongLength:Number;			// the distance from the center of each pentagon to each of its vertices
		private var _prongComplement:Number;		// the distance from the center of eahc pentagon to the midpoint of each of its edges
		private var _distance:Number;				// the distance from the center of the dodecahedron to the center of each pentagon
		private var _proportion:Number;				// a value between 0 and ±1, where 0 is a net and ±1 is the dodecahedron
		
		private var _angle:Number;					// the dihedral angle that closes the polyhedron when proportion is ±1
		
		private var _B:JoinedFace;
		private var _C:JoinedFace;
		private var _D:JoinedFace;
		private var _E:JoinedFace;
		private var _F:JoinedFace;
		
		public function Cube(sideLength:int, proportion:Number = 1)
		{	
			_angle = Math.PI/2;
			_sideLength = sideLength;
			_prongComplement = sideLength/2;
			_prongLength = Maths.root2*_prongComplement;
			_distance = _prongComplement;
			_proportion = proportion;
			
			_controller = new RegularFace(4,sideLength,0,0,_distance*_proportion);
			
			_B = new JoinedFace(_controller,_controller.points[0],_controller.points[1],4,_angle);
			_C = new JoinedFace(_controller,_controller.points[1],_controller.points[2],4,_angle);
			_D = new JoinedFace(_controller,_controller.points[2],_controller.points[3],4,_angle);
			_E = new JoinedFace(_controller,_controller.points[3],_controller.points[0],4,_angle);
			_F = new JoinedFace(_D,_D.points[2],_D.points[3],4,_angle,true);
			
			super(_controller,_B,_C,_D,_E,_F);
		}
		
			//  B(1)	C(2)	D(3)	E(4)	F(5)
		private static const arrangements:Array = [
			[[0,1,2],[0,2,3],[0,0,1],[0,3,0],[4,0,3]],
			[[0,1,2],[1,2,3],[0,0,1],[0,3,0],[4,0,3]],
			[[0,1,2],[4,2,3],[0,0,1],[0,3,0],[4,0,3]],
			[[0,1,2],[5,2,3],[0,0,1],[0,3,0],[4,0,3]],
			[[0,1,2],[1,2,3],[1,0,1],[0,3,0],[4,0,3]],
			[[0,1,2],[5,2,3],[1,0,1],[0,3,0],[4,0,3]],
			[[3,1,2],[4,2,3],[0,0,1],[0,3,0],[2,0,3]]
		];
		
		public function arrangement(i:int):void
		{
			i = Maths.mod(i,4);
			
			var jf:JoinedFace;
			var n:int;
			var arr:Array;
			
			arr = arrangements[i];
			for (n=0;n<arr.length;n++)
			{
				jf = faces[n+1];
				jf.joinedTo = faces[arr[n][0]] as JoinedFace;
				jf.edgePtA = faces[arr[n][1]];
				jf.edgePtB = faces[arr[n][2]];
				jf.reverse = n!=0;
			}
		}
		
		public function get proportion():Number
		{
			return _proportion;
		}

		public function set proportion(n:Number):void
		{
			if (_proportion == n) return;
			_proportion = n;

			// update the z position of the controller so that the center of rotation is always in the center of the
			// polyhedron
			_controller.z = _distance * _proportion;

			var i:int;
			var dj:JoinedFace;

			n = Math.PI - (Math.PI - _angle) * _proportion;

			// update the dihedral angles which are used to derive the position of the face from its joinedTo face
			for (i = 0;i < faces.length;i++)
			{
				dj = faces[i] as JoinedFace;
				if (dj == null)
					continue;

				dj.dihedral = n;
			}
		}

		private var _drawCenters:Boolean = false;

		public function get drawCenters():Boolean
		{
			return _drawCenters;
		}

		public function set drawCenters(b:Boolean):void
		{
			if (_drawCenters == b) return;
			_drawCenters = b;

			_controller.drawCenter = b;

			var i:int;
			var dj:JoinedFace;

			for (i = 0;i < faces.length;i++)
			{
				dj = faces[i] as JoinedFace;
				if (dj == null) continue;

				dj.drawCenter = b;
			}
		}

		public function doDrawCenters(g:Graphics):void
		{
			g.clear();
			if (!drawCenters)
				return;

			g.endFill();
			g.lineStyle(outlineWidth, outlineColor >>> 8, (outlineColor & 0xFF) / 0xFF);
			_controller.center.draw(g);

			var i:int;
			var dj:JoinedFace;

			for (i = 0;i < faces.length;i++)
			{
				dj = faces[i] as JoinedFace;
				if (dj == null) continue;

				dj.center.draw(g);
			}
		}
		
	}
}