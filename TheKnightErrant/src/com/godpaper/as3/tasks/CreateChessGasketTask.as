package com.godpaper.as3.tasks
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.configs.BoardConfig;
	import com.godpaper.as3.configs.GasketConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.core.FlexGlobals;
	import com.godpaper.as3.core.IChessFactory;
	import com.godpaper.as3.core.IVisualElement;
	import com.godpaper.as3.model.ChessGasketsModel;
	import com.godpaper.as3.model.pools.ChessGasketsPool;
	
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import starling.display.DisplayObject;
	

	/**
	 * CreateChessGasketTask.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Nov 30, 2010 11:54:25 AM
	 */   	 
	public class CreateChessGasketTask extends ChessTaskBase
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
		public function CreateChessGasketTask()
		{
			super();
			//Set properties
			this.label = "CreateChessGasketTask";
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
			//put gaskets by chess board type:
			var vMax:int;
			var hMax:int;
			switch(BoardConfig.type)
			{
				case DefaultConstants.CHESS_BOARD_TYPE_SEGMENT:
				case DefaultConstants.CHESS_BOARD_TYPE_FRACTAL:
				case DefaultConstants.CHESS_BOARD_TYPE_INTERSECTION:
					vMax = BoardConfig.yLines;
					hMax = BoardConfig.xLines;
					break;
				case DefaultConstants.CHESS_BOARD_TYPE_CHECKERING:
					vMax = BoardConfig.yLines-1;
					hMax = BoardConfig.xLines-1;
					break;
				default:
					break;
			}
			//create chess gaskets.
			for(var v:int=0;v<vMax;v++)
			{
				for(var h:int=0;h<hMax;h++)
				{
					//
					var cGasket:starling.display.DisplayObject = starling.display.DisplayObject(realFactoy.createChessGasket(new Point(h,v)));
					if(cGasket)
					{
						FlexGlobals.gameStage.addChild( cGasket );
						//keep this reference to model.
//						ChessGasketsModel.getInstance().gaskets.sett(h,v,cGasket);
						FlexGlobals.chessGasketsModel.gaskets.sett(h,v,cGasket);
					}
				}
			}
//Notice:make sure the plugin uicomponent at the top of game ui.
			var numChildren:int = FlexGlobals.topLevelApplication.numChildren;
			FlexGlobals.topLevelApplication.setChildIndex(
				FlexGlobals.topLevelApplication.pluginUIComponent,
				numChildren-1
				);
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

