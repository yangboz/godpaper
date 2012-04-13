package com.lookbackon.AI.steeringBehavior
{
	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public interface ISteeredVehicle extends IVehicle
	{
		function set maxForce(value:Number):void;
		function get maxForce():Number;
		
		function set inSightDist(value:Number):void;
		function get inSightDist():Number;
		
		function set tooCloseDist(value:Number):void;
		function get tooCloseDist():Number;
		
		function inSight(vehicle:VehicleSample):Boolean;		
		function tooClose(vehicle:VehicleSample):Boolean;
	}
}