package com.lookbackon.AI.steeringBehavior.behaviors
{
	import com.lookbackon.AI.steeringBehavior.VehicleSample;

	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */
	public interface IEvade
	{
		function evade(target:VehicleSample):void;
	}
}