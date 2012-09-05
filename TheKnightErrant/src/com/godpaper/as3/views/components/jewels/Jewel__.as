package com.godpaper.as3.views.components.jewels
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	
	import ptolemy.geom3D.core.Eye;
	import ptolemy.geom3D.core.Scene;
	import ptolemy.geom3D.core.Solid;
	import ptolemy.geom3D.core.SpatialVector;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	
	/**
	 * Jewel__.as class.For starling sprite based component.</br>
	 * Define the parent holder(flash.display.Sprite) firstly,then add it to starling stage(starling.display.Sprite).   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Aug 29, 2012 3:57:51 PM
	 */   	 
	public class Jewel__ extends Sprite
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var _solid:Solid;
		private var _scene:Scene;
		private var _eye:Eye;
		private var _dangle:Number;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		public static const AIR:String = "AIR";
		public static const EARTH:String = "EARTH";
		public static const FIRE:String = "FIRE";
		public static const WATER:String = "WATER";
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		public static var holder:flash.display.Sprite;//Define parent holder refer here.
		//
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
		//
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
		//
		public override function set visible(b:Boolean):void
		{
			super.visible = b;
			updateEnterFrameListener();
		}
		//
		public function get graphics():Graphics
		{
			return Jewel__.holder.graphics;
		}
		//Dynamic adjust the holder's position
		override public function set x(value:Number):void
		{
			super.x = value;
			Jewel__.holder.x = value;
		}
		//
		override public function set y(value:Number):void
		{
			super.y = value;
			Jewel__.holder.y = value;
		}
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//-------------------------------------------------------------------------- 
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function Jewel__()
		{
//			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
			//			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			addEventListener(starling.events.Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			
			invalidate();
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		public static function generate(code:String):Jewel__
		{
			var j:Jewel__;
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
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		protected function invalidate():void
		{
			//			addEventListener(Event.ENTER_FRAME, doUpdate);
			addEventListener(starling.events.Event.ENTER_FRAME,update);
		}
		//		protected function doUpdate(e:Event):void
		protected function doUpdate(e:starling.events.Event):void
		{
			//			removeEventListener(Event.ENTER_FRAME, doUpdate);
			removeEventListener(starling.events.Event.ENTER_FRAME, doUpdate);
			update();
		}
		//
		protected function update():void
		{
		}
		//
		protected function solid(s:Solid, colors:Array, glow:uint, size:int):void
		{
			if (s == null || _solid != null) return;
			
			_solid = s;
			_solid.about = new SpatialVector(0.2, 1, 0.2);
			_solid.colors = colors;
			_solid.outlineWidth = -1;
			
			var n:Number = size * 4 / 5;
			
			//			filters = [new GlowFilter(glow, 1, n, n)];
			
			_eye = new Eye();
			_eye.width = 0;
			_eye.height = 0;
			
			_dangle = Math.PI / 45;
			
			_scene = new Scene(_eye, _solid);
			
			if (stage == null) return;
			if (playing)
				//				addEventListener(Event.ENTER_FRAME, onEnterFrame);
				addEventListener(starling.events.Event.ENTER_FRAME,onEnterFrame);
			else
				updateJewel();
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		//		private function onAddedToStage(e:Event):void
		private function onAddedToStage(e:starling.events.Event):void
		{
			addListeners();
		}
		//
		private function addListeners():void
		{
			if (_solid == null) return;
			updateJewel();
			updateEnterFrameListener();
		}
		//		private function onRemovedFromStage(e:Event):void
		private function onRemovedFromStage(e:starling.events.Event):void
		{
			removeListeners();
		}
		//
		private function removeListeners():void
		{
			//			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			removeEventListener(starling.events.Event.ENTER_FRAME, onEnterFrame);
		}
		//
		private function updateEnterFrameListener():void
		{
			if (_playing && visible && stage != null)
				//				addEventListener(Event.ENTER_FRAME, onEnterFrame);
				addEventListener(starling.events.Event.ENTER_FRAME,onEnterFrame);
			else
				//				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				removeEventListener(starling.events.Event.ENTER_FRAME, onEnterFrame);
		}
		//		private function onEnterFrame(e:Event):void
		private function onEnterFrame(e:starling.events.Event):void
		{
			updateJewel();
		}
		//
		private function updateJewel():void
		{
			_solid.angle += _dangle;
			
			graphics.clear();
			_scene.calculate();
			_scene.draw(graphics);
		}
	}
	
}