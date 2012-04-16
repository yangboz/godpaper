package com.godpaper.starling.core
{
	import flash.geom.Point;

	/**
	 * The interface of chess piece and chess gasket.With x,y position properties.
	 * @author knight.zhou
	 *
	 */	
	public interface IPosition
	{
		function set position(value:Point):void;
		function get position():Point;
	}
}

