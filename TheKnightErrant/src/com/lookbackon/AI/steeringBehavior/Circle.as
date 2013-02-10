package com.lookbackon.AI.steeringBehavior
{
	import flash.display.BitmapData;
	import flash.display.Sprite;

	/**
	 * Starling graphic draw based on Image class. 
	 * @see http://forum.starling-framework.org/topic/drawinggraphics-api-work-with-starling
	 * @author Knight.zhou
	 * 
	 */	
	public class Circle extends Sprite
	{
		private var _radius:Number;
		private var _color:uint;
		
		public function Circle(radius:Number, color:uint = 0x000000)
		{
			_radius = radius;
			_color = color;
			
		}
		
		public function get radius():Number
		{
			return _radius;
		}
		
		public function get position():Vector2D
		{
			return new Vector2D(x, y);
		}
	}
}