package com.godpaper.as3.impl
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.configs.PieceConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.core.IPiecesBox;
	import com.godpaper.as3.model.pools.BlueChessPiecesPool;
	import com.godpaper.as3.model.pools.RedChessPiecesPool;
	import com.godpaper.as3.utils.LogUtil;
	
	import mx.events.FlexEvent;
	import mx.logging.ILogger;
	
	import spark.components.BorderContainer;
	import spark.components.Group;


	/**
	 * AbstractPicecesBox.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jul 8, 2011 12:00:37 PM
	 */
	public class AbstractPicecesBox extends BorderContainer implements IPiecesBox
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var _type:String;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger=LogUtil.getLogger(AbstractPicecesBox);

		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		//----------------------------------
		//  type(RED/BLUE...)
		//----------------------------------
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
		public function AbstractPicecesBox()
		{
			super();
			//
			this.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
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
		protected function creationCompleteHandler(event:FlexEvent):void
		{
			if (PieceConfig.bluePieces.length)
			{
				if (type == DefaultConstants.BLUE)
				{
					BlueChessPiecesPool.initialize(PieceConfig.maxPoolSizeBlue, PieceConfig.growthValue);
					//store this reference
					PieceConfig.bluePiecesBox = this;
				}
			}
			if (PieceConfig.redPieces.length)
			{
				if (type == DefaultConstants.RED)
				{
					RedChessPiecesPool.initialize(PieceConfig.maxPoolSizeRed, PieceConfig.growthValue);
					//store this reference
					PieceConfig.redPiecesBox = this;
				}
			}
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}

}
