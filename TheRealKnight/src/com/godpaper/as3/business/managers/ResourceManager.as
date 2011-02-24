package com.godpaper.as3.business.managers
{
	import com.godpaper.as3.utils.LogUtil;
	
	import flash.display.Loader;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.events.ResourceEvent;
	import mx.logging.ILogger;
	import mx.resources.IResourceBundle;
	import mx.resources.ResourceBundle;
	import mx.resources.ResourceManager;
	
	/*[Event(name="LoadCustomResourceBundleComplete")]*/
	/**
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class ResourceManager extends EventDispatcher
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var myResourceBundle:ResourceBundle;
		
		private var originalResourceBundle:IResourceBundle;
		private var originalResourceBundleContent:Object;
		
		private var resourceNameIndex:int = 0;
		private var resourceNames:Array=[];
		
		private var resourceModules:Array = [];
		private var resourceModuleIndex:int = 0;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		public static const LOAD_CUSTOM_RESOURCE_BUNDLE_COMPLETE:String 	= "LoadCustomResourceBundleComplete";
		private static const LOG:ILogger = LogUtil.getLogger(ResourceManager);
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function ResourceManager()
		{
			//TODO: implement function
			super();
			
		}
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		/**
		 * The loadResourceModule() method returns an event-dispatching object. 
		 * You can listen for "progress", "complete", 
		 * and "error" events — of type ResourceEvent — which it dispatches. 
		 * Primarily, you’ll be interested in knowing when the load is complete, 
		 * because that’s when you’ll probably want to set the localeChain 
		 * to use the resources that you just loaded. 
		 * 
		 */	
		public function loadResourceModules():void
		{
			var iEventDispatcher:IEventDispatcher = 
				mx.resources.ResourceManager.getInstance().loadResourceModule(this.resourceModules[resourceModuleIndex]);
			iEventDispatcher.addEventListener(ResourceEvent.COMPLETE,loadResourcesModuleComplete);
			iEventDispatcher.addEventListener(ResourceEvent.PROGRESS,loadResourcesModuleProgressHandler);
			iEventDispatcher.addEventListener(ResourceEvent.ERROR,loadResourcesModuleErrorHandler);
		}
		//load module progress
		private function loadResourcesModuleProgressHandler(event:ResourceEvent):void
		{
			//			LOG.debug("Load Resources Modules[{0}] Progress...",this.resourceNameIndex);
		}
		//load module error
		private function loadResourcesModuleErrorHandler(event:ResourceEvent):void
		{
			LOG.fatal("Load Resources Bundle Modules[{0}] Error!!!",this.resourceNameIndex);
		}
		//load module complete
		private function loadResourcesModuleComplete(event:ResourceEvent):void
		{
			//
		}
	}
}