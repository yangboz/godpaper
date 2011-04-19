package com.lookbackon.AI.steeringBehavior.behaviors
{
	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */
	public interface IFllowPath
	{
		function set pathIndex(value:int):void;
		function get pathIndex():int;
			
		function set pathThreshold(value:Number):void;
		function get pathThreshold():Number;
	}
}