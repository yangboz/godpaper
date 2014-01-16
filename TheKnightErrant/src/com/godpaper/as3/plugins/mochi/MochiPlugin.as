package com.godpaper.as3.plugins.mochi
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.core.FlexGlobals;
	import com.godpaper.as3.plugins.IPlug;
	import com.godpaper.as3.plugins.IPlugData;
	import com.godpaper.as3.utils.LogUtil;
	
	import flash.events.Event;
	
	import mochi.as3.MochiCoins;
	import mochi.as3.MochiScores;
	import mochi.as3.MochiServices;
	import mochi.as3.MochiSocial;
	
	import mx.logging.ILogger;

	/**
	 * MochiPlugin.as class.   
	 * link:http://www.mochigames.com/	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Apr 22, 2011 4:37:21 PM
	 */   	 
	public class MochiPlugin implements IPlug
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var _mochiModel:MochiModel;
		//
		private var loginWidgetShowed:Boolean=false;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(MochiPlugin);
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		public function get data():IPlugData
		{
			return _mochiModel;
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
		public function MochiPlugin(gameID:String="",boardID:String="")
		{
			//Note that it does not matter if you define the objects as a var, 
			//a const or an implicit getter function. The objects these properties hold will all 
			//be added to the IOC container.
			//Of course intialization is again just a one liner:
			_mochiModel = new MochiModel();
			//
			_mochiModel.gameID = gameID;//47de4a85dd3e213a
			_mochiModel.boardID = boardID;//3a460211409897f4
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		//
		public function initialization():void
		{
			MochiSocial.addEventListener(MochiSocial.LOGGED_IN,logginHandler);
			MochiCoins.addEventListener(MochiCoins.ITEM_OWNED,itemOwendHandler);
			MochiCoins.addEventListener(MochiCoins.ITEM_NEW,itemNewHandler);
			//
			MochiServices.connect(_mochiModel.gameID,FlexGlobals.topLevelApplication.pluginStage,onMochiServiceConnectionError);
		}
		//
		public function showData():Boolean
		{
			//remove login widget if neccessary.
			if (loginWidgetShowed)
			{
				MochiSocial.hideLoginWidget();
				//
				loginWidgetShowed=false;
			}
			//
			return true;
		}
		//
		public function showStore():Boolean
		{
			//
			MochiCoins.showStore({clip: FlexGlobals.topLevelApplication.pluginStage});
			//
			return true;
		}
		//
		public function showLeaderboard(value:Object):Boolean
		{
			//simple leader board.
			if(value.hasOwnProperty("boardID"))
			{
				MochiScores.showLeaderboard({boardID: value.boardID});
			}
			//leader board ad here.
			//				MochiAd.showInterLevelAd({clip:FlexGlobals.topLevelApplication._mochiClip,
			//					id:mochiModel.gameID});
			//leader board with score and player name;
			if(value.hasOwnProperty("score")&&value.hasOwnProperty("name"))
			{
				var widgetWidth:Number = FlexGlobals.gameStage.width;
				var widgetHeight:Number = FlexGlobals.gameStage.height;
				MochiScores.showLeaderboard(
					{   res: widgetWidth.toString().concat(
						"x",widgetHeight), 
						clip: FlexGlobals.topLevelApplication.pluginStage, 
						score: _mochiModel.score.value,
						//						name: nameTextInput.text
						name: value.name
					}
				);
			}
			return true;
		}
		//
		public function showLoginWidget():Boolean
		{
			if (!loginWidgetShowed)
			{
				var loginWidgetX:Number = FlexGlobals.gameStage.width/ 2 - 100;//fixed widget's width;
				var loginWidgetY:Number = FlexGlobals.gameStage.height / 2 - 50;//fixed widget's height;
				//				LOG.debug("Mochi login widget position: ({0},{1})",loginWidgetX,loginWidgetY);
				MochiSocial.showLoginWidget({x: loginWidgetX, y: loginWidgetY});
				//
				loginWidgetShowed=true;
			}
			return true;
		}
		//
		public function saveData(value:Object):Boolean
		{
			//
			if(value.hasOwnProperty("boardID"))
			{
				MochiScores.setBoardID(_mochiModel.boardID);
			}
			return true;
		}
		//
		public function submitData(value:Object):Boolean
		{
			//
			if(value!=null)
			{
				_mochiModel.score.addValue(Number(value));
			}
			return true;
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
		//
		private function logginHandler(event:Object):void
		{
			// receive {name: name, uid: uid, profileImgURL: profileImgURL, hasCoins: True, userProperties: { hitPoints: 120 }}
			LOG.debug("Mochi loggin: {0}",event.name);
		}
		//
		private function itemOwendHandler(event:Object):void
		{
			// receive {id: id, count: count}
			//				trace("Player owns " + event.count + " of " + event.id);
			//
			_mochiModel.storeItemsRegister[event.id] = event.count;
//			_mochiModel.storeItemsRegister.insert(event.id,event.count);
		}
		//
		private function itemNewHandler(event:Object):void
		{
			// receive {id: id, count: count}
			//				trace("Player just bought " + event.count + " of " + event.id);
			//
			_mochiModel.storeItemsRegister[event.id] = event.count;
//			_mochiModel.storeItemsRegister.insert(event.id,event.count);
		}
		private function onMochiServiceConnectionError(status:String):void
		{
//			Alert.show("Re-connect MochiService?",status,Alert.YES|Alert.NO,null,onCloseHandler);
			LOG.error("Connect MochiService fail!");
			//Try again.
			FlexGlobals.topLevelApplication.pluginStage.dispatchEvent(new Event(Event.ADDED_TO_STAGE));
		}
		//
//		private function onCloseHandler(event:CloseEvent):void
//		{
//			//re-connect mochi service.\
//			if(event.detail==Alert.YES)
//			{
//				FlexGlobals.topLevelApplication.pluginStage.dispatchEvent(new Event(Event.ADDED_TO_STAGE));
//			}
//		}
	}
	
}