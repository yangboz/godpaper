package com.lookbackon.AI.steeringBehavior.behaviors
{
	import com.lookbackon.AI.steeringBehavior.VehicleSample;

	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */
	public interface IPursue
	{
		function pursue(target:VehicleSample):void;
	}
}