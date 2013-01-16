package ptolemy.geom3D.controls
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	import ptolemy.geom3D.core.Eye;
	import ptolemy.geom3D.core.Scene;
	import ptolemy.geom3D.core.Solid;
	import ptolemy.geom3D.core.SpatialVector;

	public class Rotator extends EventDispatcher
	{
		private var _master:MovieClip;
		private var _scene:Scene;
		private var _origin:Point;
		private var _solid:Solid;
		private var _eye:Eye;
		private var _radius:int;
		private var _rr:int;

		private var _about:SpatialVector;
		private var _angle:Number;

		public function Rotator(master:MovieClip, scene:Scene, solid:Solid, eye:Eye, radius:int, initialAbout:SpatialVector = null, initialAngularVelocity:Number = 0)
		{
			_master = master;
			_scene = scene;
			_solid = solid;
			_eye = eye;
			_origin = new Point(eye.width / 2, eye.height / 2);
			_radius = radius;
			_rr = _radius * _radius;

			_about = initialAbout;
			_angle = initialAngularVelocity;

			if (_master.stage == null)
				_master.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			else
				addListeners();
		}

		private function onAddedToStage(e:Event):void
		{
			addListeners();
		}

		private function addListeners():void
		{
			_master.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			_master.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);

			_master.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			_master.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseEnter);

			update();
		}

		private function onRemovedFromStage(e:Event):void
		{
			removeListeners();
		}

		private function removeListeners():void
		{
			_master.removedEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			_master.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

			_master.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseEnter);
			_master.stage.removeEventListener(Event.MOUSE_LEAVE, onMouseLeave);
			_master.stage.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);

			_mousedown = false;
			_mousein = false;
			update();
		}

		/**
		 * 	functionality
		 */

		private var _mousedown:Boolean = false;
		private var _mousein:Boolean = false;

		private var _localStart:Point;
		private var _localFinish:Point;
		private var _start:SpatialVector;
		private var _finish:SpatialVector;

		private function translateVector(p:Point):SpatialVector
		{
			p.x -= _origin.x;
			p.y -= _origin.y;

			// if it's outside the radius then ignore
			var n:Number = p.x * p.x + p.y * p.y;
			if (n > _rr) return null;

			return new SpatialVector(p.x, p.y, Math.sqrt(_rr - n));
		}

		private function onMouseDown(e:MouseEvent):void
		{
			var p:Point;
			var v:SpatialVector;

			p = new Point(e.localX, e.localY);
			v = translateVector(p);
			if (v == null) return;

			_start = v;
			_localStart = p;

			_mousedown = true;
			_master.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			_master.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}

		private function onMouseMove(e:MouseEvent):void
		{
			var p:Point;
			var v:SpatialVector;

			p = new Point(e.localX, e.localY);
			if (!_mousedown) return;
			v = translateVector(p);
			if (v == null) p = null;
			if (v == null && _finish == null) return;

			_finish = v;
			_localFinish = p;

			if (_finish == null) return;

			update();
		}

		private function onMouseUp(e:MouseEvent):void
		{
			_mousedown = false;

			if (_finish != null)
			{
				_about = SpatialVector.crossProduct(_start, _finish, true);
				_angle = Math.acos(SpatialVector.dotProduct(_start, _finish) / _rr) / _master.stage.frameRate;
			}

			update();
		}

		private function onMouseEnter(e:MouseEvent):void
		{
			_mousein = true;
			_master.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseEnter);
			_master.stage.addEventListener(Event.MOUSE_LEAVE, onMouseLeave);

			update();
		}

		private function onMouseLeave(e:Event):void
		{
			_mousein = false;
			_master.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseEnter);
			_master.stage.removeEventListener(Event.MOUSE_LEAVE, onMouseLeave);

			update();
		}

		private var _previousMouseDown:Boolean = true;

		private function update():void
		{
			var b:Boolean;

			b = !_mousedown && _previousMouseDown;
			_previousMouseDown = _mousedown;

			if (b)
			{
				if (_angle > 0)
				{
					_solid.about = _about;
					_master.addEventListener(Event.ENTER_FRAME, onEnterFrame);
				}
				else
				{
					_master.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				}
			}

			redraw();
		}

		private function onEnterFrame(e:Event):void
		{
			_solid.angle += _angle;
			_scene.calculate();

			redraw();
		}

		private function redraw():void
		{
			_master.graphics.clear();

			_scene.draw(_master.graphics);


			if (!_mousedown) return;

			_master.graphics.lineStyle(2, 0xFF0000);
			_master.graphics.drawCircle(_origin.x, _origin.y, _radius);

			_master.graphics.lineStyle(2, 0xFF6600);
			if (_localStart != null) _master.graphics.drawCircle(_localStart.x + _origin.x, _localStart.y + _origin.y, 3);

			_master.graphics.lineStyle(2, 0xFFEE00);
			if (_localFinish != null) _master.graphics.drawCircle(_localFinish.x + _origin.x, _localFinish.y + _origin.y, 3);
		}


	}
}