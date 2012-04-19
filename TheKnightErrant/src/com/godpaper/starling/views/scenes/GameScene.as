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
package com.godpaper.starling.views.scenes
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import assets.DefaultEmbededAssets;
	
	import com.emibap.textureAtlas.DynamicAtlas;
	import com.godpaper.as3.utils.MathUtil;
	import com.godpaper.starling.views.components.ChessPiece;
	
	import pl.mateuszmackowiak.visuals.CursorManager;
	
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;

	/**
	 * Game.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Apr 16, 2012 11:01:37 AM
	 */   	 
	public class GameScene extends SceneBase
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
		public function GameScene()
		{
			super();
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
		//
		override protected function onEnter(data:Array):void
		{
			//
			//			CursorManager.setBusyCursor();
			// sound initialization takes a moment, so we prepare them here
			DefaultEmbededAssets.prepareSounds();
			DefaultEmbededAssets.loadBitmapFonts();
			//VisualElement test.
			var bg:Image = new Image(DefaultEmbededAssets.getTexture("Background"));
			addChild(bg);
			//
			for(var i:int=0;i<100;i++)
			{
				var cp:ChessPiece = new ChessPiece(DefaultEmbededAssets.getTexture("RED_MARSHAL"));
				addChild(cp);
				cp.x = MathUtil.transactRandomNumberInRange(10,300);
				cp.y = MathUtil.transactRandomNumberInRange(10,460);
			}
			//
			//			var redMarshallMC:Class = new DefaultEmbededAssets.RED_MARSHAL();
			//			var atlas:TextureAtlas = DynamicAtlas.fromMovieClipContainer(redMarshallMC, .5, 0, true, true);
			//			var redMarshall:MovieClip = new MovieClip(atlas.getTextures("boy"), 60);
			//			addChild(redMarshall);
		}
		//
		override protected function onExit(data:Array):void
		{
			//
		}
		//
		override protected function onResize(data:Array):void
		{
			//
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}
	
}