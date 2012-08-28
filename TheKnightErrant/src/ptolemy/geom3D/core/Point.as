package ptolemy.geom3D.core
{
	import flash.display.Graphics;
	
	public class Point extends Logic
	{
		
		protected var _x:Number; 
		protected var _y:Number;
		protected var _z:Number;
	
		protected var _perspective:Array;
		
		public function Point(x:Number = 0, y:Number = 0, z:Number = 0)
		{
			_x = x;
			_y = y;
			_z = z;
			super();
		}
		
		internal function update(x:Number, y:Number, z:Number):void
		{
			_x = x;
			_y = y;
			_z = z;
			invalidate();
		}
		
		public function get x():Number { return _x; }
		public function set x(n:Number):void
		{
			_x = n;
			invalidate();
		}
		
		public function get y():Number { return _y; }
		public function set y(n:Number):void
		{
			_y = n;
			invalidate();
		}
		
		public function get z():Number { return _z; }
		public function set z(n:Number):void
		{
			_z = n;
			invalidate();
		}
		
		protected override function doCalculation(t:Transformation, e:Eye):void
		{
			var pt:Array;
			
			pt = [_x,_y,_z,1];
			
			_perspective = t.transform(pt);
			_perspective = e.transform(_perspective);
		}
		
		internal function get perspectiveDepth():Number 
		{
			if (_perspective==null) return 0;
			return _perspective[2]; 
		}
		
		public function draw(g:Graphics):Boolean
		{
			if (_invalidated) return false;
			g.moveTo(_perspective[0]-3,_perspective[1]-3);
			g.lineTo(_perspective[0]+3,_perspective[1]+3);
			g.moveTo(_perspective[0]-3,_perspective[1]+3);
			g.lineTo(_perspective[0]+3,_perspective[1]-3);
			//g.drawCircle(_perspective[0],_perspective[1],3);
			return true;
		}
		
		public function moveTo(g:Graphics):Boolean
		{
			if (_invalidated) return false;
			g.moveTo(_perspective[0],_perspective[1]);
			return true;
		}
		
		public function lineTo(g:Graphics):Boolean
		{
			if (_invalidated) return false;
			g.lineTo(_perspective[0],_perspective[1]);
			return true;
		}
		
		public function clone():Point { return new Point(_x,_y,_z); }
		
		public function toString():String
		{
			return "("+x+","+y+","+z+")";
		}
		
		public function debug():String
		{
			if (_perspective==null) return "(undefined)";
			return "("+_perspective[0]+","+_perspective[1]+")";
		}
	}
}