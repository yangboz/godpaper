package com.godpaper.as3.plugins
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import mx.core.FlexGlobals;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;

	/**
	 * Commonly for custom define the plugin provider.
	 * Increasing the communication points between the host and the plug-in by adding more method, property, and event signatures to the IPlug interface. 
	 * Additional interaction between the host and plug-ins will allow for plug-ins that can do more things.
	 * Enabling users to explicitly select the plug-ins that are loaded.
	 * @see:http://geekspeak.creatrixgames.com/free-managed-flash-multiplayer-apis.html
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Apr 21, 2011 10:06:57 PM
	 */   	 
	public class PluginUIComponent extends UIComponent
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var _provider:IPlug;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		//
		public function get provider():IPlug
		{
			return _provider;
		}
		/**
		 * With the aid of reflection, types are loaded and inspected. 
		 * The inspection discerns if the type can be used as a plug-in. 
		 * If a type passes the tests for a plug-in, it is added to the host application’s display 
		 * and becomes accessible to users. 
		 * @param value the some PluginImpl class is responsible for providing an implementation 
		 * for its properties and functions defined at interface.
		 * With a plug-in defined, the next step is to examine the code in the host application that loads plug-ins. 
		 * To do this, the host application uses reflection. Reflection is a feature in AS3 that allows for the run-time 
		 * inspection of type information. 
		 * 
		 */	
		public function set provider(value:IPlug):void
		{
			_provider = value;
		}
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
		public function PluginUIComponent()
		{
			//TODO: implement function
			super();
			//
			this.addEventListener(FlexEvent.CREATION_COMPLETE,creationCompleteHandler);
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		/**
		 * preload plugin application here.
		 *
		 * @param event
		 *
		 */		
		protected function creationCompleteHandler(event:FlexEvent):void
		{
			//construct plugin movie played stage.
			FlexGlobals.topLevelApplication.pluginStage = new MovieClip();
			//
			this.addChild(FlexGlobals.topLevelApplication.pluginStage);
			//
			FlexGlobals.topLevelApplication.pluginStage.addEventListener(Event.ADDED_TO_STAGE,pluginStageClipOnStage);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		/**
		 * 
		 * @param event plugin stage has added to FlexGlobals.topLevelApplications
		 * With the aid of reflection, types are loaded and inspected. 
		 * The inspection discerns if the type can be used as a plug-in. 
		 * If a type passes the tests for a plug-in, it is added to the host application’s display 
		 * and becomes accessible to users. 
		 */	
		private function pluginStageClipOnStage(event:Event):void
		{
			//construct and instance plugin class.
//			var className:String=getQualifiedClassName(this.provider);
//			var implementation:Object=getDefinitionByName(className);
//			var _curentPlugin:* = new implementation();
			//plugin template functions defined here.
			provider.initialization();
		}
	}
	
}