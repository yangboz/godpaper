package com.godpaper.as3.tasks
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.configs.BoardConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.consts.DefaultPiecesConstants;
	import com.godpaper.as3.core.FlexGlobals;
	import com.godpaper.as3.core.IChessFactory;
	import com.godpaper.as3.core.IChessPiece;
	import com.godpaper.as3.model.ChessGasketsModel;
	import com.godpaper.as3.views.components.ChessGasket;
	import com.godpaper.as3.views.components.ChessPiece;
	
	import flash.geom.Point;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import starling.display.DisplayObject;

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
			if(factory)
			{
				this.factory = factory;
			}
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
//						FlexGlobals.gameStage.addChild(cpDisplayObject);
						FlexGlobals.gameScreen.addChild(cpDisplayObject);
//						trace("index:",vv*CcjConstants.BOARD_V_LINES+hh);
//						var ecGasket:ChessGasket = ChessGasketsModel.getInstance().gaskets.gett(hh,vv) as ChessGasket;
						var ecGasket:ChessGasket = FlexGlobals.chessGasketsModel.gaskets.gett(hh,vv) as ChessGasket;
						ecGasket.chessPiece = iChessPiece;
						//
						(iChessPiece as DisplayObject).x = ecGasket.x;
						(iChessPiece as DisplayObject).y = ecGasket.y;
//						(iChessPiece as DisplayObject).x = 0;
//						(iChessPiece as DisplayObject).y = 0;
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
	}

}

