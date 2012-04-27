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
package com.godpaper.starling.views.components
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import assets.DefaultEmbededAssets;
	
	import com.emibap.textureAtlas.DynamicAtlas;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.core.IChessBoard;
	import com.godpaper.as3.utils.MathUtil;
	import com.godpaper.starling.views.components.ChessPiece;
	
	import pl.mateuszmackowiak.visuals.CursorManager;
	
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;
	
	/**
	 * A chess board is defined by a number of rows and columns, which may vary for different application levels.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Apr 18, 2012 10:01:04 AM
	 */   	 
	public class ChessBoard extends Sprite implements IChessBoard
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var _rows:Number;
		private var _columns:Number;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		//
		public function get rows():Number
		{
			return _rows;
		}
		
		public function set rows(value:Number):void
		{
			_rows = value;
		}
		//
		public function get columns():Number
		{
			return _columns;
		}
		
		public function set columns(value:Number):void
		{
			_columns = value;
		}
		//----------------------------------
		//  type(BitBoard,NumberBoard,GraphBoard,ArrayBoard...)
		//----------------------------------
		private var _type:String;
		
		public function get type():String
		{
			return _type;
		}
		
		public function set type(value:String):void
		{
			_type=value;
		}
		//----------------------------------
		//  background(BitBoard,NumberBoard,GraphBoard,ArrayBoard...)
		//----------------------------------
		private var _background:Image;
		
		public function get background():Image
		{
			return _background;
		}
		
		public function set background(value:Image):void
		{
			_background=value;
			//Remove the existed background at first.
			if(_background!=null)
			{
				removeChild(_background);
			}
			addChild(_background);
		}
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
		public function ChessBoard(width:Number=320,height:Number=480)
		{
			super();
			//VisualElement process.
			//Puts on background image.
//			var bg:Image = new Image(DefaultEmbededAssets.getTexture(DefaultConstants.IMG_BACK_GROUND));
//			addChild(bg);
			//Put on lines if neccessray.
			
			//Puts on chess gaskets
			
//			Puts on chess pieces
//			var atlas:TextureAtlas = DefaultEmbededAssets.getTextureAtlas();
//			for(var i:int=0;i<100;i++)
//			{
//				var cp:ChessPiece = new ChessPiece(atlas.getTexture(DefaultConstants.BLUE_KNIGHT));
////				var cp:Image = new Image(atlas.getTexture(DefaultConstants.BLUE_BISHOP));
//				addChild(cp);
//				cp.x = MathUtil.transactRandomNumberInRange(0,width);
//				cp.y = MathUtil.transactRandomNumberInRange(0,height);
//			}
			//
			
			//
			//			var redMarshallMC:Class = new DefaultEmbededAssets.RED_MARSHAL();
			//			var atlas:TextureAtlas = DynamicAtlas.fromMovieClipContainer(redMarshallMC, .5, 0, true, true);
			//			var redMarshall:MovieClip = new MovieClip(atlas.getTextures("boy"), 60);
			//			addChild(redMarshall);
			
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
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}
	
}