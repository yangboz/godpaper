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
	
	import flash.geom.Rectangle;
	
	import starling.display.Image;
	import starling.textures.TextureAtlas;

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
		private var bluePiecesBox:PiecesBox;
		private var redPiecesBox:PiecesBox;
		private var xGap:Number = 20;
		private var yGap:Number = 50;
		private var childAreaXOffset:Number = 20;
		private var childAreaYOffset:Number = 20;
		private var childAreaWidth:Number = 70;
		private var childAreaHeight:Number = 45;
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
			this.bluePiecesBox = new PiecesBox();
			bluePiecesBox.width = 100;
			bluePiecesBox.height = 70;
			bluePiecesBox.scaleX = 1;
			bluePiecesBox.scaleY = 1;
			var atlas:TextureAtlas = AssetEmbedsDefault.getTextureAtlas_cp();
			bluePiecesBox.background = new Image(atlas.getTexture(PluginConfig.piecesBoxBgBlue));
			bluePiecesBox.childrenArea = new Rectangle(childAreaXOffset,childAreaYOffset,childAreaWidth,childAreaHeight);//Default setting.
			bluePiecesBox.type = DefaultConstants.BLUE;
			//
//			FlexGlobals.gameStage.addChild(bluePiecesBox);
			FlexGlobals.gameScreen.addChild(bluePiecesBox);
			FlexGlobals.bluePiecesBox = bluePiecesBox;//keep ref.
			//
			this.redPiecesBox = new PiecesBox();
			redPiecesBox.width = 100;
			redPiecesBox.height = 70;
			redPiecesBox.scaleX = 1;
			redPiecesBox.scaleY = 1;
			//
			redPiecesBox.background = new Image(atlas.getTexture(PluginConfig.piecesBoxBgRed));
			redPiecesBox.childrenArea = new Rectangle(childAreaXOffset,childAreaYOffset,childAreaWidth,childAreaHeight);//Default setting.
			redPiecesBox.type = DefaultConstants.RED;
			//
//			FlexGlobals.gameStage.addChild(redPiecesBox);
			FlexGlobals.gameScreen.addChild(redPiecesBox);
			FlexGlobals.redPiecesBox = redPiecesBox;//keep ref.
			//do layout if required.
			if(PluginConfig.piecesBoxRequired)
			{
				this.layoutPiecesBox();
			}
			//
			this.complete();
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		private function layoutPiecesBox():void
		{
			switch(PluginConfig.piecesBoxPosition)
			{
				case PluginConfig.PBOX_AT_BOTTOM:
					//
					bluePiecesBox.x = xGap;
					bluePiecesBox.y = FlexGlobals.topLevelApplication.stage.stageHeight-2*yGap;
					//
					redPiecesBox.x = FlexGlobals.topLevelApplication.stage.stageWidth-redPiecesBox.width - xGap;
					redPiecesBox.y = FlexGlobals.topLevelApplication.stage.stageHeight-2*yGap;
					break;
				case PluginConfig.PBOX_AT_LEFT:
					//
					bluePiecesBox.x = xGap;
					bluePiecesBox.y = childAreaHeight + yGap;
					//
					redPiecesBox.x = xGap;
					redPiecesBox.y = FlexGlobals.topLevelApplication.stage.stageHeight - 2*yGap;
					break;
				case PluginConfig.PBOX_AT_RIGHT:
					//
					bluePiecesBox.x = FlexGlobals.topLevelApplication.stage.stageWidth - xGap - bluePiecesBox.width;
					bluePiecesBox.y = yGap;
					//
					redPiecesBox.x = FlexGlobals.topLevelApplication.stage.stageWidth - xGap - redPiecesBox.width;
					redPiecesBox.y = FlexGlobals.topLevelApplication.stage.stageHeight - 3*yGap;
					break;
				case PluginConfig.PBOX_AT_TOP:
					//
					bluePiecesBox.x = xGap;
					bluePiecesBox.y = childAreaHeight + yGap;
					//
					redPiecesBox.x = FlexGlobals.topLevelApplication.stage.stageWidth-redPiecesBox.width - xGap;
					redPiecesBox.y = childAreaHeight + yGap;
					break;
				default:
					break;
			}
		}
	}
	
}