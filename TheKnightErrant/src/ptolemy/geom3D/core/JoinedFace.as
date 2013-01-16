package ptolemy.geom3D.core
{
	import ptolemy.Maths;

	import flash.display.Graphics;

	public class JoinedFace extends Face
	{
		private var _joinedTo:Face;
		private var _edgePtA:Point;
		private var _edgePtB:Point;
		private var _reverse:Boolean;

		private var _sides:int;
		private var _dihedral:Number;

		private var _center:Point;

		private var _padding:Number = 1;
		private var _padded:Array;
		private var _transformation:Transformation;

		public var drawCenter:Boolean = false;

		public function JoinedFace(joinedTo:Face, edgePtA:Point, edgePtB:Point, sides:int, dihedral:Number = 0, reverse:Boolean = false)
		{
			_joinedTo = joinedTo;
			_edgePtA = edgePtA;
			_edgePtB = edgePtB;
			_reverse = reverse;

			_sides = sides;
			_dihedral = dihedral;

			_center = new Point();

			_padding = 1;

			_edgePtA.addChild(this);
			_edgePtB.addChild(this);

			_points = new Array();
			var i:int;
			for (i = 0;i < _sides;i++)
			{
				_points.push(new Vertex());
			}
			_children = _points;
		}

		public function get center():Point
		{
			return _center;
		}

		public function get joinedTo():Face
		{
			return _joinedTo;
		}

		public function set joinedTo(f:Face):void
		{
			if (_joinedTo == f) return;
			_joinedTo = f;
			invalidate();
		}

		public function get edgePtA():Point
		{
			return _edgePtA;
		}

		public function set edgePtA(p:Point):void
		{
			if (_joinedTo == null) p = null;
			if (_edgePtA == p) return;

			if (_joinedTo != null)
			{
				if (_joinedTo.points.indexOf(p) == -1)
					p = null;
			}

			if (_edgePtA != null)
				_edgePtA.removeChild(this);

			_edgePtA = p;

			if (_edgePtA != null)
				_edgePtA.addChild(this);

			invalidate();
		}

		public function get edgePtB():Point
		{
			return _edgePtB;
		}

		public function set edgePtB(p:Point):void
		{
			if (_joinedTo == null) p = null;
			if (_edgePtB == p) return;

			if (_joinedTo != null)
			{
				if (_joinedTo.points.indexOf(p) == -1)
					p = null;
			}

			if (_edgePtB != null)
				_edgePtB.removeChild(this);

			_edgePtB = p;

			if (_edgePtB != null)
				_edgePtB.addChild(this);

			invalidate();
		}

		public function get reverse():Boolean
		{
			return _reverse;
		}

		public function set reverse(b:Boolean):void
		{
			if (_reverse == b) return;
			_reverse = b;
			invalidate();
		}

		public function get dihedral():Number
		{
			return _dihedral;
		}

		public function set dihedral(n:Number):void
		{
			if (_dihedral == n) return;
			_dihedral = n;
			invalidate();
		}

		protected override function doCalculation(t:Transformation, e:Eye):void
		{
			var v:SpatialVector;
			var i:int;
			var j:int;
			var arr:Array;
			var p:Vertex;
			var q:Point;

			j = _joinedTo.points.indexOf(_edgePtA);
			v = SpatialVector.fromTo(_edgePtA, _edgePtB);
			_transformation = Transformation.about(v, _dihedral * (_reverse ? -1 : 1));

			_center.update(0, 0, 0);
			for (i = 0;i < _sides;i++)
			{
				q = _joinedTo.points[Maths.mod(i + j, _joinedTo.points.length)];
				arr = [q.x - _edgePtA.x, q.y - _edgePtA.y, q.z - _edgePtA.z, 1];

				arr = _transformation.transform(arr);
				p = _points[i] as Vertex;
				p.update(arr[0] + _edgePtA.x, arr[1] + _edgePtA.y, arr[2] + _edgePtA.z);

				_center.x += p.x;
				_center.y += p.y;
				_center.z += p.z;
			}
			_center.x /= _sides;
			_center.y /= _sides;
			_center.z /= _sides;

			doPaddingCalculation(t, e);
		}

		public override function calculate(t:Transformation, e:Eye):void
		{
			if (_edgePtA == null || _edgePtB == null) return;
			if (_edgePtA.isInvalidated || _edgePtB.isInvalidated) return;

			super.calculate(t, e);
			_center.calculate(t, e);
			paddingCalculate(t, e);
		}

		public override function draw(g:Graphics):void
		{
			if (_padding != 1)
				doPaddingDraw(g);
			else
				super.draw(g);
		}

		public override function toString():String
		{
			return "j" + super.toString();
		}

		/**
		 *		padding 
		 * 
		 */

		public function get padding():Number
		{
			return _padding;
		}

		public function set padding(n:Number):void
		{
			if (_padding == n) return;
			_padding = n;
			initialisePadding();
			invalidate();
		}

		private function initialisePadding():void
		{
			if (_padding == 1)
			{
				_padded = null;
				return;
			}

			var i:int;
			_padded = new Array();
			for (i = 0;i < _sides;i++)
			{
				_padded[i] = new Vertex();
			}
		}

		protected function doPaddingCalculation(t:Transformation, e:Eye):void
		{
			if (_padding == 1) return;

			var i:int;
			var v:Vertex;
			var w:Vertex;
			var arr:Array;

			for (i = 0;i < _padded.length;i++)
			{
				v = _points[i] as Vertex;
				w = _padded[i] as Vertex;

				arr = [v.x + (_center.x - v.x) * _padding, v.y + (_center.y - v.y) * _padding, v.z + (_center.z - v.z) * _padding, 1];

				// arr = _transformation.transform(arr);
				w.update(arr[0], arr[1], arr[2]);
			}
		}

		protected function paddingCalculate(t:Transformation, e:Eye):void
		{
			if (_padding == 1) return;

			var l:Logic;
			for each (l in _padded)
			{
				l.calculate(t, e);
			}
		}

		protected function doPaddingDraw(g:Graphics):void
		{
			var i:int;
			var p:Point;

			p = _padded[_padded.length - 1] as Point;

			g.beginFill(_fillColor >>> 8, (_fillColor & 0xFF) / 0xFF);
			if (_outlineWidth >= 0)
				g.lineStyle(_outlineWidth, _outlineColor >>> 8, (_outlineColor & 0xFF) / 0xFF);
			else
				g.lineStyle();

			p.moveTo(g);
			for (i = 0;i < _padded.length;i++)
			{
				p = _padded[i] as Point;
				p.lineTo(g);
			}

			g.endFill();


		}

	}
}