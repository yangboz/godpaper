package com.godpaper.as3.tasks
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.configs.BoardConfig;
	import com.godpaper.as3.configs.GasketConfig;
	import com.godpaper.as3.consts.FlexGlobals;
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
			//create chess gaskets.
			for(var v:int=0;v<BoardConfig.yLines;v++)
			{
				for(var h:int=0;h<BoardConfig.xLines;h++)
				{
					//
					var cGasket:starling.display.DisplayObject = starling.display.DisplayObject(realFactoy.createChessGasket(new Point(h,v)));
					if(cGasket)
					{
						FlexGlobals.gameStage.addChild( cGasket );
						//keep this reference to model.
						ChessGasketsModel.getInstance().gaskets.sett(h,v,cGasket);
					}
				}
			}
//TODO:plugin uicomponent at the top of game ui.
//			var numChildren:int = FlexGlobals.gameStage.numChildren;
//			FlexGlobals.topLevelApplication.setChildIndex(
//				FlexGlobals.topLevelApplication.pluginUIComponent,
//				numChildren-1
//				);
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

