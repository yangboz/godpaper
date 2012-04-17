package com.lookbackon.AI.steeringBehavior.tests
{
	import com.lookbackon.AI.steeringBehavior.Circle;
	import com.lookbackon.AI.steeringBehavior.SteeredVehicle;
	import com.lookbackon.AI.steeringBehavior.Vector2D;
	import com.lookbackon.AI.steeringBehavior.Vehicle;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	public class SeekTest extends Sprite
	{
		private var _vehicle:SteeredVehicle;
		
		public function SeekTest()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			_vehicle = new SteeredVehicle();
			addChild(_vehicle);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(event:Event):void
		{
			_vehicle.seek(new Vector2D(mouseX, mouseY));
			_vehicle.update();
		}
	}
}