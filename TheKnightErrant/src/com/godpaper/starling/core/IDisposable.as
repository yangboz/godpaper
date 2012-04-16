package com.godpaper.starling.core
{
	/**
	 * Implement all the necessary clean up: 
	 * stop timers, remove event listeners, unload loader objects, set variable references to null, … 
	 * It’s then up to developers using your component to call the dispose() method just before releasing your object.
	 * @author Knight.zhou
	 * @see http://help.adobe.com/en_US/as3/mobile/WS4bebcd66a74275c3-576ba64d124318d7189-7ffc.html
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