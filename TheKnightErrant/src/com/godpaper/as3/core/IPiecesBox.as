package com.godpaper.as3.core
{
	import com.godpaper.as3.model.vos.ConductVO;
	import flash.geom.Rectangle;
	import com.godpaper.as3.core.IDragdropable;
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * You can put chess pieces inside the box constrainted by the fixed area.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jul 8, 2011 11:55:25 AM
	 */
	public interface IPiecesBox extends IType,IDragdropable
	{
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		function set childrenArea(value:Rectangle):void;
		function get childrenArea():Rectangle;
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//-------------------------------------------------------------------------- 
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
	}
}