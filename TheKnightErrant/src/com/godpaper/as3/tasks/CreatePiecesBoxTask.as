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
package com.godpaper.as3.tasks
{
	import com.godpaper.as3.configs.BoardConfig;
	import com.godpaper.as3.configs.PluginConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.core.FlexGlobals;
	import com.godpaper.as3.views.components.PiecesBox;
	import com.godpaper.as3.views.plugin.PluginButtonBar;
	
	import flash.geom.Rectangle;
	
	import org.hamcrest.mxml.object.Null;
	
	import starling.display.Image;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * CreatePiecesBoxTask.as class for the boxes(which filled with chess pieces) creation process.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Jun 29, 2012 4:03:28 PM
	 */   	 
	public class CreatePiecesBoxTask extends ChessTaskBase
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
		public function CreatePiecesBoxTask()
		{
			super();
			//Set properties.
			this.label = "CreatePiecesBoxTask";
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
			//TODO:<!-- PiecesBox View -->
//				<components1:PiecesBox id="bluePiecesBox" visible="true" left="20" bottom="50" width="100"
//				height="100"
//				
//				backgroundImageFillMode="scale" borderVisible="false"
//				childrenArea="{new Rectangle(20,0,25,25)}"
//				type="{DefaultConstants.BLUE}"/>
//				<components1:PiecesBox id="redPiecesBox" visible="true" right="20" bottom="50" width="100"
//				height="100"
//				
//				backgroundImageFillMode="scale" borderVisible="false"
//				childrenArea="{new Rectangle(20,0,25,25)}" type="{DefaultConstants.RED}"/>
			var xGap:Number = 20;
			var yGap:Number = 50;
			var childAreaXOffset:Number = 20;
			var childAreaYOffset:Number = 0;
			var childAreaWidth:Number = 25;
			var childAreaHeight:Number = 25;
			var bluePiecesBox:PiecesBox = new PiecesBox();
			bluePiecesBox.width = 100;
			bluePiecesBox.height = 100;
			bluePiecesBox.background = BoardConfig.piecesBoxBgImage;
			bluePiecesBox.childrenArea = new Rectangle(childAreaXOffset,childAreaYOffset,childAreaWidth,childAreaHeight);//Default setting.
			bluePiecesBox.type = DefaultConstants.BLUE;
			//
			FlexGlobals.gameStage.addChild(bluePiecesBox);
			bluePiecesBox.x = xGap;
			bluePiecesBox.y = FlexGlobals.topLevelApplication.stage.stageHeight-PluginConfig.buttonBarHeight - childAreaHeight - yGap;
			//
			var redPiecesBox:PiecesBox = new PiecesBox();
			redPiecesBox.width = 100;
			redPiecesBox.height = 100;
			redPiecesBox.background = BoardConfig.piecesBoxBgImage;
			redPiecesBox.childrenArea = new Rectangle(childAreaXOffset,childAreaYOffset,childAreaWidth,childAreaHeight);//Default setting.
			redPiecesBox.type = DefaultConstants.RED;
			//
			FlexGlobals.gameStage.addChild(redPiecesBox);
			redPiecesBox.x = FlexGlobals.topLevelApplication.stage.stageWidth-redPiecesBox.width - xGap;
			redPiecesBox.y = FlexGlobals.topLevelApplication.stage.stageHeight-PluginConfig.buttonBarHeight - childAreaHeight - yGap;
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