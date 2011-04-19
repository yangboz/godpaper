package com.lookbackon.AI.steeringBehavior.behaviors
{
	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public interface IAvoid
	{
		function set avoidDistance(value:Number):void;
		function get avoidDistance():Number;
		
		function set avoidBuffer(value:Number):void;
		function get avoidBuffer():Number;
		
		function avoid(circles:Array):void;
	}
}