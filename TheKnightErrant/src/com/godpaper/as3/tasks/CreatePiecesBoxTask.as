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
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.model.FlexGlobals;
	import com.godpaper.starling.views.components.PiecesBox;
	
	import flash.geom.Rectangle;
	
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
			var bluePiecesBox:PiecesBox = new PiecesBox();
			bluePiecesBox.x = 20;
			bluePiecesBox.y = 380;
			bluePiecesBox.width = 100;
			bluePiecesBox.height = 100;
			bluePiecesBox.background = BoardConfig.piecesBoxBgImage;
			bluePiecesBox.childrenArea = new Rectangle(20,0,25,25);
			bluePiecesBox.type = DefaultConstants.BLUE;
			bluePiecesBox.useHandCursor = true;
			//
			var redPiecesBox:PiecesBox = new PiecesBox();
			redPiecesBox.x = 220;
			redPiecesBox.y = 380;
			redPiecesBox.width = 100;
			redPiecesBox.height = 100;
			redPiecesBox.background = BoardConfig.piecesBoxBgImage;
			redPiecesBox.childrenArea = new Rectangle(20,0,25,25);
			redPiecesBox.type = DefaultConstants.RED;
			//
			FlexGlobals.gameStage.addChild(bluePiecesBox);
			FlexGlobals.gameStage.addChild(redPiecesBox);
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