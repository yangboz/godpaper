package ptolemy.geom3D.core
{
	import flash.display.Graphics;

	public class Face extends Logic
	{
		protected var _points:Array;

		private var _perspectiveDepth:Number;

		protected var _outlineWidth:int = 0;
		protected var _outlineColor:uint = 0x000000FF;
		protected var _fillColor:uint = 0xFF000099;

		public function Face(... points)
		{
			if (points.length == 1 && points[0] is Array)
				_points = points[0];
			else
				_points = points;

			_children = _points.concat();
		}

		public function get points():Array
		{
			return _points;
		}

		protected override function doPostChildrenCalculation():void
		{
			var p:Point;

			_perspectiveDepth = 0;
			for each (p in _points)
			{
				_perspectiveDepth += p.perspectiveDepth;
			}
			_perspectiveDepth /= _points.length;
		}

		internal function get perspectiveDepth():Number
		{
			return _perspectiveDepth;
		}

		public function get outlineWidth():int
		{
			return _outlineWidth;
		}

		public function set outlineWidth(i:int):void
		{
			if (_outlineWidth == i) return;
			_outlineWidth = i;
			invalidate();
		}

		public function get outlineColor():uint
		{
			return _outlineColor;
		}

		public function set outlineColor(u:uint):void
		{
			if (_outlineColor == u) return;
			_outlineColor = u;
			invalidate();
		}

		public function get fillColor():uint
		{
			return _fillColor;
		}

		public function set fillColor(u:uint):void
		{
			if (_fillColor == u) return;
			_fillColor = u;
			invalidate();
		}

		public function get alpha():Number
		{
			return (_fillColor & 0xFF) / 0xFF;
		}

		public function set alpha(n:Number):void
		{
			_fillColor = (_fillColor & 0xFFFFFF00) | Math.floor(n * 0xFF);
			invalidate();
		}

		public function draw(g:Graphics):void
		{
			var i:int;
			var p:Point;

			p = _points[_points.length - 1] as Point;

			g.beginFill(_fillColor >>> 8, (_fillColor & 0xFF) / 0xFF);
			if (_outlineWidth >= 0)
				g.lineStyle(_outlineWidth, _outlineColor >>> 8, (_outlineColor & 0xFF) / 0xFF);
			else
				g.lineStyle();

			p.moveTo(g);
			for (i = 0;i < _points.length;i++)
			{
				p = _points[i] as Point;
				p.lineTo(g);
			}

			g.endFill();
		}

		public function toString():String
		{
			return "face[" + _points.join(" -> ") + "\n]";
		}

	}
}