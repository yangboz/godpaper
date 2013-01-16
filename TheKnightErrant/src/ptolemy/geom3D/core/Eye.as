package ptolemy.geom3D.core
{
	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * 
	 * 	Eye defines the observer, who looks from (x,y,z) in the direction of lookAt Vector, with theta representing the breadth of view angle
	 * 	
	 * 
	 */
	public class Eye extends EventDispatcher
	{
		public static const changed:String = "ChangedEvent";

		private var _x:Number = 0;
		private var _y:Number = 0;
		private var _z:Number;
		private var _lookat:SpatialVector;
		private var _width:Number = 800;
		private var _height:Number = 600;
		private var _theta:Number = Math.PI / 6;

		private var _distance:Number;
		private var _transformation:Transformation;

		public function Eye()
		{
			_lookat = new SpatialVector(0, 0, 1);
			_lookat.addEventListener(SpatialVector.changed, onVectorChanged);

			_distance = calculateDistance();
			_z = -_distance;
		}

		public function get x():Number
		{
			return _x;
		}

		public function set x(n:Number):void
		{
			if (_x == n) return;
			_x = n;
			invalidate();
		}

		public function get y():Number
		{
			return _y;
		}

		public function set y(n:Number):void
		{
			if (_y == n) return;
			_y = n;
			invalidate();
		}

		public function get z():Number
		{
			return _z;
		}

		public function set z(n:Number):void
		{
			if (_z == n) return;
			_z = n;
			invalidate();
		}


		public function get lookat():SpatialVector
		{
			return _lookat;
		}

		public function set lookat(n:SpatialVector):void
		{
			if (_lookat == n || n == null) return;
			_lookat.removeEventListener(SpatialVector.changed, onVectorChanged);
			_lookat = n;
			_lookat.addEventListener(SpatialVector.changed, onVectorChanged);
			invalidate();
		}

		public function get width():Number
		{
			return _width;
		}

		public function set width(n:Number):void
		{
			if (_width == n) return;
			_width = n;
			invalidate();
		}

		public function get height():Number
		{
			return _height;
		}

		public function set height(n:Number):void
		{
			if (_height == n) return;
			_height = n;
			invalidate();
		}

		public function get theta():Number
		{
			return _theta;
		}

		public function set theta(n:Number):void
		{
			if (_theta == n) return;
			_theta = n;
			invalidate();
		}

		private function onVectorChanged(e:Event):void
		{
			invalidate();
		}

		private function calculateDistance():Number
		{
			return width / (2 * Math.tan(theta));
		}

		private function invalidate():void
		{
			_transformation = null;
			dispatchEvent(new Event(changed));
		}

		// get [x,y,z,w] and return [_sx,_sy,_depth] for Point
		internal function transform(arr:Array):Array
		{
			if (_transformation == null)
				_transformation = priorTransformation();

			if (isNaN(_distance))
				_distance = calculateDistance();

			arr = _transformation.transform(arr);

			var sx:Number;
			var sy:Number;
			var depth:Number;

			sx = (_width / 2) + (_distance * arr[0] / arr[2]);
			sy = (_height / 2) + (_distance * arr[1] / arr[2]);
			depth = arr[2];

			return [sx, sy, depth];
		}

		private function priorTransformation():Transformation
		{
			var t:Transformation = Transformation.about(new SpatialVector(0, 1, 0), Math.atan2(_lookat.i, _lookat.k));
			var u:Transformation = Transformation.about(new SpatialVector(1, 0, 0), Math.atan2(_lookat.j, _lookat.k));
			var v:Transformation = Transformation.translate(x, y, z);
			return Transformation.combine(v, Transformation.combine(t, u));
		}


	}
}