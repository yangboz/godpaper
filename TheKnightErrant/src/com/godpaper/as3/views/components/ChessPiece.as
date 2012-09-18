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
	
	import com.godpaper.as3.business.fsm.ChessAgent;
	import com.godpaper.as3.configs.BoardConfig;
	import com.godpaper.as3.configs.GameConfig;
	import com.godpaper.as3.configs.PieceConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.core.FlexGlobals;
	import com.godpaper.as3.core.IChessPiece;
	import com.godpaper.as3.core.IChessVO;
	import com.godpaper.as3.model.ChessGasketsModel;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.model.vos.OmenVO;
	import com.godpaper.as3.plugins.IPlug;
	import com.godpaper.as3.utils.LogUtil;
	import com.godpaper.as3.views.components.jewels.Jewel;
	import com.lookbackon.AI.FSM.Message;
	import com.lookbackon.ds.BitBoard;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	import mx.logging.ILogger;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.RenderTexture;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	/**
	 * Abstract the basic logic and functions related on chess piece.
	 * Chess pieces can be moved from the pieces box item (pieces) and put on the chess board.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Apr 16, 2012 3:17:37 PM
	 * @history 08/02/2011 added the button click event handler to toggle chess piece move functions.
	 * @history 18/04/2012 extend the starling button for high performance solution.
	 */   	 
	public class ChessPiece extends VisualElement implements IChessPiece
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//Legacy MXML variables.
//		[Bindable]private var gcWidth:Number = GasketConfig.width;
//		[Bindable]private var gcHeight:Number = GasketConfig.height;
//		[Bindable]private var gcBorderVisible:Boolean = GasketConfig.borderVisible;
//		[Bindable]private var gcBackgroundAlpha:Number = GasketConfig.backgroundAlpha;
//		[Bindable]private var gcContentBackgroundAlpha:Number = GasketConfig.contentBackgroundAlpha;
//		[Bindable]private var gcBorderAlpha:Number = GasketConfig.borderAlpha;
		//
		private var textColor:String=DefaultConstants.COLOR_BLUE; //default is blue.
		//pre-define this swf loader for playing the drag proxy(image/movie) effect. 
//		public var swfLoader:Image;
		//models
		private var chessPiecesModel:ChessPiecesModel = FlexGlobals.chessPiecesModel;
//		private var chessGasketModel:ChessGasketsModel = ChessGasketsModel.getInstance();
		private var chessGasketModel:ChessGasketsModel = FlexGlobals.chessGasketsModel;
		//sound effect
		private var cpMoveSound:Sound;
		private var cpMoveSoundChannel:SoundChannel;
		//Original point record.
		public var originalX:Number;
		public var originalY:Number;
		public var piecesBox:PiecesBox;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(ChessPiece);
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		//----------------------------------
		//  agent
		//----------------------------------
		private var _agent:ChessAgent;
		
		public function get agent():ChessAgent
		{
			return _agent;
		}
		
		public function set agent(value:ChessAgent):void
		{
			_agent=value;
		}
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
			//
			_position=value;
		}
		//----------------------------------
		//  chessVO
		//----------------------------------
		private var _chessVO:IChessVO;
		
		public function get chessVO():IChessVO
		{
			return _chessVO;
		}
		
		public function set chessVO(value:IChessVO):void
		{
			_chessVO=value;
		}
		//----------------------------------
		//  flag
		//----------------------------------
		private var _flag:int;
		
		public function get flag():int
		{
			return _flag;
		}
		
		public function set flag(value:int):void
		{
			_flag=value;
			//
			if (value != DefaultConstants.FLAG_BLUE)
			{
				this.textColor=DefaultConstants.COLOR_RED;
//				this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
//				this.addEventListener(MouseEvent.CLICK,mouseClickHandler);
			}
			//Touch bool connection.
			this.touchable = (value != DefaultConstants.FLAG_BLUE);
		}
		//----------------------------------
		//  omenVO
		//----------------------------------
		private var _omenVO:OmenVO;
		
		public function get omenVO():OmenVO
		{
			return _omenVO;
		}
		
		public function set omenVO(value:OmenVO):void
		{
			_omenVO=value;
		}
		//----------------------------------
		//  type(RED_ROOK/BLUE_ROOK...)
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
		public function ChessPiece(upState:Texture=null, text:String="", downState:Texture=null)
		{
			//Default texture setting here.
			var defaultUpState:Texture = upState;
			if(defaultUpState==null)
			{
				var atlas:TextureAtlas = AssetEmbedsDefault.getTextureAtlas();
				defaultUpState = atlas.getTexture(DefaultConstants.BLUE);
			}
			super(defaultUpState, text, downState);
			//Original create complete handler process.
			//Binding the global configurations.
			this.scaleX = PieceConfig.scaleX;
			this.scaleY = PieceConfig.scaleY;
			//Set properties
			var MoveSound:Class = AssetEmbedsDefault.SOUND_CP_MOVE;
			this.cpMoveSound = new MoveSound();
			// finite state machine initialization.
			this.agent=new ChessAgent(this.name, this, null);
			//fsm enter to default state.
			this.agent.fsm.changeState(this.agent.nascenceState);
			//set text style.
			//			this.setStyle("color", textColor);
			//			this.setStyle("fillColor", textColor);
			// event listener method stub
			//			this.addEventListener(TouchEvent.TOUCH, dragEnterHandler);
			//			this.addEventListener(TouchEvent.TOUCH, dragDropHandler);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		//parsley message handler
//		[MessageHandler]
		public function checkHandler(message:Message):void
		{
			if (DefaultConstants.FLAG_BLUE == flag)
			{
				//filter on moves.
				agent.fsm.changeState(agent.defenseState);
			}
		}
		//
		override public function toString():String
		{
			return this.label.concat(this.position.x,this.position.y);
		}
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
//		elementAddHandler
		protected function elementAddHandler(event:Event):void
		//addToStageHandler
//		override protected function addToStageHandler(event:Event):void
		{
			//
			LOG.debug("starling.events.Event,target:{0}", event.target);
			
			//renew ChessPiece's position.
			//				ChessPiece(event.element).position = this.position;
			//clear gasket indicate effect.
			var emptyLegalMoves:BitBoard=new BitBoard(BoardConfig.xLines, BoardConfig.yLines);
			emptyLegalMoves.clear();
			//empty indicate effect.
			GameConfig.chessPieceManager.indicateGasketsMove(emptyLegalMoves);
			//check indicate handler.
			if (iPlug.data.hasCheckIndicator && GameConfig.gameStateManager.isRunning)
			{
				//Notice:after apply move ture flag changed immidiatly,but check indicator ongoing.
				if (DefaultConstants.FLAG_BLUE == GameConfig.turnFlag)
				{
					GameConfig.chessPieceManager.indicateCheck(chessPiecesModel.pieces, chessPiecesModel.BLUE_MARSHAL);
				}
				else
				{
					GameConfig.chessPieceManager.indicateCheck(chessPiecesModel.pieces, chessPiecesModel.RED_MARSHAL);
				}
			}
		}
		
		//elementRemoveHandler
		protected function elementRemoveHandler(event:Event):void
		//removeFromStageHandler
//		override protected function removeFromStageHandler(event:Event):void
		{
			//
			if (iPlug.data.hasCheckIndicator && GameConfig.gameStateManager.isRunning)
			{
				//Notice:turn flag change after remove piece at apply move behavior.
				if (DefaultConstants.FLAG_BLUE == GameConfig.turnFlag)
				{
					GameConfig.chessPieceManager.indicateCheck(chessPiecesModel.pieces, chessPiecesModel.RED_MARSHAL);
				}
				else
				{
					GameConfig.chessPieceManager.indicateCheck(chessPiecesModel.pieces, chessPiecesModel.BLUE_MARSHAL);
				}
			}
		}
		
		//mouseClickHandler
//		protected function mouseClickHandler(event:Event):void
		//triggeredHandler
		override protected function triggeredHandler(event:Event):void
		{
			chessPiecesModel.selectedPiece = this;
			//dump info.
			LOG.debug("captures:{0}", this.chessVO.captures.dump());
			LOG.debug("moves:{0}", this.chessVO.moves.dump());
			LOG.debug("current bitboard:{0}", FlexGlobals.chessPiecesModel.allPieces.dump());
			//Call out for display positon,for debugging.
//			const content:Label = new Label();
//			content.text = this.position.toString();
//			Callout.show(content, this, Callout.DIRECTION_UP);
		}
		//
		protected function get iPlug():IPlug
		{
			return IPlug(FlexGlobals.topLevelApplication.pluginUIComponent.provider);
		}
		//
		override protected function touchHandler(event:TouchEvent):void
		{
			//Drag phases:begin,out,enter,drop.
			var target:ChessPiece = event.target as ChessPiece;
			const touch:Touch = event.getTouch(target);
			if(null==touch) return;//FIXME:Null exception handler.
			//
			var space:DisplayObject = FlexGlobals.gameStage;
//			LOG.info("ChessPiece touch: {0}, space:{1}",touch,space);
			var position:Point = touch.getLocation(space);
			LOG.debug("touch position:{0}",position.toString());
			// 
			var dragEnterTargets:Vector.<ChessGasket>;
			var dragDropTarget:ChessGasket;
			var dragOutTarget:ChessGasket;//ChessGasket/PiecesBox
			//
			switch(touch.phase)
			{
				case TouchPhase.BEGAN:
					//Play sound effect.
//					this.cpMoveSoundChannel = this.cpMoveSound.play();
					break;
				case TouchPhase.HOVER:
					break;
				case TouchPhase.MOVED:
					//delegate to mouse down handler
					target.x = position.x - target.width/2;
					target.y = position.y - target.height/2;
					//					ChessPieceDragManager.getInstance().drag(target,FlexGlobals.gameStage);
//					//drag enter target(chess piece) refresh.
//					dragEnterTargets = this.calculateDragEnterTargets(target);
//					LOG.debug("drag enter ChessPieces @:{0}",dragEnterTargets);
					//
					chessPiecesModel.selectedPiece = this;
					break;
				case TouchPhase.ENDED:
					//End sound effect.
//					this.cpMoveSoundChannel.stop();
					//drag out target(chess gasket) init.
					if(BoardConfig.piecesBoxRequired)
					{
						dragOutTarget = this.piecesBox;
						LOG.debug("drag out target @:{0}",dragOutTarget);
					}else
					{
						dragOutTarget = this.chessGasketModel.gaskets.gett(target.position.x,target.position.y) as ChessGasket;
						LOG.debug("drag out ChessGaket @:{0}",(dragOutTarget as ChessGasket).position);
					}
					//drag enter target(chess piece) refresh.
					dragEnterTargets = this.calculateDragEnterTargets(target);
					LOG.debug("dragEnterTargets:{0}",dragEnterTargets.toString());
					if(!dragEnterTargets.length)
					{
						//Revert to the previous drag and drop operation.
						if(BoardConfig.piecesBoxRequired)
						{
							//Original point record at FillInPiecesBox task.
							this.x = originalX;
							this.y = originalY;
						}else
						{
							this.x = dragOutTarget.x;
							this.y = dragOutTarget.y;
						}
						break;
					}
					LOG.debug("drag enter ChessGakets @:{0}",dragEnterTargets);
					//drag drop target(chess piece) refresh.
					dragDropTarget = this.calculateDragDropTarget(target,dragEnterTargets);
					LOG.debug("drag drop ChessGaket @:{0}",dragDropTarget.position);
					//drag out target(chess gasket) process.
					dragOutTarget.dragOutHandler(event);
					//drag drop target(chess gasket) handler.
					//Sort of drag opereation validation here
					if( isDragAndDropPositionValid((dragOutTarget as ChessGasket),dragDropTarget) )
					{
						if( isDragAndDropPositionIllegal(dragDropTarget,event))
						{
							dragDropTarget.dragDropHandler(event);
							break;
						}
					}
					//Default revert to the previous drag and drop operation.
					if(BoardConfig.piecesBoxRequired)
					{
						//Original point record at FillInPiecesBox task.
						this.x = originalX;
						this.y = originalY;
					}else
					{
						this.x = (dragOutTarget as DisplayObject).x;
						this.y = (dragOutTarget as DisplayObject).y;
					}
					break;
				case TouchPhase.STATIONARY:
					//delegate to mouse click handler
					chessPiecesModel.selectedPiece = this;
					//				LOG.debug("occupies:{0}",this.chessVO.occupies.dump());
					LOG.debug("captures:{0}", this.chessVO.captures.dump());
					LOG.debug("moves:{0}", this.chessVO.moves.dump());
					LOG.debug("current bitboard:{0}", FlexGlobals.chessPiecesModel.allPieces.dump());
					//indicate gasket can fill with chess piece.
					if (iPlug.data.hasMoveIndicator)
					{
						GameConfig.chessPieceManager.indicateGasketsMove(this.chessVO.moves);
					}
					if (iPlug.data.hasCaptureIndicator)
					{
						GameConfig.chessPieceManager.indicateGasketsCapture(this.chessVO.captures);
					}
					break;
				default:
					break;
			}
		}
		//Append the jewel piece to stage.
		override protected function addToStageHandler(event:Event):void
		{
			super.addToStageHandler(event);
			//Jewel piece categoried by type.
			if(this.type==DefaultConstants.RED_JEWEL)
			{
				jewel = Jewel.generate(Jewel.FIRE);
				jewel.size = 50;
			}
			if(this.type==DefaultConstants.BLUE_JEWEL)
			{
				jewel = Jewel.generate(Jewel.WATER);
				jewel.size = 25;
			}
			if(jewel)
			{
				Starling.current.nativeOverlay.addChild(jewel);
			}
		}
		//Jewel related position.
		private var jewel:Jewel;
		override public function set x(value:Number):void
		{
			super.x = value;
			if(jewel)
			{
				jewel.x = value;
			}
		}
		override public function set y(value:Number):void
		{
			super.y = value;
			if(jewel)
			{
				jewel.y = value;
			}
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		//calculate the chess piece 's drag enter targets
		private function calculateDragEnterTargets(dragInitor:ChessPiece):Vector.<ChessGasket>
		{
			var initPoint:Point = dragInitor.position;
			var chessGasket:ChessGasket = chessGasketModel.gaskets.gett(initPoint.x,initPoint.y) as ChessGasket;
			var dropTargets:Vector.<ChessGasket> = new  Vector.<ChessGasket>();
			//Chess board type check.
			var maxOfXLines:int = (BoardConfig.type!=DefaultConstants.CHESS_BOARD_TYPE_CHECKERING)?BoardConfig.xLines:(BoardConfig.xLines-1);
			var maxOfYLines:int = (BoardConfig.type!=DefaultConstants.CHESS_BOARD_TYPE_CHECKERING)?BoardConfig.yLines:(BoardConfig.yLines-1);
			//
			for(var i:int=0;i<maxOfXLines;i++)
			{
				for(var j:int=0;j<maxOfYLines;j++)
				{
					chessGasket =  chessGasketModel.gaskets.gett(i,j) as ChessGasket;
					var colliding:Boolean = dragInitor.getBounds(dragInitor.parent).intersects(chessGasket.getBounds(chessGasket.parent));
//					if(colliding && (chessGasket.position.x != dragInitor.position.x) && (chessGasket.position.y != dragInitor.position.y))
					if(colliding)	
					{
						LOG.debug("ChessPiece colliding the chess gasket:{0}",chessGasket.position);		
						dropTargets.push(chessGasket);
					}
				}
			}
			return dropTargets;
		}
		//calculate the final dropped target(chess gasket) from the detected drag entered chess gasket list.
		private function calculateDragDropTarget(dragInitor:ChessPiece,dragEnterTargets:Vector.<ChessGasket>):ChessGasket
		{
			var final:ChessGasket;
			var collidingAreaSize:Number = 0;
			var indexFlag:int=0;
			for(var i:int=0;i<dragEnterTargets.length;i++)
			{
				var chessGasket:ChessGasket = dragEnterTargets[i];
				var collidingArea:Rectangle = dragInitor.getBounds(dragInitor.parent).intersection(chessGasket.getBounds(chessGasket.parent));
				var areaSize:Number = collidingArea.width*collidingArea.height;
				LOG.debug("drag drop each collidingArea({0}),area size:{1}",chessGasket.position,areaSize);
				//Get the max area size index.
				if(areaSize>=collidingAreaSize)
				{
					collidingAreaSize = areaSize;
					indexFlag = i;
				}
			}
			//
			return dragEnterTargets[indexFlag];
		}
		//Drag and drop operation validators here.
		//First-off,avoid the same position drag and drop.
		private function isDragAndDropPositionValid(dragInitior:ChessGasket,dropTarget:ChessGasket):Boolean
		{
			var sameX:Boolean = (dragInitior.position.x==dropTarget.position.x);
			var sameY:Boolean = (dragInitior.position.y==dropTarget.position.y);
			return (  !sameX || !sameY  );
		}
		//Second,the illegal result based on the chess game's rule.
		private function isDragAndDropPositionIllegal(dropTarget:ChessGasket,event:TouchEvent):Boolean
		{
			var moveValid:Boolean = dropTarget.dragEnterHandler(event);
			return moveValid;
		}
	}
	
}