package com.lookbackon.AI.steeringBehavior
{
	/**
	 * The interface of vechicle type.
	 * all kinds of monster's type is vechicle.
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public interface IVehicle
	{
		/**
		 * Sets / gets what will happen if character hits edge.
		 */
		function set edgeBehavior(value:String):void;
		function get edgeBehavior():String;
		/**
		 * Sets / gets mass of character.
		 */
		function set mass(value:Number):void;
		function get mass():Number;
		/**
		 * Sets / gets maximum speed of character.
		 */
		function set maxSpeed(value:Number):void;
		function get maxSpeed():Number;
		/**
		 * Sets / gets position of character as a Vector2D.
		 */
		function set position(value:Vector2D):void;
		function get position():Vector2D;
		/**
		 * Sets / gets velocity of character as a Vector2D.
		 */
		function set velocity(value:Vector2D):void;
		function get velocity():Vector2D;
		/**
		 * Sets x position of character. Overrides Sprite.x to set internal Vector2D position as well.
		 */
		function set x(value:Number):void
		/**
		 * Sets y position of character. Overrides Sprite.y to set internal Vector2D position as well.
		 */
		function set y(value:Number):void
		/**
		 * update vehicle 's properties.
		 */			
		function update():void;
	}
}