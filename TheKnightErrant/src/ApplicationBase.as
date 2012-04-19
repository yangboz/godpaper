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
	import com.adobe.cairngorm.task.SequenceTask;
	import com.godpaper.as3.configs.GameConfig;
	import com.godpaper.as3.configs.PieceConfig;
	import com.godpaper.as3.consts.FlexGlobals;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.plugins.PluginUIComponent;
	import com.godpaper.starling.views.scenes.GameScene;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	
	import org.osflash.signals.Signal;
	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;
	import org.spicefactory.lib.task.SequentialTaskGroup;
	import org.spicefactory.lib.task.Task;
	import org.spicefactory.parsley.core.context.Context;
	import org.spicefactory.parsley.core.events.ContextEvent;
	import org.spicefactory.parsley.flash.logging.FlashLoggingXmlSupport;
	import org.spicefactory.parsley.xml.XmlContextBuilder;
	
	import starling.core.Starling;

	/**
	 * ApplicationBase.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Apr 12, 2012 9:38:56 AM
	 */   	 
	[SWF(frameRate="60", width="320", height="480", backgroundColor="0x666666")]//Default swf metadata.
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
		//
		public var pluginUIComponent:PluginUIComponent;
		//
		private var mStarling:Starling;
		//Tasks
		public var cleanUpSequenceTask:SequentialTaskGroup;
		//Signasl
		public var resizeSig:Signal;//stage resize signal.
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:Logger = LogContext.getLogger(ApplicationBase);
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
		/**
		 * This app's context for Parsley.
		 */
		protected var mainContext:Context;
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
			super();
			//
			LOG.debug("preinitializeHandler@Constructor");
			preinitializeHandler();
			//
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			//
			Starling.multitouchEnabled = true; // useful on mobile devices
			Starling.handleLostContext = true; // deactivate on mobile devices (to save memory)
			//
			mStarling = new Starling(GameScene, stage,new Rectangle(0,0,320,480));
			mStarling.simulateMultitouch = true;
			mStarling.enableErrorChecking = false;
			mStarling.start();
			// loader info.
			this.loaderInfo.addEventListener(Event.COMPLETE, loaderInfo_completeHandler);
			// add to stage.
			this.addEventListener(Event.ADDED_TO_STAGE,addToStageHandler);
			// this event is dispatched when stage3D is set up
			stage.stage3Ds[0].addEventListener(Event.CONTEXT3D_CREATE, onContextCreated);
			// signals initialization.
			this.resizeSig = new Signal(Object);
			
		} 
		//
		private function loaderInfo_completeHandler(event:Event):void
		{
			LOG.debug("creationCompleteHandler@loaderInfo_complete");
			//
			this.stage.addEventListener(Event.RESIZE, stage_resizeHandler, false, 0, true);
			//
			creationCompleteHandler();
		}
		//
		private function stage_resizeHandler(event:Event):void
		{
			LOG.debug("stage_resizeHandler");
			const viewPort:Rectangle = this.mStarling.viewPort;
			viewPort.width = this.stage.stageWidth;
			viewPort.height = this.stage.stageHeight;
			this.mStarling.viewPort = viewPort;
			this.mStarling.stage.stageWidth = this.stage.stageWidth;
			this.mStarling.stage.stageHeight = this.stage.stageHeight;
			//dispatch signal with size.
			this.resizeSig.dispatch([stage.stageWidth,stage.stageHeight]);
		}
		private function addToStageHandler(event:Event):void
		{
			LOG.debug("initializeHandler@addToStage");
			this.removeEventListener(Event.ADDED_TO_STAGE,addToStageHandler);
			// Parsley initialize
			FlashLoggingXmlSupport.initialize();
			// parsley context
			mainContext = XmlContextBuilder.build("ParsleyConfiguration.xml");
			mainContext.addEventListener(ContextEvent.INITIALIZED, contextEventInitializedHandler);
			//
			initializeHandler();
			//Store this reference to FlexGlobals.topLevelApplication
			FlexGlobals.topLevelApplication = this;
		}
		/**
		 * Handler for Parsley ContextEvent.INITIALIZED event.
		 */
		private function contextEventInitializedHandler(event:ContextEvent):void
		{    
			LOG.debug("contextEventInitializedHandler(...)");
			mainContext.removeEventListener(ContextEvent.INITIALIZED, contextEventInitializedHandler);
			// Add in the views.
		}        
		//
		private function onContextCreated(event:Event):void
		{
			LOG.debug("applicationCompleteHandler@onContextCreated");
			// set framerate to 30 in software mode
			if (Starling.context.driverInfo.toLowerCase().indexOf("software") != -1)
				Starling.current.nativeStage.frameRate = 30;
			//
			applicationCompleteHandler();
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
			
		}
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		//		application1_preinitializeHandler
		/**
		 * All kinds of view components initialization here.
		 *
		 * @param event
		 *
		 */		
		protected function preinitializeHandler():void
		{
			//config initialization here.
			//				BoardConfig.xLines = 9;
			//				BoardConfig.yLines = 10;
			//				BoardConfig.xOffset = 50;
			//				BoardConfig.yOffset = 50;
		}
		//application1_initializeHandler
		/**
		 * Game initialization here.
		 *
		 * @param event
		 *
		 */		
		protected function initializeHandler():void
		{
			//number of tollgate tips would be matched with tollgates!
			//				GameConfig.tollgates = [RandomWalk,ShortSighted,AttackFalse,AttackFalse,MiniMax];
			//				GameConfig.tollgateTips = ["baby intelligence","fellow intelligence","man intelligence","guru intelligence"];
			//				GameConfig.turnFlag = CcjConstants.FLAG_RED;
		}
		//  application1_creationCompleteHandler
		/**
		 * View(chess pieces/gaskets) components initialization here.
		 *
		 * @param event
		 *
		 */		
		protected function creationCompleteHandler():void
		{
			//			//create chess gaskets.
			//			//create chess piece
			//			//create chess pieces' chessVO;
			//			//create chess pieces' omenVO;
			//			this.startUpSequenceTask.start();
			//			//init data struct.@see ChessPieceModel dump info.
			//			this.dumpFootSprint();
			//Add version control context menu.
//			VersionController.getInstance(this);
		}
		//  application1_applicationCompleteHandler
		/**
		 * Game application start up here.
		 *
		 * @param event
		 *
		 */		
		protected function applicationCompleteHandler():void
		{
			//GameManager start.
			GameConfig.gameStateManager.start();
			//
//			LOG.info("redPieces:{0}", ChessPiecesModel.getInstance().redPieces.dump());
//			LOG.info("bluePieces:{0}", ChessPiecesModel.getInstance().bluePieces.dump());
//			LOG.info("allPieces:{0}", ChessPiecesModel.getInstance().allPieces.dump());
//			//
//			LOG.info("allPieces rotate90:{0}", ChessPiecesModel.getInstance().allPieces.rotate90().dump());
//			LOG.info("allPieces rotate90.bitCount:{0}", ChessPiecesModel.getInstance().allPieces.bitCount);
//			LOG.info("allPieces rotate90.cellCount:{0}", ChessPiecesModel.getInstance().allPieces.cellCount);
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}
	
}