package com.lookbackon.AI.steeringBehavior
{
	import com.lookbackon.AI.steeringBehavior.behaviors.IArrive;
	import com.lookbackon.AI.steeringBehavior.behaviors.IAvoid;
	import com.lookbackon.AI.steeringBehavior.behaviors.IEvade;
	import com.lookbackon.AI.steeringBehavior.behaviors.IFlee;
	import com.lookbackon.AI.steeringBehavior.behaviors.IFllowPath;
	import com.lookbackon.AI.steeringBehavior.behaviors.IFlock;
	import com.lookbackon.AI.steeringBehavior.behaviors.IPursue;
	import com.lookbackon.AI.steeringBehavior.behaviors.ISeek;
	import com.lookbackon.AI.steeringBehavior.behaviors.IWander;
	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public interface ISteeredVehicle extends IVehicle,
											 IArrive,IAvoid,IEvade,IFlee,IFllowPath,IFlock,IPursue,ISeek,IWander
	{
		function set maxForce(value:Number):void;
		function get maxForce():Number;
		
		function set inSightDist(value:Number):void;
		function get inSightDist():Number;
		
		function set tooCloseDist(value:Number):void;
		function get tooCloseDist():Number;
		
		function inSight(vehicle:Vehicle):Boolean;		
		function tooClose(vehicle:Vehicle):Boolean;
	}
}