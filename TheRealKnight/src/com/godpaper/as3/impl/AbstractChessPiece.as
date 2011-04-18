package com.godpaper.as3.impl
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.business.fsm.ChessAgent;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.core.IChessPiece;
	import com.godpaper.as3.core.IChessVO;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.model.vos.OmenVO;

	import flash.events.MouseEvent;
	import flash.geom.Point;

	import mx.core.IUIComponent;
	import mx.events.FlexEvent;
	import mx.logging.ILogger;
	import mx.managers.DragManager;

	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.LogUtil;
	import org.spicefactory.lib.logging.Logger;

	import spark.components.Group;

	/**
	 * AbstractChessPiece.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jan 20, 2011 3:47:27 PM
	 */   	 
	public class AbstractChessPiece extends Group implements IChessPiece
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//
		private var textColor:String=DefaultConstants.COLOR_BLUE; //default is blue.
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:Logger = LogContext.getLogger(AbstractChessPiece);
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
				this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
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
		public function AbstractChessPiece()
		{
			//TODO: implement function
			super();
			//
			this.addEventListener(FlexEvent.CREATION_COMPLETE,creationCompleteHandler);
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
		//creationCompleteHandler
		protected function creationCompleteHandler(event:FlexEvent):void
		{
			// TODO Auto-generated method stub
			// finite state machine initialization.
			this.agent=new ChessAgent(this.name, this, null);
			//fsm enter to default state.
			this.agent.fsm.changeState(this.agent.nascenceState);
			// add event listener

			//set text style.
			this.setStyle("color", textColor);
			this.setStyle("fillColor", textColor);
		}

		//mouseDownHandler
		protected function mouseDownHandler(event:MouseEvent):void
		{
			DragManager.doDrag(event.currentTarget as IUIComponent, null, event);
			// remove event listener
			//				this.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDownHandler);
			//				LOG.debug("occupies:{0}",this.chessVO.occupies.dump());
			LOG.debug("captures:{0}", this.chessVO.captures.dump());
			LOG.debug("moves:{0}", this.chessVO.moves.dump());
			LOG.debug("current bitboard:{0}", ChessPiecesModel.getInstance().allPieces.dump());
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}

}

