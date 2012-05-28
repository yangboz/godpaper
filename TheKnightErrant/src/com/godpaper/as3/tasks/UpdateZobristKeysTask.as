package com.godpaper.as3.tasks
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.adobe.cairngorm.task.Task;
	import com.godpaper.as3.model.ZobristKeysModel;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.model.vos.ZobristKeyVO;
	
	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.Logger;
	
	
	/**
	 * UpdateZobristKeysTask.as class.   	
	 * @see http://mediocrechess.blogspot.com/2007/01/guide-zobrist-keys.html
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Dec 2, 2010 1:12:45 PM
	 */   	 
	public class UpdateZobristKeysTask extends Task
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var conductVO:ConductVO;
		private var _zKey:ZobristKeyVO;//current chess piece's zobrist key value object.
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:Logger = LogContext.getLogger(UpdateZobristKeysTask);
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
		public function UpdateZobristKeysTask(conductVO:ConductVO)
		{
			super();
			//Set properties
			this.label = "UpdateZobristKeysTask";
			//
			this.conductVO = conductVO;
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
		override protected function performTask():void
		{
			//TODO:update ZobristKeys
			var pX:int = conductVO.previousPosition.x;
			var pY:int = conductVO.previousPosition.y;
			var oX:int = conductVO.nextPosition.x;
			var oY:int = conductVO.nextPosition.y;
			//ref:http://mediocrechess.blogspot.com/2007/01/guide-zobrist-keys.html
			_zKey = ZobristKeysModel.getInstance().getZobristKey();
			LOG.debug("before makemove:{0}",_zKey.dump());
			//update zobristkey.
			_zKey.position.sett(oX,oY,conductVO.crossValue^_zKey.position.gett(oX,oY) );
			_zKey.position.sett(pX,pY,conductVO.crossValue^_zKey.position.gett(pX,pY) );
			//
			LOG.debug("after makemove:{0}",_zKey.dump());
			//for testing unmakeMove();
			//			unmakeMove();
			//
			this.complete();
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}
	
}