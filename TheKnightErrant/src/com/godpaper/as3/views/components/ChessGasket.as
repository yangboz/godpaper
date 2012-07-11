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
	
	import com.godpaper.as3.configs.BoardConfig;
	import com.godpaper.as3.configs.GameConfig;
	import com.godpaper.as3.configs.GasketConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.core.FlexGlobals;
	import com.godpaper.as3.core.IChessGasket;
	import com.godpaper.as3.core.IChessPiece;
	import com.godpaper.as3.model.ChessGasketsModel;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.utils.LogUtil;
	import com.lookbackon.ds.BitBoard;
	
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import mx.logging.ILogger;
	import mx.utils.UIDUtil;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.Color;
	import starling.utils.Polygon;
	
	
	/**
	 * The chess gasket stores chess pieces, and each chess gasket’s space can contain more than one chess piece.  	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Apr 18, 2012 9:47:38 AM
	 */   	 
	public class ChessGasket extends VisualElement implements IChessGasket
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var chessGasketsModel:ChessGasketsModel = FlexGlobals.chessGasketsModel;
		private var chessPiecesModel:ChessPiecesModel = FlexGlobals.chessPiecesModel;
		//Global configures.
		private var _width:Number;
		private var _height:Number;
		private var _borderVisible:Boolean;//You'd beter set true for the purpose of debug view.
		private var _backgroundAlpha:Number;
		private var _contentBackgroundAlpha:Number;
		private var _borderAlpha:Number;
		private var _toolTip:String;
		private var _tipsVisible:Boolean;//toolTips
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(ChessGasket);
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		//----------------------------------
		//  position
		//----------------------------------
		private var _position:Point;
		
		public function get position():Point
		{
			return _position;
		}
		
		public function set position(value:Point):void
		{
			_position=value;
		}
		//----------------------------------
		//  chessPiece
		//----------------------------------
		private var _chessPiece:IChessPiece;
		
		public function get chessPiece():IChessPiece
		{
			return _chessPiece;
		}
		
		public function set chessPiece(value:IChessPiece):void
		{
			_chessPiece=value;
			//
//			if (null != value)
//			{
//				this.addChild(value as DisplayObject);
//			}
//			else
//			{
//				this.removeChildAt(0);
//			}
		}
		//----------------------------------
		//  conductVO
		//----------------------------------
		private var _conductVO:ConductVO;
		
		public function get conductVO():ConductVO
		{
			return _conductVO;
		}
		//----------------------------------
		//  X-Ray properties
		//----------------------------------
		//		public function get bottomNode():ChessGasket
		//		{
		//			return chessGasketsModel.gaskets.gett(this.position.x,this.position.y+1) as ChessGasket;
		//		}
		//
		//		public function get rightNode():ChessGasket
		//		{
		//			return chessGasketsModel.gaskets.gett(this.position.x+1,this.position.y) as ChessGasket;
		//		}
		//
		//		public function get upNode():ChessGasket
		//		{
		//			return chessGasketsModel.gaskets.gett(this.position.x,this.position.y-1) as ChessGasket;
		//		}
		//
		//		public function get leftNode():ChessGasket
		//		{
		//			return chessGasketsModel.gaskets.gett(this.position.x-1,this.position.y) as ChessGasket;
		//		}
		//
		//----------Global configures-----------
		//----------------------------------
		//  tipsVisible()
		//----------------------------------
		public function get tipsVisible():Boolean
		{
			return _tipsVisible;
		}
		
		public function set tipsVisible(value:Boolean):void
		{
			_tipsVisible = value;
		}
		//----------------------------------
		//  borderAlpha()
		//----------------------------------
		public function get borderAlpha():Number
		{
			return _borderAlpha;
		}
		
		public function set borderAlpha(value:Number):void
		{
			_borderAlpha = value;
		}
		//----------------------------------
		//  contentBackgroundAlpha()
		//----------------------------------
		public function get contentBackgroundAlpha():Number
		{
			return _contentBackgroundAlpha;
		}
		
		public function set contentBackgroundAlpha(value:Number):void
		{
			_contentBackgroundAlpha = value;
		}
		//----------------------------------
		//  backgroundAlpha()
		//----------------------------------
		public function get backgroundAlpha():Number
		{
			return _backgroundAlpha;
		}
		
		public function set backgroundAlpha(value:Number):void
		{
			_backgroundAlpha = value;
		}
		//----------------------------------
		//  borderVisible()
		//----------------------------------
		public function get borderVisible():Boolean
		{
			return _borderVisible;
		}
		
		public function set borderVisible(value:Boolean):void
		{
			_borderVisible = value;
		}
		//----------------------------------
		//  background
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
		public function ChessGasket(upState:Texture=null, text:String="", downState:Texture=null)
		{
			//Binding the global configures.
			this.backgroundAlpha = GasketConfig.backgroundAlpha;
			this.borderAlpha = GasketConfig.borderAlpha;
			this.borderVisible = GasketConfig.borderVisible;
			this.contentBackgroundAlpha = GasketConfig.contentBackgroundAlpha;
			this.tipsVisible = GasketConfig.tipsVisible;
			var tipText:String = this.tipsVisible?text:"";
			//Default texture setting here.
			var defaultUpState:Texture = upState;
			if(defaultUpState==null)
			{
				defaultUpState = this.getUpStateTexture(Color.BLACK,this.backgroundAlpha,Color.BLACK,this.borderAlpha);
//				var atlas:TextureAtlas = DefaultEmbededAssets.getTextureAtlas();
//				defaultUpState = atlas.getTexture(DefaultConstants.BLUE_BISHOP);
			}
//			this.background = new Image(defaultUpState);
			//
			super(defaultUpState, text, downState);
			//Can not touch.
			this.touchable  = false;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		//dragEnterHandler
		public function dragEnterHandler(event:TouchEvent):Boolean
		{
			//Update conduct value object.
			this._conductVO =new ConductVO();
			_conductVO.target=event.target as IChessPiece;
			_conductVO.previousPosition=(event.target as ChessPiece).position;
			_conductVO.nextPosition=this.position;
			//do move validation
			var validateResult:Boolean = GameConfig.chessPieceManager.doMoveValidation(_conductVO);
			if (validateResult)
			{
				//				DragManager.acceptDragDrop(event.currentTarget as IUIComponent);
				//				DragManager.showFeedback(DragManager.LINK);
				//Update display effect.
//				this.upState.dispose();
//				this.upState = this.getUpStateTexture(Color.GREEN,this.backgroundAlpha,Color.GREEN,this.borderAlpha);
				//Update chess piece reference by UpdateChessPiecesTask.
			}else
			{
				//Update display effect.
//				this.upState.dispose();
//				this.upState = this.getUpStateTexture(Color.RED,this.backgroundAlpha,Color.RED,this.borderAlpha);
			}
			//
			event.stopImmediatePropagation();
			return validateResult;
		}
		//dragOutHandler
		public function dragOutHandler(event:TouchEvent):void
		{
			//Update display effect.
//			this.upState.dispose();
//			this.upState = this.getUpStateTexture(Color.BLACK,this.backgroundAlpha,Color.BLACK,this.borderAlpha);
			//Update chess piece reference by event.target.
			this.chessPiece = null;
			//
			event.stopImmediatePropagation();
		}
		//dragDropHandler
		public function dragDropHandler(event:TouchEvent):void
		{
			this._conductVO=new ConductVO();
			_conductVO.target=event.target as IChessPiece;
			_conductVO.previousPosition=(event.target as ChessPiece).position;
			_conductVO.nextPosition=this.position;
			//apply move.
			GameConfig.chessPieceManager.applyMove(conductVO);
			//
			event.stopImmediatePropagation();
			//
			//clear gasket indicate effect.
			var emptyLegalMoves:BitBoard=new BitBoard(BoardConfig.xLines, BoardConfig.yLines);
			emptyLegalMoves.clear();
			//empty indicate effect.
			GameConfig.chessPieceManager.indicateGasketsMove(emptyLegalMoves);
		}
		//
		override public function toString():String
		{
			return "ChessGasket#".concat("position:",position.toString());
		}
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		//Custom render the texture with the global gasket configuration.
		override protected function getUpStateTexture(bgColor:uint,bgAlpha:Number,borderColor:uint,borderAlpha:Number):Texture
		{
			//Temp graphic objects tests.
			//@see:http://wiki.starling-framework.org/manual/dynamic_textures
//			Polygon
//			var polygon:Polygon = new Polygon(50,4,Color.NAVY);
//			polygon.x = 100;
//			polygon.y = 100;
//			polygon.pivotX = 0;
//			polygon.pivotY = 0;
//			polygon.rotation = 30;
//			addChild(polygon);
			//Draw a circle shape
			var shape:Sprite = new Sprite();
//			var shape:Shape = new Shape();
			shape.graphics.beginFill(bgColor,bgAlpha);
			shape.graphics.lineStyle(1,borderColor,this.borderVisible?borderAlpha:0);
			var radius:Number = Math.min(GasketConfig.width,GasketConfig.height)/2;
//			shape.graphics.drawCircle(GasketConfig.width/2,GasketConfig.height/2,radius);
			shape.graphics.drawRect(0,0,GasketConfig.width,GasketConfig.height);
			shape.graphics.endFill();
			//But we can draw that shape into a bitmap and then create a texture from that bitmap! 
			var bmpData:BitmapData = new BitmapData(GasketConfig.width, GasketConfig.height, true, 0x0);
			bmpData.draw(shape);
			//
			var texture:Texture = Texture.fromBitmapData(bmpData);
//			var image:Image = new Image(texture);
//			addChild(image);
			//
			return texture;
		}
//		override protected function addToStageHandler(event:Event):void
//		{
//			
//		}
		//
//		override protected function touchHandler(event:TouchEvent):void
//		{
//			//Empty.
//		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}
	
}