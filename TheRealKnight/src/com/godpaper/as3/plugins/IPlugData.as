package com.godpaper.as3.plugins
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * The IPlugData interface is defined in IPlugData.as and provides a lowest common denominator 
	 * for data exchange between the host application and any of its plug-ins. 
	 * Objects that support the IPlugData interface provide notification when the underlying data changes. 
	 * The notification comes in the form of the DataChanged event.	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Apr 20, 2011 6:23:12 PM
	 */
	public interface IPlugData
	{
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		//Data properties,such as gameID,boardID,userId/Name...
		function set gameID(value:String):void;
		function get gameID():String;
		
		function set boardID(value:String):void;
		function get boardID():String;
		//about store items.
		function get hasCaptureIndicator():Boolean;
		function get hasCheckIndicator():Boolean;
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
		function toString():String;
	}
}