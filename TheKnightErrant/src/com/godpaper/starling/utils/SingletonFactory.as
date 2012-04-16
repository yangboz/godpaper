package com.godpaper.starling.utils
{
	import flash.utils.Dictionary;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * One of the problems with the Singleton design pattern (there are many) is that 
	 * it encapsulates the single instance nature of the pattern within the class, 
	 * when very often the requirement for only one instance is not a feature of the class 
	 * but a feature of the application that is using the class.
	 * So I created this factory function to create and manage a single instance of any class. 
	 * There is no need to modify the class itself, just ask the function for an instance of the class 
	 * and it will always return the same instance.
	 * var a:SomeClass = SingletonFactory.produce( SomeClass );
	 * You can still create additional instances of the class using the new operator, 
	 * but if you use the singletonFactory function to get an instance it will always 
	 * return the same instance.    	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jul 2, 2011 9:48:38 AM
	 */   	 
	public class SingletonFactory
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private static var instances:Dictionary = new Dictionary(false);
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//-------------------------------------------------------------------------- 
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		/**
		 * Used to create a singleton from a class without adapting the 
		 * class itself. This function returns the same instance of the
		 * class every time it is called. This function only works with
		 * classes that don't require parameters in the constructor.
		 * @see http://code.google.com/p/bigroom/source/browse/trunk/src/uk/co/bigroom/utils/singletonFactory.as
		 * @param type The class you want a singleton from
		 * @return the singleton instance of the class
		 */
		public static function produce(type:Class):*
		{
			return (type in instances) ? instances[type] : instances[type] = new type();
		}
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}
	
}