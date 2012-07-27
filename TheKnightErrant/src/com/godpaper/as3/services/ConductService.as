package com.godpaper.as3.services
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.configs.BoardConfig;
	import com.godpaper.as3.core.FlexGlobals;
	import com.godpaper.as3.model.UserModel;
	import com.godpaper.as3.model.vos.PostVO;
	import com.godpaper.as3.plugins.IPlug;
	
	import flash.events.AsyncErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.net.GroupSpecifier;
	import flash.net.NetConnection;
	import flash.net.NetGroup;
	
	//Framework internal usage only.
	[ExcludeClass]
	/**
	 * ConductService.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Feb 15, 2011 4:06:42 PM
	 */
	public class ConductService implements IConductService
	{
		private var netConnection:NetConnection;
		private var netGroup:NetGroup;
		//
		private var hasConnected:Boolean;
		//Constants
		public static const STATUS_CONNECTED:String = "p2p_connected";
		public static const STATUS_DISCONNECTED:String = "p2p_disconnected";
		public static const POST_TIMER_INTERVAL:Number = 20;//The inteval of every posted message.
		public static const SPECIFIER_NAME:String  = "GODPAPER_specifier";
		//Model
//		private var userModel:UserModel = FlexGlobals.userModel;
		//
		//--------------------------------------------------------------------------
		//
		//  Construtor
		//
		//--------------------------------------------------------------------------
		public function ConductService()
		{
			//Empty
		}
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		public function get connected():Boolean
		{
			return hasConnected;
		}
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		//P2p initialization call .
		public function initialization(server:String,devKey:String):void
		{
			//set up
			this.netConnection = new NetConnection();
			//listen
			this.netConnection.addEventListener(NetStatusEvent.NET_STATUS, netConnHandler);
			this.netConnection.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			//connect to lan
			this.netConnection.connect("rtmfp:");//for local
//			this.netConnection.connect(server.concat(devKey));//for local
			//			this.netConnection.connect("rtmfp://p2p.rtmfp.net/99ead580edaf280c060675f9-f614dd07a932");//for remote
		}
		
		//
		public function netGroupPost(message:Object,peerId:String=null):String
		{
			if(!peerId)
			{
				//send to all of players at this group.
				return this.netGroup.post(message);
			}else
			{
				//get the group address by peer id.
				var destination:String = this.netGroup.convertPeerIDToGroupAddress(peerId);
				//save to message object
				message.destination = destination;
				//then send message to destination
				return this.netGroup.sendToNearest(message,destination);
			}
			return null;
		}
		//
		public function transforBrevity(value:String):String
		{
			var message:PostVO = new PostVO();
			message.peerID = this.netConnection.nearID;
			message.state = PostVO.STATE_UPDATE;
			//send to all of players at this group.
			return this.netGroup.post(message);
		}
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		//
		protected function get iPlug():IPlug
		{
			return IPlug(FlexGlobals.topLevelApplication.pluginUIComponent.provider);
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		//
		private function createStatusMessageObject(status:String):PostVO
		{
			var obj:PostVO = new PostVO();
			obj.status = status;
			obj.peerID = this.netConnection.nearID;
			return obj;
		}
		//
		private function truncateString(str:String):String
		{
			return str.substr(0, 10)+"...";
		}
		//
		private function netConnHandler(event:NetStatusEvent):void
		{
			switch(event.info.code)
			{
				//connection succeeded so setup a group
				case "NetConnection.Connect.Success":
					trace("NetConnection.Connect.Success(nearID):"+this.netConnection.nearID);
					FlexGlobals.userModel.hosterPeerId = this.netConnection.nearID;
					//					//Refresh user list.
					FlexGlobals.userModel.addUser(this.netConnection.nearID);//Default index(0) as well as hoster.
					trace("[NetConnection.Connect.Success]:Currently total users(after addUser):",FlexGlobals.userModel.totalUsers());
					//ready to set up the net group.
					setupNetGroup();
					break;
				//group setup succeeded so enable submit
				case "NetGroup.Connect.Success":
					trace("NetGroup.Connect.Success:"+this.netGroup.info);
					//
					break;
				//posting received so add to output
				case "NetGroup.Posting.Notify":
					trace("[RECEIVED(Posting.Notify)] from:",event.info.message.peerID,"status:",event.info.message.status,"roleIndex",event.info.message.roleIndex);
					//handle status message
					if (event.info.message.status!=null)
					{
						//a peer has connected to group
						if (event.info.message.status==STATUS_CONNECTED)
						{
							//store peer info
							FlexGlobals.userModel.addUser(event.info.message.peerID);
							trace("[NetGroup.Posting.Notify]:Currently total users(after addUser):",FlexGlobals.userModel.totalUsers());
							//send this peers' info back to originator
							var extantConnObj:PostVO = createStatusMessageObject(STATUS_CONNECTED);
							extantConnObj.destination = this.netGroup.convertPeerIDToGroupAddress(event.info.message.peerID);
							this.netGroup.sendToNearest(extantConnObj, extantConnObj.destination);
						}
						else if (event.info.message.status==STATUS_DISCONNECTED)//a peer has disconnected from group
						{
							//refresh the user list.
							FlexGlobals.userModel.removeUser(event.info.message.peerID);
							trace("[NetGroup.Posting.Notify]:Currently total users(after removeUser):",FlexGlobals.userModel.totalUsers());
						}
					}
					else//handle  message with role information
					{
						trace("[RECEIVED] from:",truncateString(event.info.message.peerID),event.info.message.roleIndex,",state:",event.info.message.state);
						//state switcher
						if(event.info.message.state)
						{
							if(PostVO.STATE_REG == event.info.message.state)//registerRole
							{
								FlexGlobals.userModel.registerRole(event.info.message.peerID,event.info.message.roleIndex,event.info.message.roleName);
							}
							if(PostVO.STATE_UPDATE == event.info.message.state)//updateRole
							{
							}
							if(PostVO.STATE_CHAT == event.info.message.state)//updateRole
							{
								//dispatch external events.
							}
							if(PostVO.STATE_DOOR == event.info.message.state)//updateRole
							{
								//dispatch external events.
							}
							if(PostVO.STATE_VIDEO == event.info.message.state)//updateRole
							{
							}
							if(PostVO.STATE_NOTIFY == event.info.message.state)//text notification
							{
								//dispatch external events.
							}
						}
					}
					break;
				//neighbour connected so add details to list
				case "NetGroup.Neighbor.Connect":
					trace("[Neighbor(join)]:"+event.info.peerID);
					//send this peers' info back to hoster
					//see if this is first connect event
					if (!hasConnected)
					{
						//set flag
						hasConnected = true;
						//tell entire group about this instance
						var conObj:PostVO = createStatusMessageObject(STATUS_CONNECTED);
						this.netGroup.post(conObj);
					}
					break;
				//neighbour disconnected so remove details from list
				case "NetGroup.Neighbor.Disconnect":
					trace("[Neighbor(left)]:"+event.info.peerID);
					//unregisterRole
					FlexGlobals.userModel.unregisterRole(event.info.peerID);
					//refresh the user list.
					FlexGlobals.userModel.removeUser(event.info.peerID);
					trace("[NetGroup.Posting.Notify]:Currently total users(after removeUser):",FlexGlobals.userModel.totalUsers());
					//tell entire group about peer disconnecting
					var disconPost:PostVO = createStatusMessageObject(STATUS_DISCONNECTED);
					disconPost.peerID = event.info.peerID;
					this.netGroup.post(disconPost);
					break;
				//directed message received so check if this is the final destination
				case "NetGroup.SendTo.Notify":
					//final destination reached
					if (Boolean(event.info.fromLocal))//is destination? so display it
					{	
						//handle status message
						if (event.info.message.status!=null && event.info.message.status==STATUS_CONNECTED)
						{
							//refresh user list
							FlexGlobals.userModel.addUser(event.info.message.peerID);
							trace("[NetGroup.SendTo.Notify]:Currently total users(after addUser):",FlexGlobals.userModel.totalUsers());
						}
						else//handle  message with role information
						{
							trace("[RECEIVED] from:",truncateString(event.info.message.peerID),event.info.message.roleIndex);
						}
					}	
					else
					{
						trace("[RECEIVED(SendTo.Notify)] from:",event.info.message.peerID,"status:",event.info.message.status,"roleIndex",event.info.message.roleIndex);
						//not destination so re-send
						netGroup.sendToNearest(event.info.message, event.info.message.destination);
					}
					break;
				default:
					break;
			}
		}
		//
		private function setupNetGroup():void
		{
			//create a group specifier object
			var groupSpec:GroupSpecifier = new GroupSpecifier(SPECIFIER_NAME);
			//enable posting (to entire group)
			groupSpec.postingEnabled = true;
			//enable direct routing (to individual peer)
			groupSpec.routingEnabled = true;
			//allow data to be exchanged on IP multiply-cast sockets
			groupSpec.ipMulticastMemberUpdatesEnabled = true;
			//set the IP address and port to use.
			groupSpec.addIPMulticastAddress("225.225.0.1:30000");
			//create a NetGroup with NetConnection using GroupSpecifier details
			this.netGroup = new NetGroup(this.netConnection,groupSpec.groupspecWithAuthorizations());
			//listen for result of setup.
			this.netGroup.addEventListener(NetStatusEvent.NET_STATUS,netConnHandler);
			//
			trace(this.netGroup.info.toString());
		}
		//
		private function asyncErrorHandler(event:AsyncErrorEvent):void
		{
			trace(event.toString());
		}
	}
}