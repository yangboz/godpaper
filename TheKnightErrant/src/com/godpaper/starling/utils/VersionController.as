package com.godpaper.starling.utils
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import flash.events.ContextMenuEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.core.mx_internal;

	use namespace mx_internal;
	/**
	 * This class providing auto update version number functions which displayed in the flash player context menu.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jun 2, 2011 10:42:22 AM
	 * @see http://www.sephiroth.it/weblog/archives/2010/01/update_your_app_version_using_ant_bui.php
	 */   	 
	public class VersionController extends Application
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		/*
		*Forces this class to use the singleton pattern;
		*/
		private static var _class:VersionController;
		private static var _application:UIComponent;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		public static const CODE_NAME:String = "GODPAPER::TheRealKnight";
		public static const BUILD_DATE: String = '20120128';
		public static const BUILD_NUMBER: String = '231';
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
		public function VersionController(se:SingletonEnforcer)
		{
			//can Never get here without calling getInstance( );
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		public static function getInstance(item:UIComponent):VersionController
		{
			_application=item;
			if (!_class)
				_class=new VersionController(new SingletonEnforcer());
			//execute update.
			update();
			//
			return _class;
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
		private static function update():void
		{
			//	super.updateDisplayList( unscaledWidth, unscaledHeight ); 
			var cm:ContextMenu=new ContextMenu();
			var value:String= CODE_NAME.concat("_",BUILD_DATE,"_",BUILD_NUMBER);
			var cmi:ContextMenuItem=new ContextMenuItem(value);
			cm.customItems.push(cmi);
			cm.hideBuiltInItems();
			//
			_application.contextMenu=cm;
			//
			cmi.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, visitSiteHandler);
		}
		//
		private static function visitSiteHandler(event:ContextMenuEvent):void
		{
			flash.net.navigateToURL(new URLRequest("http://www.godpaper.com"));
		}
	}
	
}
class SingletonEnforcer
{
}