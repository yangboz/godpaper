/**
 *  GODPAPER Confidential,Copyright 2012. All rights reserved.
 *
 *  Permission is hereby granted, free of charge, to any person obtaining
 *  a copy of this software and associated documentation files (the "Software"),
 *  to deal in the Software without restriction, including without limitation
 *  the rights to use, copy, modify, merge, publish, distribute, sub-license,
 *  and/or sell copies of the Software, and to permit persons to whom the
 *  Software is furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included
 *  in all copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 *  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 *  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
 *  IN THE SOFTWARE.
 */
package
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	import com.godpaper.as3.configs.BoardConfig;
	import com.godpaper.as3.configs.GameConfig;
	import com.godpaper.as3.configs.GasketConfig;
	import com.godpaper.as3.configs.PieceConfig;
	import com.godpaper.as3.configs.PluginConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.model.FlexGlobals;
	import com.godpaper.as3.plugins.IPlug;
	import com.godpaper.as3.plugins.PluginUIComponent;
	import com.godpaper.as3.plugins.kongregate.KongregatePlugin;
	import com.godpaper.as3.plugins.mochi.MochiPlugin;
	import com.godpaper.as3.plugins.nonoba.NonobaPlugin;
	import com.godpaper.as3.utils.LogUtil;
	import com.godpaper.as3.utils.VersionController;
	import com.godpaper.starling.views.scenes.GameScene;
	import com.godpaper.tho.buiness.factory.ThoChessFactory;
	import com.godpaper.tho.buiness.managers.ThoChessPieceManager;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	
	import mx.logging.ILogger;
	
	import net.hires.debug.Stats;
	
	import starling.core.Starling;

	/**
	 * ApplicationBase.as class constructed with framework's workflow:
	 * 1.initializeHandler;
	 * 2.applicationCompleteHandler;
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Apr 12, 2012 9:38:56 AM
	 */   	 
	[SWF(frameRate="60", width="320", height="480", backgroundColor="0xffffff")]//320×480 for iPhone devices
//	[SWF(frameRate="60", width="384", height="512", backgroundColor="0xffffff")]//384×512 for iPad devices
	public class ApplicationBase extends Sprite
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//Plugin stage support.
		public var pluginStage:MovieClip;
		//Default mochi dashboard hint.
		public var _mochiads_game_id:String = "c7278f158e32f9a0";
		//For children dynamic factory config.
//		[Bindable]protected var pcFactory:Class = PieceConfig.factory;
		protected var pcFactory:Class = PieceConfig.factory;
		//Views(esp for plugin display)
		public var pluginUIComponent:PluginUIComponent;
		//
		private var mStarling:Starling;
		//Signals
		
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(ApplicationBase);
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		/**
		 * Override this for customize plugin provider.
		 */ 
		public function get pluginProvider():IPlug
		{
//			return new MochiPlugin(PluginConfig.gameID,PluginConfig.boardID);
//			return new NonobaPlugin();
			return new KongregatePlugin();
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
		/**
		 * Application bootstrap class.
		 * 
		 */
		public function ApplicationBase()
		{
//			super();
			//
			LOG.debug("preinitializeHandler@Constructor");
			//
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
//			trace(stage.stage3Ds.length);
			//
			Starling.multitouchEnabled = true; // useful on mobile devices
			Starling.handleLostContext = true; // deactivate on mobile devices (to save memory)
			//
//			mStarling = new Starling(GameScene, stage,new Rectangle(0,0,768,1004));
			var screenWidth:int  = 320;//384
			var screenHeight:int = 480;//512
//			var screenWidth:int  = stage.fullScreenWidth;
//			var screenHeight:int = stage.fullScreenHeight;
			var viewPort:Rectangle = new Rectangle(0, 0, screenWidth, screenHeight);
			mStarling = new Starling(GameScene, stage,viewPort);
			mStarling.simulateMultitouch = true;
			mStarling.enableErrorChecking = Capabilities.isDebugger;
			mStarling.start();
			//Display stats.
			mStarling.showStats = true;
			//Multi-Resolution Development
			//@see: http://wiki.starling-framework.org/manual/multi-resolution_development
			LOG.debug("Starling contentScaleFactor:{0}",mStarling.contentScaleFactor);
			var isPad:Boolean = (screenWidth >= 768 || screenWidth >= 1536);
			mStarling.stage.stageWidth  = isPad ? 384 : 320;
			mStarling.stage.stageHeight = isPad ? 512 : 480;
			LOG.debug("Starling contentScaleFactor:{0}",mStarling.contentScaleFactor);
			// loader info.
			this.loaderInfo.addEventListener(flash.events.Event.COMPLETE, loaderInfoCompleteHandler);
			// add to stage.
			this.addEventListener(flash.events.Event.ADDED_TO_STAGE,addToStageHandler);
			// this event is dispatched when stage3D is set up
			mStarling.stage3D.addEventListener(flash.events.Event.CONTEXT3D_CREATE, context3DCreatedHandler);
//			mStarling.stage3D.addEventListener(starling.events.Event.ROOT_CREATED, rootCreatedHandler);
			// signals initialization.
			
			// turn to framework's workflow
			initializeHandler();
			// Stats display
//			var stats:Stats = new Stats();
//			this.addChild(stats);
		} 
		//
		private function loaderInfoCompleteHandler(event:flash.events.Event):void
		{
			LOG.debug("creationCompleteHandler@loaderInfo_complete");
			//
			this.stage.addEventListener(flash.events.Event.RESIZE, stageResizeHandler, false, 0, true);
			//Deative,active event listeners.
//			this.stage.addEventListener(Event.DEACTIVATE, stageDeactivateHandler, false, 0, true);
		}
		//
		private function stageResizeHandler(event:flash.events.Event):void
		{
			LOG.debug("stage_resizeHandler");
			this.mStarling.stage.stageWidth = this.stage.stageWidth;
			this.mStarling.stage.stageHeight = this.stage.stageHeight;
			
			const viewPort:Rectangle = this.mStarling.viewPort;
			viewPort.width = this.stage.stageWidth;
			viewPort.height = this.stage.stageHeight;
			try
			{
				this.mStarling.viewPort = viewPort;
			}
			catch(error:Error) {}
		}
		//
		private function addToStageHandler(event:flash.events.Event):void
		{
			LOG.debug("initializeHandler@addToStage");
			this.removeEventListener(flash.events.Event.ADDED_TO_STAGE,addToStageHandler);
			// turn to framework's workflow
//			applicationCompleteHandler();
			//Store this reference to FlexGlobals.topLevelApplication
			FlexGlobals.topLevelApplication = this;
			FlexGlobals.gameStage = mStarling.stage;
			// Plugin display
			this.pluginUIComponent = new PluginUIComponent();
//			this.pluginUIComponent.provider = this.pluginProvider;With default plugin provider
			this.addChild(this.pluginUIComponent);
		}
		//
		private function context3DCreatedHandler(event:flash.events.Event):void
		{
//			LOG.debug("Starling is start:{0}",mStarling.isStarted);
			var driverIsSoftware:Boolean = Starling.context.driverInfo.toLowerCase().indexOf("software") != -1;
			LOG.debug("applicationCompleteHandler@onContextCreated,driverInfo(software) is:{0}",driverIsSoftware);
			// set framerate to 30 in software mode
			if (driverIsSoftware)
			{
				Starling.current.nativeStage.frameRate = 30;			
			}
			//
			this.removeEventListener(flash.events.Event.CONTEXT3D_CREATE,context3DCreatedHandler);
			// turn to framework's workflow
			applicationCompleteHandler();
		}
//		private function rootCreatedHandler(event:starling.events.Event):void
//		{
//			LOG.debug("Starling root created");
//			//
//			this.removeEventListener(starling.events.Event.ROOT_CREATED,rootCreatedHandler);
//		}
		private function stageDeactivateHandler(event:Event):void
		{
			this.mStarling.stop();
			this.stage.addEventListener(Event.ACTIVATE, stageDeactivateHandler, false, 0, true);
		}
		//
		private function stageActivateHandler(event:Event):void
		{
			this.stage.removeEventListener(Event.ACTIVATE, stageActivateHandler);
			this.mStarling.start();
		}
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		/**
		 * Foot sprint dump,optional for logging the end of turn messages.
		 */		
		public function dumpFootSprint():void
		{
			//
			LOG.info("redPieces:{0}", FlexGlobals.chessPiecesModel.redPieces.dump());
			LOG.info("bluePieces:{0}", FlexGlobals.chessPiecesModel.bluePieces.dump());
			LOG.info("allPieces:{0}", FlexGlobals.chessPiecesModel.allPieces.dump());
			//			//
			//			LOG.info("allPieces rotate90:{0}", FlexGlobals.chessPiecesModel.allPieces.rotate90().dump());
			//			LOG.info("allPieces rotate90.bitCount:{0}", FlexGlobals.chessPiecesModel.allPieces.bitCount);
			//			LOG.info("allPieces rotate90.cellCount:{0}", FlexGlobals.chessPiecesModel.allPieces.cellCount);
		}
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		//applicationBase_initializeHandler
		/**
		 * All kinds of view components initialization here.
		 */		
		protected function initializeHandler():void
		{
			//config initialization here.
			//about chess board:
			BoardConfig.xLines=4;
			BoardConfig.yLines=4;
			BoardConfig.xOffset=50;
			BoardConfig.yOffset=50;
			BoardConfig.xAdjust=50;
			BoardConfig.yAdjust=50;
			//gasket config:
			GasketConfig.maxPoolSize = 16;
			GasketConfig.tipsVisible = true;
			GasketConfig.backgroundAlpha = 0.2;
			GasketConfig.width = 30;
			GasketConfig.height = 30;
			//about piece:
			PieceConfig.factory = ThoChessFactory;
			PieceConfig.maxPoolSizeBlue = 6;
			PieceConfig.maxPoolSizeRed = 6;
			//Notice:starling scaleX/Y seldom triggle touch event issues.
			PieceConfig.scaleX = 1;
			PieceConfig.scaleY = 1;
			//about plugin:
			PluginConfig.gameID = "cc2fd3b3196f4281";//your custom game related id.
			PluginConfig.boardID = "51c558cd0315f8e7";//your custom game related board id.
			//
			LOG.debug("SigletonFactory(cp) test:{0}",FlexGlobals.chessPiecesModel.BLUE_BISHOP.dump());
			LOG.debug("SigletonFactory(cg) test:{0}",FlexGlobals.chessGasketsModel.gaskets);
			LOG.debug("SigletonFactory(cb) test:{0}",FlexGlobals.chessBoardModel.status.dump());
		}
		//  applicationBase_applicationCompleteHandler
		/**
		 * Game application start up here.
		 */		
		protected function applicationCompleteHandler():void
		{
			//			//init data struct.@see ChessPieceModel dump info.
			//			this.dumpFootSprint();
			//Add version control context menu.
			VersionController.getInstance(this);
			//GameManager start.
			//number of tollgate tips would be matched with tollgates!
			//			GameConfig.tollgates = [RandomWalk,ShortSighted,AttackFalse,AttackFalse,MiniMax];
			//			GameConfig.tollgateTips = ["baby intelligence","fellow intelligence","man intelligence","guru intelligence"];
			GameConfig.turnFlag = DefaultConstants.FLAG_RED;
			GameConfig.chessPieceManager = new ThoChessPieceManager();
			GameConfig.gameStateManager.start();
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}
	
}