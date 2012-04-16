package com.godpaper.starling.utils
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;

	/**
	 * ProxyArray.as class with sum/clear dynamic functions support.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jun 10, 2011 10:45:38 AM
	 * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/utils/Proxy.html
	 */
	public dynamic class ProxyArray extends Proxy
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var _item:Array;
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
		public function ProxyArray(source:Array)
		{
			_item=source;
		}
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		//
		override flash_proxy function callProperty(methodName:*, ... args):*
		{
			var res:*;
			switch (methodName.toString())
			{
				case "clear":
					_item=new Array();
					break;
				case "numberSum":
					var numberSum:Number=0;
					for each (var i:* in _item)
					{
						// ignore non-numeric values
						if (!isNaN(i))
						{
							numberSum+=i;
						}
					}
					res=numberSum;
					break;
				case "objectSum":
					var objectSum:Number=0;
					for each (var j:* in _item)
					{
						// ignore null element
						if (j!=null)
						{
							objectSum++;
						}
					}
					res=objectSum;
					break;
				default:
					res=_item[methodName].apply(_item, args);
					break;
			}
			return res;
		}

		//
		override flash_proxy function getProperty(name:*):*
		{
			return _item[name];
		}

		//
		override flash_proxy function setProperty(name:*, value:*):void
		{
			_item[name]=value;
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
