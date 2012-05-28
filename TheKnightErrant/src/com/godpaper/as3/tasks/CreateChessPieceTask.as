package com.godpaper.as3.tasks
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.adobe.cairngorm.task.Task;
	import com.godpaper.as3.business.factory.ChessFactoryBase;
	import com.godpaper.as3.configs.BoardConfig;
	import com.godpaper.as3.consts.FlexGlobals;
	import com.godpaper.as3.core.IChessFactory;
	import com.godpaper.as3.core.IChessPiece;
	import com.godpaper.as3.model.ChessGasketsModel;
	import com.godpaper.starling.views.components.ChessGasket;
	import com.godpaper.starling.views.components.ChessPiece;
	
	import flash.geom.Point;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import starling.display.DisplayObject;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	/**
	 * ChessTaskBase.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Nov 30, 2010 12:00:05 PM
	 */   	 
	public class CreateChessPieceTask extends ChessTaskBase
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

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
		public function CreateChessPieceTask(factory:Class=null)
		{
			super();
			//Set properties
			this.label = "CreateChessPieceTask";
			//
			this.factory = factory;
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------

		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		override protected function performTask():void
		{
			var className:String = getQualifiedClassName(factory);
			var implementation:Object = getDefinitionByName(className);
			var realFactoy:IChessFactory  = new implementation();
			//create chess piece
			for(var hh:int=0;hh<BoardConfig.xLines;hh++)
			{
				for(var vv:int=0;vv<BoardConfig.yLines;vv++)
				{
					var iChessPiece:IChessPiece = realFactoy.createChessPiece(new Point(hh,vv));
					var cpDisplayObject:DisplayObject = DisplayObject(iChessPiece);
					//
					if(iChessPiece!=null)
					{
						FlexGlobals.gameStage.addChild(cpDisplayObject);
//						trace("index:",vv*CcjConstants.BOARD_V_LINES+hh);
						var ecGasket:ChessGasket = ChessGasketsModel.getInstance().gaskets.gett(hh,vv) as ChessGasket;
//						ecGasket.chessPiece = iChessPiece;
//						ecGasket.addElement( iChessPiece );
//						ecGasket.addChild(cpDisplayObject);
						//
						(iChessPiece as DisplayObject).x = ecGasket.x;
						(iChessPiece as DisplayObject).y = ecGasket.y;
//						(iChessPiece as DisplayObject).x = 0;
//						(iChessPiece as DisplayObject).y = 0;
						//
//						cpDisplayObject.addEventListener(TouchEvent.TOUCH, touchHandler); 
					}
				}
			}
			//
			this.complete();
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		//
		private function touchHandler(event : TouchEvent) : void 
		{
			var touch:Touch = event.getTouch(FlexGlobals.gameStage);
			var position:Point = touch.getLocation(FlexGlobals.gameStage);
			var target:ChessPiece = event.target as ChessPiece;
			//
			if(touch.phase == TouchPhase.MOVED ){
				target.x = position.x - target.width/2;
				target.y = position.y - target.height/2;
			}
		}
	}

}

