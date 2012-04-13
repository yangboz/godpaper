package com.lookbackon.AI.steeringBehavior.behaviors
{
	import com.lookbackon.AI.steeringBehavior.Vector2D;

	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public interface IArrive
	{
		function set arriveThreshold(value:Number):void;
		function get arriveThreshold():Number;
		
		function arrive(target:Vector2D):void;
	}
}