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
package com.godpaper.starling.views.popups
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.configs.GameConfig;
	import com.godpaper.as3.configs.IndicatorConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.model.FlexGlobals;
	import com.godpaper.as3.plugins.IPlug;
	
	import org.josht.starling.foxhole.controls.Button;
	import org.josht.starling.foxhole.controls.Screen;
	import org.josht.starling.foxhole.controls.ScreenHeader;
	import org.josht.starling.foxhole.controls.ScrollContainer;
	import org.josht.starling.foxhole.controls.TextInput;
	import org.josht.starling.foxhole.layout.HorizontalLayout;
	import org.josht.starling.foxhole.layout.VerticalLayout;
	
	
	/**
	 * Callout/popup view component that indicated the human win status.  	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Jun 20, 2012 4:23:56 PM
	 */   	 
	public class HumanWinIndicatory extends Screen
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var _header:ScreenHeader;
		private var _nameInput:TextInput;
		private var _scoreInput:TextInput;
		private var _inputsContainer:ScrollContainer;
		private var _buttonsContainer:ScrollContainer;
		private var _submitBtn:Button;//submit score button.
		private var _nextBtn:Button;//next round button.
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
		public function HumanWinIndicatory()
		{
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
		override protected function initialize():void
		{
			//view initialize.
			//
			this._header = new ScreenHeader();
			this._header.title = DefaultConstants.INDICATION_HUMAN_WIN;
			this.addChild(this._header);
			//layouts
			const hLayout:HorizontalLayout = new HorizontalLayout();
			hLayout.gap = 0;
			hLayout.paddingTop = 0;
			hLayout.paddingRight = 0;
			hLayout.paddingBottom = 0;
			hLayout.paddingLeft = 0;
			hLayout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_LEFT;
			hLayout.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_TOP;
			const vLayout:VerticalLayout = new VerticalLayout();
			vLayout.gap = 0;
			vLayout.paddingTop = 0;
			vLayout.paddingRight = 0;
			vLayout.paddingBottom = 0;
			vLayout.paddingLeft = 0;
			vLayout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_LEFT;
			vLayout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_TOP;
			//containers
			this._inputsContainer = new ScrollContainer();
			this._inputsContainer.layout = vLayout;
			this.addChild(this._inputsContainer);
			this._buttonsContainer = new ScrollContainer();
			this._buttonsContainer.layout = hLayout;
			this.addChild(this._buttonsContainer);
			//text inputs
			this._nameInput = new TextInput();
			this._scoreInput = new TextInput();
			this._scoreInput.isEnabled = false;
			this._inputsContainer.addChild(this._nameInput);
			this._inputsContainer.addChild(this._scoreInput);
			//buttons 
			this._submitBtn = new Button();
			this._submitBtn.label = "SUBMIT";
			this._submitBtn.width = this._submitBtn.height = (44 + 88 * Math.random()) * this.dpiScale;
			this._buttonsContainer.addChild(this._submitBtn);
			this._nextBtn = new Button();
			this._nextBtn.label = "NEXT";
			this._nextBtn.width = this._nextBtn.height = (44 + 88 * Math.random()) * this.dpiScale;
			this._buttonsContainer.addChild(this._nextBtn);
			//event listener
			this._submitBtn.onRelease.add(submitButtonOnRelease);
			this._nextBtn.onRelease.add(nextButtonOnRelease);
			//Default iPlug trigger.
			iPlug.saveData({"boardID": null});
			//				MochiScores.setBoardID(PluginConfig.mochiBoardID);
			//
		}
		//
		override protected function draw():void
		{
			this._header.width = this.actualWidth;
			this._header.validate();
			//
			this._nameInput.validate();
			this._nameInput.x = (this.actualWidth - this._nameInput.width) / 2;
			this._nameInput.y = (this.actualHeight - this._nameInput.height) / 2;
		}
		//
		protected function get currentScore():int
		{
			return (GameConfig.tollgates[GameConfig.gameStateManager.level].score);
		}
		
		//
		protected function get hasNextRound():Boolean
		{
			return GameConfig.gameStateManager.level < GameConfig.tollgates.length-1;
		}
		
		//
		protected function get iPlug():IPlug
		{
			return IPlug(FlexGlobals.topLevelApplication.pluginUIComponent.provider);
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		//
		private function submitButtonOnRelease(button:Button):void
		{
			//
			iPlug.submitData(Number(_scoreInput.text));
			//				mochiModel.score.addValue(Number(scoreTextInput.text));
			//
			iPlug.showLeaderboard(
				{
					score: Number(_scoreInput.text),
					name: _nameInput.text
				}
			);
			//				MochiScores.showLeaderboard(
			//					{   res: FlexGlobals.topLevelApplication.width.toString().concat(
			//						"x",FlexGlobals.topLevelApplication.height), 
			//						clip: FlexGlobals.topLevelApplication._mochiClip, 
			//						score: mochiModel.score.value,
			//						name: nameTextInput.text
			//					}
			//					);
			//
			GameConfig.gameStateManager.restart();
		}
		//
		private function nextButtonOnRelease(button:Button):void
		{
			//
			GameConfig.gameStateManager.restart();
			//increase intelligence level.
			GameConfig.gameStateManager.level++;
			//AS3 signal to broad cast the chess check message.
			FlexGlobals.levelUpSignal.dispatch(GameConfig.gameStateManager.level);
		}
	}
	
}