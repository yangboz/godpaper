package com.godpaper.as3.core
{
	/**
	 * Implement all the necessary clean up: 
	 * stop timers, remove event listeners, unload loader objects, set variable references to null, … 
	 * It’s then up to developers using your component to call the dispose() method just before releasing your object.
	 * @author Knight.zhou
	 * 
	 */	
	public interface IDisposable
	{
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		// Implements dispose method that must be called just before
		// releasing a MyComponent object
		function dispose():void;
//		{
			// Clean up:
			//      - Remove event listeners
			//      - Stop timers
			//      - Set references to null
			//      - ...
//		}
	}
}