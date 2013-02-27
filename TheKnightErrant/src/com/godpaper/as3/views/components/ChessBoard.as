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
package com.godpaper.as3.views.components
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
	 * A chess board is defined by a number of rows and columns, which may vary for different application levels.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Apr 18, 2012 10:01:04 AM
	 * @see http://wiki.starling-framework.org/manual/dynamic_textures
	 */   	 
	public class ChessBoard extends VisualElement implements IChessBoard
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//global board config.
		private var _xLines:Number;
		private var _yLines:Number;
		//board scale
		private var _xScale:Number;
		private var _yScale:Number;
		//board lattic
		private var _xOffset:Number;
		private var _yOffset:Number;
		//board size
//		private var _width:Number;//Native
//		private var _height:Number;//Native
		//board background
		//		private static var _backGround:Class;
		//board x,y position adjust
		private var _xAdjust:Number;
		private var _yAdjust:Number;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		//
		private static const LOG:ILogger = LogUtil.getLogger(ChessBoard);
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		//----------------------------------
		//  yAdjust(for pixel adjustment at y axis)
		//----------------------------------
		public function get yAdjust():Number
		{
			return _yAdjust;
		}
		/**
		 * @param value the user defined value(in pixel) for y-axis based position ajustment.
		 */
		public function set yAdjust(value:Number):void
		{
			_yAdjust = value;
		}
		//----------------------------------
		//  xAdjust(for pixel adjustment at x axis)
		//----------------------------------
		public function get xAdjust():Number
		{
			return _xAdjust;
		}
		/**
		 * @param value the user defined value(in pixel) for x-axis based position ajustment.
		 */
		public function set xAdjust(value:Number):void
		{
			_xAdjust = value;
		}
		//----------------------------------
		//  yOffset(the lattice of ChessBoard at y axis)
		//----------------------------------
		public function get yOffset():Number
		{
			return _yOffset;
		}
		
		public function set yOffset(value:Number):void
		{
			_yOffset = value;
		}
		//----------------------------------
		//  xOffset(the lattice of ChessBoard at x axis)
		//----------------------------------
		public function get xOffset():Number
		{
			return _xOffset;
		}
		
		public function set xOffset(value:Number):void
		{
			_xOffset = value;
		}
		//----------------------------------
		//  yScale(the scale rate of ChessBoard at y axis)
		//----------------------------------
		public function get yScale():Number
		{
			return _yScale;
		}
		
		public function set yScale(value:Number):void
		{
			_yScale = value;
		}
		//----------------------------------
		//  xScale(the scale rate of ChessBoard at x axis)
		//----------------------------------
		public function get xScale():Number
		{
			return _xScale;
		}
		
		public function set xScale(value:Number):void
		{
			_xScale = value;
		}
		//----------------------------------
		//  yLines(the number of lines displayed on ChessBoard at y axis)
		//----------------------------------
		public function get yLines():Number
		{
			return _yLines;
		}
		
		public function set yLines(value:Number):void
		{
			_yLines = value;
		}
		//----------------------------------
		//  xLines(the number of lines displayed on ChessBoard at x axis)
		//----------------------------------
		public function get xLines():Number
		{
			return _xLines;
		}
		
		public function set xLines(value:Number):void
		{
			_xLines = value;
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
		//  background(CrossLines or Embbed image textures)
		//----------------------------------
		private var _background:Image = null;
		
		public function get background():Image
		{
			return _background;
		}
		
		public function set background(value:Image):void
		{
			if(value!=null)
			{
				if(this.contains(_background))
				{
					removeChild(_background);//Remove the existed background at first.
				}
				//set anew value
				_background=value;
				//Puts on background image.
				//			var bg:Image = new Image(DefaultEmbededAssets.getTexture(DefaultConstants.IMG_BACK_GROUND));
				//			addChild(bg);
				//Display anew backgournd
				addChild(_background);
			}
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
		public function ChessBoard(background:Texture=null)
		{
			//Binding to the global configured variables
			var typeOfCheckering:Boolean = (BoardConfig.type==DefaultConstants.CHESS_BOARD_TYPE_CHECKERING);
			this.xLines = typeOfCheckering?(BoardConfig.xLines+1):BoardConfig.xLines;//Chess board type adjust
			this.yLines = typeOfCheckering?(BoardConfig.yLines+1):BoardConfig.yLines;//Chess board type adjust
			this.xScale = BoardConfig.xScale;
			this.yScale = BoardConfig.yScale;
			this.xOffset = BoardConfig.xOffset;
			this.yOffset = BoardConfig.yOffset;
			//Does't work,the actual width and height changed every enterframe after the board added to stage.
//			this.width = BoardConfig.width;
//			this.height = BoardConfig.height;
			this.xAdjust = BoardConfig.xAdjust;
			this.yAdjust = BoardConfig.yAdjust;
			//
			super(background);
			//
			this.touchable = false;
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		override public function toString():String
		{
			return "ChessBoard".concat(",lines(",this.xLines,",",this.yLines,")");
		}
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		override protected function getUpStateTexture(bgColor:uint,bgAlpha:Number,borderColor:uint,borderAlpha:Number):Texture
		{
			if(BoardConfig.backgroundImage)
			{
				return BoardConfig.backgroundImage.texture;
			}
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
//			shape.graphics.beginFill(Color.BLACK);
			shape.graphics.beginFill(bgColor);
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
//				shape.graphics.drawRect(lX, lY, 50, 50);
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
//			var image:Image = new Image(texture);
//			addChild(image);
			//The we get the actual width/height properties.
			LOG.debug("ChessBoard size:{0},{1}",BoardConfig.width,BoardConfig.height);
			return texture;
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}
	
}