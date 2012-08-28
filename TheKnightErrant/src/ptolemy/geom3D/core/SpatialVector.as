package ptolemy.geom3D.core
{
	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * 	Vector
	 * 
	 *		defined by (i,j,k) rectangular reference
	 * 		fromTo(Point,Point) returns Vector
	 * 		push(Point,Vector) returns Point
	 * 		crossProduct(Vector,Vector,rightHanded flag) returns Vector
	 * 		add(Vector,Vector), subtract(Vector,Vector) and multiply(Vector,Vector) are transparent!
	 */
	public class SpatialVector extends EventDispatcher
	{
		public static const changed:String = "ChangedEvent";

		private var _i:Number;
		private var _j:Number;
		private var _k:Number;
		private var _magnitude:Number;

		public function SpatialVector(i:Number = 0, j:Number = 0, k:Number = 0)
		{
			this.i = i;
			this.j = j;
			this.k = k;
		}

		public function get i():Number
		{
			return _i;
		}

		public function set i(n:Number):void
		{
			if (_i == n) return;
			_i = n;
			_magnitude = Number.NaN;
			dispatchEvent(new Event(changed));
		}

		public function get j():Number
		{
			return _j;
		}

		public function set j(n:Number):void
		{
			if (_j == n) return;
			_j = n;
			_magnitude = Number.NaN;
			dispatchEvent(new Event(changed));
		}

		public function get k():Number
		{
			return _k;
		}

		public function set k(n:Number):void
		{
			if (_k == n) return;
			_k = n;
			_magnitude = Number.NaN;
			dispatchEvent(new Event(changed));
		}

		public function get magnitude():Number
		{
			if (isNaN(_magnitude))
				_magnitude = Math.sqrt(_i * _i + _j * _j + _k * _k);

			return _magnitude;
		}

		public function set magnitude(n:Number):void
		{
			var m:Number = magnitude;
			if (m == 0 || n == m) return;

			var dn:Number = n / m;

			_i *= dn;
			_j *= dn;
			_k *= dn;
			_magnitude = n;
			dispatchEvent(new Event(changed));
		}

		public static function fromTo(a:Point, b:Point):SpatialVector
		{
			var v:SpatialVector = new SpatialVector(b.x - a.x, b.y - a.y, b.z - a.z);
			return v;
		}

		public static function push(a:Point, by:SpatialVector):Point
		{
			var b:Point = new Point(a.x + by.i, a.y + by.j, a.z + by.k);
			return b;
		}

		public static function crossProduct(a:SpatialVector, b:SpatialVector, rightHanded:Boolean = true):SpatialVector
		{
			var c:SpatialVector;

			if (rightHanded)
				c = new SpatialVector(a.j * b.k - a.k * b.j, a.k * b.i - a.i * b.k, a.i * b.j - a.j * b.i);
			else
				c = new SpatialVector(a.k * b.j - a.j * b.k, a.i * b.k - a.k * b.i, a.j * b.i - a.i * b.j);

			return c;
		}

		public static function dotProduct(a:SpatialVector, b:SpatialVector):Number
		{
			return a.i * b.i + a.j * b.j + a.k * b.k;
		}

		public override function toString():String
		{
			return "[" + i + "," + j + "," + k + "]";
		}

		public static function add(a:SpatialVector, b:SpatialVector):SpatialVector
		{
			return new SpatialVector(a.i + b.i, a.j + b.j, a.k + b.k);
		}

		public static function subtract(a:SpatialVector, b:SpatialVector):SpatialVector
		{
			return new SpatialVector(a.i - b.i, a.j - b.j, a.k - b.k);
		}

		public static function multiply(a:SpatialVector, n:Number):SpatialVector
		{
			return new SpatialVector(a.i * n, a.j * n, a.k * n);
		}

	}
}