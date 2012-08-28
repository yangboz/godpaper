package tbd
{
	import ptolemy.geom3D.core.Eye;
	import ptolemy.geom3D.core.Scene;
	import ptolemy.geom3D.core.Solid;
	import ptolemy.geom3D.core.SpatialVector;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.filters.GlowFilter;

	public class Jewel extends MovieClip
	{
		public static const AIR:String = "AIR";
		public static const EARTH:String = "EARTH";
		public static const FIRE:String = "FIRE";
		public static const WATER:String = "WATER";

		public static function generate(code:String):Jewel
		{
			var j:Jewel;
			switch (code)
			{
				case AIR:
					j = new Air();
					j.size = 100;
					break;
				case EARTH:
					j = new Earth();
					j.size = 90;
					break;
				case FIRE:
					j = new Fire();
					j.size = 120;
					break;
				case WATER:
					j = new Water();
					j.size = 60;
					break;
			}
			return j;
		}

		private var _solid:Solid;
		private var _scene:Scene;
		private var _eye:Eye;
		private var _dangle:Number;

		public function Jewel()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);

			invalidate();
		}

		private function onAddedToStage(e:Event):void
		{
			addListeners();
		}

		private function addListeners():void
		{
			if (_solid == null) return;
			updateJewel();
			updateEnterFrameListener();
		}

		private function onRemovedFromStage(e:Event):void
		{
			removeListeners();
		}

		private function removeListeners():void
		{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		private var _size:int = 40;

		public function get size():int
		{
			return _size;
		}

		public function set size(i:int):void
		{
			if (_size == i) return;
			_size = i;

			invalidate();
		}

		private var _playing:Boolean = true;

		public function get playing():Boolean
		{
			return _playing;
		}

		public function set playing(b:Boolean):void
		{
			if (_playing == b) return;
			_playing = b;
			updateEnterFrameListener();
		}

		protected function invalidate():void
		{
			addEventListener(Event.ENTER_FRAME, doUpdate);
		}

		protected function doUpdate(e:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, doUpdate);
			update();
		}

		protected function update():void
		{
		}

		protected function solid(s:Solid, colors:Array, glow:uint, size:int):void
		{
			if (s == null || _solid != null) return;

			_solid = s;
			_solid.about = new SpatialVector(0.2, 1, 0.2);
			_solid.colors = colors;
			_solid.outlineWidth = -1;

			var n:Number = size * 4 / 5;

			filters = [new GlowFilter(glow, 1, n, n)];

			_eye = new Eye();
			_eye.width = 0;
			_eye.height = 0;

			_dangle = Math.PI / 45;

			_scene = new Scene(_eye, _solid);

			if (stage == null) return;
			if (playing)
				addEventListener(Event.ENTER_FRAME, onEnterFrame);
			else
				updateJewel();
		}

		public override function set visible(b:Boolean):void
		{
			super.visible = b;
			updateEnterFrameListener();
		}

		private function updateEnterFrameListener():void
		{
			if (_playing && visible && stage != null)
				addEventListener(Event.ENTER_FRAME, onEnterFrame);
			else
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		private function onEnterFrame(e:Event):void
		{
			updateJewel();
		}

		private function updateJewel():void
		{
			_solid.angle += _dangle;

			graphics.clear();
			_scene.calculate();
			_scene.draw(graphics);
		}
	}
}