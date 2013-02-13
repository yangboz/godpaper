package com.godpaper.as3.model
{
	import com.godpaper.as3.model.vos.UserVO;
	
	import flash.net.SharedObject;
	import flash.utils.Dictionary;
	
	import org.osflash.signals.Signal;
	

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	//Framework internal usage only.
	[ExcludeClass]
	/**
	 * UserModel.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Jul 18, 2012 3:50:10 PM
	 */   	 
	public class UserModel
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//Shared object
//		private var sharedObject:SharedObject;
		//
		public var hosterRoleIndex:int=0;
		//
		public var hosterPeerId:String;
		//Users.
		public var userList:Dictionary;
		//Hoster role name
		public var hostRoleName:String;
		//Locale
		public var locale:String = "en_US";
		//Signals
		public var signal_player_registed:Signal;
		//Misc
		public var state:String = "cross";//"cross","circle"
		public var moves:Array = [];//Temp store chess piece moves
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
//		public var ROLE_NAME_LIST:Vector.<String> = new Vector.<String>("Player1" ,"Player2" ,"Spectator");
		public var ROLE_NAME_LIST:Array = ["Player1" ,"Player2" ,"Spectator"];
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
		public function UserModel()
		{
//			this.sharedObject = SharedObject.getLocal(HongKongVR.SPECIFIER_NAME);
			this.userList = new Dictionary();
			//
			this.signal_player_registed  = new Signal(String);
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		//
		public function removeUser(peerId:String):void
		{
			userList[peerId] = null;
			delete userList[peerId];
		}
		//
		public function addUser(peerId:String):void
		{
			//Avoid duplication
			if(!userList[peerId])
			{
				var userVO:UserVO = new UserVO();
				userVO.peerID = peerId;
				userList[peerId] = userVO;
			}
		}
		//
		public function registerRole(peerId:String,roleIndex:int,roleName:String):void
		{
//			if(!userList[peerId] || !userList[peerId].role)//Avoid duplication.
			if(userList[peerId])
			{
				var anew:UserVO = new UserVO();
				anew.peerID = peerId;
				anew.roleIndex = roleIndex;
				anew.roleName = roleName;
				userList[peerId] = anew;
				//flush the shared object
				trace("[Registed] userVO#roleName:",userList[peerId].roleName,",#roleIndex:",userList[peerId].roleIndex,",peerID:",peerId);
				//dispatch external events.
				this.signal_player_registed.dispatch(peerId);
			}
		}
		//
		public function unregisterRole(peerId:String):void
		{
			//refresh the shared object
			trace("[UnRegisted] userVO#peerId:",peerId);
			//dispatch external events.
		}
		//
		public function totalUsers():String
		{
			var keys:Array = [];
			for (var key:String in userList)
			{
				if(userList[key])
				{
					keys.push(key);
				}
			}
			return keys.toString();
		}
		//
		public function updateRole(peerId:String,x:Number,y:Number,z:Number,rX:Number,rY:Number,rZ:Number,oX:Number,oY:Number,oZ:Number,action:String,video:int):void
		{
			if(!userList[peerId])
			{
				addUser(peerId);
			}
			if(userList[peerId].role)//Avoid illegal opeartion.
			{
				var userVO:UserVO = userList[peerId] as UserVO;
				userVO.action = action;
				//flush the shared object
				trace("[Registed] userVO#name:",userList[peerId].roleName,",#roleIndex:",userList[peerId].roleIndex,",peerID:",peerId);
				//dispatch external events.
			}
		}
		//
		public function getUserRoleName(peerID:String):String
		{
			return (userList[peerID] as UserVO).roleName;
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