package com.godpaper.as3.services
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.configs.BoardConfig;
	import com.godpaper.as3.plugins.mochi.MochiModel;

	import flash.events.NetStatusEvent;
	import flash.net.GroupSpecifier;
	import flash.net.NetConnection;
	import flash.net.NetGroup;


	/**
	 * ConductService.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Feb 15, 2011 4:06:42 PM
	 */
	public class ConductService implements IConductService
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var nc:NetConnection;
		private var netGroup:NetGroup;
		private var ncHistory:String;

		[Bindable]
		private var user:String;

		private var _connected:Boolean=false;

		[Inject]
		public var mochiModel:MochiModel;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------

		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		public function get connected():Boolean
		{
			return _connected;
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


		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		//
		public function initialization(server:String,devKey:String):void
		{
			//P2P net nection initialization.
			this.nc=new NetConnection();
			nc.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			nc.connect(server.concat(devKey));
		}
		//
		public function transforBrevity(value:String):void
		{
			//TODO: implement function
			var message:Object=new Object();
			message.sender=netGroup.convertPeerIDToGroupAddress(nc.nearID);
			//
			message.user=mochiModel.name;
			message.text=value;
			//
			netGroup.post(message);
			//
			receiveMessage(message);
		}

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		protected function netStatusHandler(event:NetStatusEvent):void
		{
			//
			write(event.info.code);
			//
			switch (event.info.code)
			{
				case "NetConnection.Connect.Success":
					setupGroup();
					break;

				case "NetGroup.Connect.Success":
					_connected=true;
					break;

				case "NetGroup.Posting.Notify":
					receiveMessage(event.info.message);
					break;
				default:
					break;
			}
		}

		//
		protected function setupGroup():void
		{
			var groupspec:GroupSpecifier=new GroupSpecifier("CcjGroup/g1");
			groupspec.serverChannelEnabled=true;
			groupspec.postingEnabled=true;
			trace("Groupspec: " + groupspec.groupspecWithAuthorizations());
			netGroup=new NetGroup(nc, groupspec.groupspecWithAuthorizations());
			netGroup.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			//
			user="user" + Math.round(Math.random() * 10000);
		}

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		//
		private function receiveMessage(message:Object):void
		{
			write(message.user + ": " + message.text);
		}

		//
		private function write(txt:String):void
		{
			trace("msg:",txt);
			ncHistory+=txt + "\n";
		}
	}

}

