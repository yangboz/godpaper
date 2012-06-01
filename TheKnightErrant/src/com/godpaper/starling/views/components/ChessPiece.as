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
	
	import com.godpaper.as3.business.fsm.ChessAgent;
	import com.godpaper.as3.business.managers.ChessPieceDragManager;
	import com.godpaper.as3.configs.BoardConfig;
	import com.godpaper.as3.configs.GameConfig;
	import com.godpaper.as3.configs.GasketConfig;
	import com.godpaper.as3.configs.PieceConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.consts.FlexGlobals;
	import com.godpaper.as3.core.IChessPiece;
	import com.godpaper.as3.core.IChessVO;
	import com.godpaper.as3.model.ChessGasketsModel;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.model.vos.OmenVO;
	import com.godpaper.as3.plugins.IPlug;
	import com.lookbackon.AI.FSM.Message;
	import com.lookbackon.ds.BitBoard;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	import org.spicefactory.lib.flash.logging.impl.AbstractAppender;
	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
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
	public class ChessPiece extends RoundButton implements IChessPiece
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//
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
		private var chessPiecesModel:ChessPiecesModel = ChessPiecesModel.getInstance();
		private var chessGasketModel:ChessGasketsModel = ChessGasketsModel.getInstance();
		//sound effect
		private var cpMoveSound:Sound;
		private var cpMoveSoundChannel:SoundChannel;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:Logger = LogContext.getLogger(ChessPiece);
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
		//----------------------------------
		//  label
		//----------------------------------
		private var _label:String;
		
		public function get label():String
		{
			return _label;
		}
		
		public function set label(value:String):void
		{
			_label=value;
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
			//
//			this.addEventListener(Event.COMPLETE,creationCompleteHandler);
			this.addEventListener(Event.ROOT_CREATED,creationCompleteHandler);
			//Binding the global configurations.
			this.scaleX = PieceConfig.scaleX;
			this.scaleY = PieceConfig.scaleY;
			//Set properties
			var MoveSound:Class = AssetEmbedsDefault.SOUND_CP_MOVE;
			this.cpMoveSound = new MoveSound();
			//once piece add or remove,maybe check event triggled.
			this.addEventListener(Event.REMOVED_FROM_STAGE, elementRemoveHandler);
//			this.addEventListener(Event.TRIGGERED,mouseClickHandler);
//			this.addEventListener(Event.ADDED_TO_STAGE, elementAddHandler);
			this.addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removeFromStageHandler);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		//parsley message handler
		[MessageHandler]
		public function checkHandler(message:Message):void
		{
			if (DefaultConstants.FLAG_BLUE == flag)
			{
				//filter on moves.
				agent.fsm.changeState(agent.defenseState);
			}
		}
		//
		public function toString():String
		{
			return this.label.concat(this.position.x,this.position.y);
		}
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		//creationCompleteHandler
		protected function creationCompleteHandler(event:Event):void
		{
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
		//
		protected function elementAddHandler(event:Event):void
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
		
		//
		protected function elementRemoveHandler(event:Event):void
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
		protected function mouseClickHandler(event:Event):void
		{
			chessPiecesModel.selectedPiece = this;
			//dump info.
			LOG.debug("captures:{0}", this.chessVO.captures.dump());
			LOG.debug("moves:{0}", this.chessVO.moves.dump());
			LOG.debug("current bitboard:{0}", ChessPiecesModel.getInstance().allPieces.dump());
		}
		//mouseDownHandler
		protected function mouseDownHandler(event:TouchEvent):void
		{
			chessPiecesModel.selectedPiece = this;
			//handle the drag image/movie effect.
			if(PieceConfig.usingDragProxy)
			{
//				var imageProxy:Image = new Image();
//				imageProxy.texture = this.swfLoader.texture;
//				imageProxy.scaleX = PieceConfig.scaleX;
//				imageProxy.scaleY = PieceConfig.scaleY;
			}
			//
//			DragManager.doDrag(event.currentTarget as IUIComponent, null, event,imageProxy);
			// remove event listener
			//				this.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler);
			//				LOG.debug("occupies:{0}",this.chessVO.occupies.dump());
			LOG.debug("captures:{0}", this.chessVO.captures.dump());
			LOG.debug("moves:{0}", this.chessVO.moves.dump());
			LOG.debug("current bitboard:{0}", ChessPiecesModel.getInstance().allPieces.dump());
			//indicate gasket can fill with chess piece.
			if (iPlug.data.hasMoveIndicator)
			{
				GameConfig.chessPieceManager.indicateGasketsMove(this.chessVO.moves);
			}
			if (iPlug.data.hasCaptureIndicator)
			{
				GameConfig.chessPieceManager.indicateGasketsCapture(this.chessVO.captures);
			}
		}
		//
		protected function get iPlug():IPlug
		{
			return IPlug(ApplicationBase(this.root).pluginUIComponent.provider);
		}
		//
		override protected function touchHandler(event:TouchEvent):void
		{
			var target:ChessPiece = event.target as ChessPiece;
			const touch:Touch = event.getTouch(target);
			if(null==touch) return;//FIXME:Null exception handler.
			//
			var space:DisplayObject = FlexGlobals.gameStage;
//			LOG.info("ChessPiece touch: {0}, space:{1}",touch,space);
			var position:Point = touch.getLocation(space);
			// 
			var dropTargets:Vector.<ChessGasket>;
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
					dropTargets = this.calculateDropTarget(target);
					LOG.info("ChessPiece drop targets:{0} ",dropTargets);
					//
					chessPiecesModel.selectedPiece = this;
					break;
				case TouchPhase.ENDED:
					//End sound effect.
//					this.cpMoveSoundChannel.stop();
					//
					dropTargets = this.calculateDropTarget(target);
					if(dropTargets[0])
					{
						var dropTarget:ChessGasket = dropTargets[0];
						dropTarget.dragEnterHandler(event);
					}
					break;
				case TouchPhase.STATIONARY:
					//delegate to mouse click handler
					chessPiecesModel.selectedPiece = this;
					break;
				default:
					break;
			}
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		//calculate the chess piece 's drop target
		private function calculateDropTarget(dragInitor:ChessPiece):Vector.<ChessGasket>
		{
			var initPoint:Point = dragInitor.position;
			var chessGasket:ChessGasket = chessGasketModel.gaskets.gett(initPoint.x,initPoint.y) as ChessGasket;
			var dropTargets:Vector.<ChessGasket> = new  Vector.<ChessGasket>();
			//
			for(var i:int=0;i<BoardConfig.xLines;i++)
			{
				for(var j:int=0;j<BoardConfig.yLines;j++)
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
	}
	
}