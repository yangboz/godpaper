package
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.adobe.cairngorm.contract.Contract;
	import com.godpaper.as3.configs.GameConfig;
	import com.godpaper.as3.model.ChessPiecesModel;

	import flash.display.MovieClip;

	import mx.events.FlexEvent;

	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;
	import org.spicefactory.lib.task.SequentialTaskGroup;
	import org.spicefactory.parsley.flex.tag.builder.ContextBuilderTag;
	import org.spicefactory.parsley.popup.CairngormPopUpSupport;

	import spark.components.Application;

	/**
	 * Abstract all kinds of board game initialization logic as a template to take a stand.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jan 27, 2011 2:47:41 PM
	 */   	 
	public class ApplicationBase extends Application
	{		
		//Keep this reference for flex library project generation.
		SequentialTaskGroup;
		CairngormPopUpSupport;
		ContextBuilderTag;
		Contract;//for pre-condition compile;
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//Mochi media support.
		public var _mochiClip:MovieClip;
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

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function ApplicationBase()
		{
			//TODO: implement function
			super();

			//
			this.addEventListener(FlexEvent.PREINITIALIZE,preinitializeHandler);
			this.addEventListener(FlexEvent.INITIALIZE,initializeHandler);
			this.addEventListener(FlexEvent.CREATION_COMPLETE,creationCompleteHandler);
			this.addEventListener(FlexEvent.APPLICATION_COMPLETE,applicationCompleteHandler);
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
		protected function preinitializeHandler(event:FlexEvent):void
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
		protected function initializeHandler(event:FlexEvent):void
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
		protected function creationCompleteHandler(event:FlexEvent):void
		{
//			// TODO Auto-generated method stub
//			//create chess gaskets.
//			//create chess piece
//			//create chess pieces' chessVO;
//			//create chess pieces' omenVO;
//			this.startUpSequenceTask.start();
//			//init data struct.@see ChessPieceModel dump info.
//			this.dumpFootSprint();
		}
		//  application1_applicationCompleteHandler
		/**
		 * Game application start up here.
		 *
		 * @param event
		 *
		 */		
		protected function applicationCompleteHandler(event:FlexEvent):void
		{
			// TODO Auto-generated method stub
			//GameManager start.
			GameConfig.gameStateManager.start();
			//
			LOG.info("redPieces:{0}", ChessPiecesModel.getInstance().redPieces.dump());
			LOG.info("bluePieces:{0}", ChessPiecesModel.getInstance().bluePieces.dump());
			LOG.info("allPieces:{0}", ChessPiecesModel.getInstance().allPieces.dump());
			//
			LOG.info("allPieces rotate90:{0}", ChessPiecesModel.getInstance().allPieces.rotate90().dump());
			LOG.info("allPieces rotate90.bitCount:{0}", ChessPiecesModel.getInstance().allPieces.bitCount);
			LOG.info("allPieces rotate90.cellCount:{0}", ChessPiecesModel.getInstance().allPieces.cellCount);
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}

}

