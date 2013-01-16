package ptolemy.geom3D.core
{
	import flash.display.Graphics;
	
	public class Scene
	{
		protected var _eye:Eye;
		protected var _solids:Array;
		
		public function Scene(eye:Eye, ... solids)
		{
			_eye = eye;
			_solids = solids;
		}
		
		public function get solids():Array { return _solids; }
		
		public function calculate():void
		{
			var s:Solid;
			var t:Transformation;
						
			for each (s in _solids)
			{
				s.calculate(t,_eye);
			}
		}
		
		public function draw(g:Graphics):void
		{
			var s:Solid;
			
			_solids.sort(compareFunction);
			
			for each (s in _solids)
			{
				s.draw(g);
			}
			
		}
	
		private function compareFunction(a:*, b:*):int
		{
			if (a.draworder==null || b.draworder==null) return 0;
			if (a.draworder<b.draworder) return -1;
			if (b.draworder<a.draworder) return 1;
			return 0;
		}
		
	}
}