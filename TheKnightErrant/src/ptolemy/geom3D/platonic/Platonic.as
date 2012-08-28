package ptolemy.geom3D.platonic
{
	import ptolemy.geom3D.core.Solid;

	public class Platonic extends Solid
	{
		protected var _sideLength:int;
		protected var _padding:Number;

		public function Platonic(sideLength:int, ... faces)
		{
			_sideLength = sideLength;
			_padding = 0;
			super(faces);
		}

		public function get sideLength():int
		{
			return _sideLength;
		}

		public function set sideLength(i:int):void
		{
			// if (_sideLength==i) return;
			// _sideLength = i;
		
			// update(faces);
		}

		protected function update(arr:Array):Array
		{
			return null;
		}

		public function get padding():Number
		{
			return _padding;
		}

		public function set padding(n:Number):void
		{
			if (_padding == n) return;
			_padding = n;

			var i:int;
			for (i = 0;i < faces.length;i++)
			{
				faces[i].padding = n;
			}
		}



	}
}