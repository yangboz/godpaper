package com.godpaper.as3.plugins
{
	import flash.display.Stage;
	
	import mx.core.UIComponent;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * A plug-in design helps to share common functionality between solutions and also provides a common look and feel. 	
	 * The expectation that an interface defines is a collection of signatures for methods, properties, and events.
	 * @see http://drdobbs.com/cpp/184403942?pgno=1
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Apr 20, 2011 6:12:56 PM
	 */
	public interface IPlug
	{
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		function get data():IPlugData;
		//using UIComponent to interact with  MovieClip/Sprite elements.
//		function getEditControl(data:IPlugData):UIComponent;
		function initialization():void;//retrieve data and more initial functions.
		//plugin functions list:
		function showData():Boolean;
		function showStore():Boolean;
		function showLeaderboard(value:Object):Boolean;
		function showLoginWidget():Boolean;
		//about data operation
		function saveData(value:Object):Boolean;
		function submitData(value:Object):Boolean;
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