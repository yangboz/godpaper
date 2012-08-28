package ptolemy.geom3D.ui
{
	import ptolemy.geom3D.unfolding.Iunfolding;
	import ptolemy.geom3D.Platonic;
	import ptolemy.geom3D.unfolding.Cube;
	import flash.display.Sprite;
	import flash.display.DisplayObject;

	public class Unfolder extends Sprite
	{
		
		private var _unfolder:Iunfolding;
		private var _platonic:Platonic;
		private var _colors:Array;
		private var _proportion:Number;
		private var _drawCenters:Boolean;
		
		public function Unfolder()
		{
			_colors = [0xFF0000FF,0xFF8800FF,0xFFEE00FF,0x00FF00FF,0x1E90FFFF,0x0000CDFF,0x9900FFFF];
			_proportion = 1;
			_drawCenters = false;
			platonic = Platonic.CUBE;
		}
		
		public function get platonic():Platonic { return _platonic; }
		public function set platonic(p:Platonic):void
		{
			if (_platonic==p) return;
			
			if (_unfolder!=null)
				removeChild(_unfolder as DisplayObject);
			
			_platonic = p;
			switch (_platonic)
			{
				case Platonic.CUBE:
					_unfolder = new Cube(200);
					
					break;
				case Platonic.DODECAHEDRON:
				
					break;
				case Platonic.ICOSAHEDRON:
				
					break;
				case Platonic.OCTAHEDRON:
				
					break;
				case Platonic.TETRAHEDRON:
				
					break;
			}
			
			if (_unfolder==null) return;
			
			_unfolder.colors = _colors;	
			_unfolder.drawCenters = _drawCenters;
			_unfolder.proportion = _proportion;
			
			addChild(_unfolder as DisplayObject);
		}
		
		public function get proportion():Number
		{ return _proportion; }
		
		public function set proportion(n:Number):void
		{
			if (_proportion==n) return;
			_proportion = n;
			
			if (_unfolder!=null)
				_unfolder.proportion = n; 
		}
		
		public function get drawCenters():Boolean
		{ return _drawCenters; }
		
		public function set drawCenters(b:Boolean):void
		{
			if (_drawCenters==b) return;
			_drawCenters = b;
			
			if (_unfolder!=null)
				_unfolder.drawCenters = b; 
		}
		
		public function get colors():Array 
		{ return _colors; }
		
		public function set colors(arr:Array):void
		{
			if (_colors==arr) return;
			_colors = arr;
			
			if (_unfolder!=null)
				_unfolder.colors = _colors;
		}
		
		
	}
}

