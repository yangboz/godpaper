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
package com.godpaper.cat_and_mouse.view.components
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.emibap.textureAtlas.DynamicAtlas;
	import com.godpaper.as3.configs.BoardConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.core.IChessBoard;
	import com.godpaper.as3.utils.LogUtil;
	import com.godpaper.as3.utils.MathUtil;
	import com.godpaper.as3.views.components.ChessBoard;
	import com.godpaper.as3.views.components.ChessPiece;
	
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	import mx.logging.ILogger;
	
	import pl.mateuszmackowiak.visuals.CursorManager;
	
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.Color;
	import starling.utils.Polygon;
	
	/**
	 * ChessBoard_CatAndMouse.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Jun 29, 2012 12:55:50 PM
	 */   	 
	public class ChessBoard_CatAndMouse extends ChessBoard
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(ChessBoard_CatAndMouse);
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
		public function ChessBoard_CatAndMouse(background:Image)
		{
			//TODO: implement function
			super(background);
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
		override protected function backgroundRender():void
		{
			//Temp graphic objects tests.
			//@see:http://wiki.starling-framework.org/manual/dynamic_textures
			//Polygon
			//			var polygon:Polygon = new Polygon(50,4,Color.NAVY);
			//			polygon.x = 100;
			//			polygon.y = 100;
			//			polygon.pivotX = 0;
			//			polygon.pivotY = 0;
			////			polygon.rotation = 30;
			//			addChild(polygon);
			//Put on lines if neccessray.
			var shape:Shape = new Shape();
			shape.graphics.beginFill(Color.BLACK);
			//graphics.drawPath method takes two parameters: 
			//a Vector of coordinates of consecutive points on the path and a Vector of commands. 
			//(The last optional parameter 'winding' is not relevant to our experiment.) 
			//We create the Vector variables.
			//We will draw black lines of thickness 1 and alpha 1.
			shape.graphics.lineStyle(1,Color.GRAY,1);
			//			var drawCoords:Vector.<Number> = new Vector.<Number>();
			//			var drawCommands:Vector.<int> = new Vector.<int>();
			/*
			We populate Vectors to be used with the drawPath method. In the Vector of commands, 1 correponds to moveTo, 2 corresponds to lineTo. Thus, the Vector of commands is: moveTo, lineTo, moveTo, and lineTo. Then, we call the drawPath method. The upper right cross is drawn. The intersection is not correct and it does not correspond to an overlap of two transparent objects.
			*/
			//			drawCoords.push(100,10);
			//			drawCommands.push(1);
			//			drawCoords.push(200,10);
			//			drawCommands.push(2);
			//
			//			shape.graphics.drawCircle(50, 50, 30);
			//			shape.graphics.drawPath(drawCommands,drawCoords);
			//Just using the simply line drawing func.
			shape.graphics.moveTo(this.xAdjust,this.yAdjust);
			//
			//			shape.graphics.lineTo(10,150);
			//			shape.graphics.moveTo(60,10);
			//			shape.graphics.lineTo(60,150);
			//			shape.graphics.moveTo(110,10);
			//Draw x lines
			for(var j:int=0;j<this.yLines;j++)
			{
				var lX:Number = this.xAdjust+j*this.xOffset;
				var lY:Number = this.yAdjust+(this.yLines-1)*this.yOffset;
				var mX:Number = this.xAdjust+(j+1)*this.xOffset;
				var mY:Number = this.yAdjust;
				LOG.debug("xLines drawing:{0},{1},{2},{3}",lX,lY,mX,mY);
				shape.graphics.lineTo(lX,lY);
				shape.graphics.moveTo(mX,mY);
			}
			//Go back to the start point.
			shape.graphics.moveTo(this.xAdjust,this.yAdjust);
			//Draw y lines
			for(var i:int=0;i<this.xLines;i++)
			{
				var lXx:Number = (this.xLines-1)*this.xOffset+this.xAdjust;
				var lYy:Number = this.yAdjust+i*this.yOffset;
				var mXx:Number = this.xAdjust;
				var mYy:Number = this.yAdjust+(i+1)*this.yOffset;
				LOG.debug("yLines drawing:{0},{1},{2},{3}",lXx,lYy,mXx,mYy);
				shape.graphics.lineTo(lXx,lYy);
				shape.graphics.moveTo(mXx,mYy);
			}
			shape.graphics.endFill();
			//But we can draw that shape into a bitmap and then create a texture from that bitmap! 
			var bmpData:BitmapData = new BitmapData(BoardConfig.width, BoardConfig.height, true, 0x0);
			bmpData.draw(shape);
			//
			var texture:Texture = Texture.fromBitmapData(bmpData);
			var image:Image = new Image(texture);
			addChild(image);
			//The we get the actual width/height properties.
			LOG.debug("ChessBoard size:{0},{1}",this.width,this.height);
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}
	
}