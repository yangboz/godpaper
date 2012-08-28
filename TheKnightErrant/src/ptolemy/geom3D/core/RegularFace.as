package ptolemy.geom3D.core
{
	import flash.display.Graphics;
	import flash.events.Event;
	
	public class RegularFace extends Face
	{
		private var _sides:int;
		private var _length:Number;
		
		private var _radius:Number;
		private var _dAngle:Number;
		
		private var _about:SpatialVector;
		private var _angle:Number;
		
		private var _center:Point;
		
		private var _padding:Number = 1;
		private var _padded:Array;
		private var _transformation:Transformation;
		
		public var drawCenter:Boolean = false;
		
		public function RegularFace(sides:int, length:Number, x:Number = 0, y:Number = 0, z:Number = 0)
		{
			_sides = sides;
			_length = length;
			
			_dAngle = 2*Math.PI/sides;
			_radius = length/(2*Math.sin(_dAngle/2));
			
			_center = new Point(x,y,z);
			
			_about = new SpatialVector(0,1,0);
			_angle = 0;
			
			_points = new Array();
			var i:int;
			for (i=0;i<_sides;i++) { _points.push(new Vertex()); }
			_children = _points;
		}
		
		public function get center():Point { return _center; }
		
		protected override function doCalculation(t:Transformation, e:Eye):void
		{
			var i:int;
			var p:Vertex;
			var arr:Array;
			
			// setup transformation matrix
			_transformation = Transformation.about(_about,_angle);
			
			if (t!=null)		
				t = Transformation.combine(_transformation,t);
			else
				t = _transformation;
				
			// work out all the positions
			for (i=0;i<_sides;i++)
			{
				p = _points[i] as Vertex;
				
				arr = [_center.x + _radius*Math.cos(_dAngle*i),_center.y + _radius*Math.sin(_dAngle*i),_center.z,1];
				arr = _transformation.transform(arr);
				p.update(arr[0],arr[1],arr[2]);
			}
			
			doPaddingCalculation(t,e);
		}
		
		public override function calculate(t:Transformation, e:Eye):void
		{
			super.calculate(t,e);
			paddingCalculate(t,e);
			
			if (drawCenter) _center.calculate(t,e);
		}
		
		public function get sides():int { return _sides; }
		public function set sides(i:int):void
		{
			if (_sides==i) return;
			_sides = i;
			_dAngle = 2*Math.PI/sides;
			_radius = length/(2*Math.sin(_dAngle/2));
			invalidate();
		}
		
		public function get length():Number { return _length; }
		public function set length(n:Number):void
		{
			if (_length==n) return;
			_length = n;
			_dAngle = 2*Math.PI/sides;
			_radius = length/(2*Math.sin(_dAngle/2));
			invalidate();
		}
		
		public function get about():SpatialVector { return _about; }
		public function set about(v:SpatialVector):void
		{
			if (v==null || v==_about) return;
			_about.removeEventListener(SpatialVector.changed,onAboutChanged);
			_about = v;
			_about.addEventListener(SpatialVector.changed,onAboutChanged);
			invalidate();  
		}
		private function onAboutChanged(e:Event):void { invalidate(); }
		
		public function get angle():Number { return _angle; }
		public function set angle(n:Number):void
		{
			if (_angle==n) return;
			_angle = n;
			invalidate();
		}
		
		public function get x():Number { return _center.x; }
		public function set x(n:Number):void
		{
			if (_center.x==n) return;
			_center.x = n;
			invalidate();
		}
		
		public function get y():Number { return _center.y; }
		public function set y(n:Number):void
		{
			if (_center.y==n) return;
			_center.y = n;
			invalidate();
		}
		
		public function get z():Number { return _center.z; }
		public function set z(n:Number):void
		{
			if (_center.z==n) return;
			_center.z = n;
			invalidate();
		}
		
		public override function draw(g:Graphics):void
		{
			if (_padding==1)
				super.draw(g);
			else
				doPaddingDraw(g);
		}
		
		public override function toString():String { return "r"+super.toString(); }
		
		/**
		 *		padding 
		 * 
		 */
		 
		public function get padding():Number { return _padding; }
		public function set padding(n:Number):void
		{
			if (_padding==n) return;
			_padding = n;
			initialisePadding();
			invalidate();
		}
		
		private function initialisePadding():void
		{
			if (_padding==1)
			{
				_padded = null;
				return;
			}
			
			var i:int;
			_padded = new Array();
			for (i=0;i<_sides;i++)
			{
				_padded[i] = new Vertex();
			}
		}
		
		protected function doPaddingCalculation(t:Transformation, e:Eye):void
		{
			if (_padding==1) return;
				
			var i:int;
			var v:Vertex;
			var w:Vertex;
			var arr:Array;
			
			for (i=0;i<_padded.length;i++)
			{
				v = _points[i] as Vertex;
				w = _padded[i] as Vertex;
				
				arr = [
						v.x + (_center.x-v.x)*_padding,
						v.y + (_center.y-v.y)*_padding,
						v.z + (_center.z-v.z)*_padding,
						1
					  ];
				
				arr = _transformation.transform(arr);
				w.update(arr[0],arr[1],arr[2]);
			}
		}
		
		protected function paddingCalculate(t:Transformation, e:Eye):void
		{
			if (_padding==1) return;
			
			var l:Logic;
			for each (l in _padded) { l.calculate(t,e); }
		}
		
		protected function doPaddingDraw(g:Graphics):void
		{
			var i:int;
			var p:Point;
			
			p = _padded[_padded.length-1] as Point;
			
			g.beginFill(_fillColor>>>8,(_fillColor&0xFF)/0xFF);
			if (_outlineWidth>=0)
				g.lineStyle(_outlineWidth,_outlineColor>>>8,(_outlineColor&0xFF)/0xFF);
			else
				g.lineStyle();
				
			p.moveTo(g);
			for (i=0;i<_padded.length;i++)
			{
				p = _padded[i] as Point;
				p.lineTo(g);
			}
			
			g.endFill();
		}
		
	}
}