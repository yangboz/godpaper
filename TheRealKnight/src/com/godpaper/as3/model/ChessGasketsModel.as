package com.godpaper.as3.model
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.configs.BoardConfig;
	import com.godpaper.as3.consts.CcjConstants;
	import com.godpaper.as3.errors.CcjErrors;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.model.vos.PositionVO;
	import com.godpaper.as3.model.vos.ccjVO.BishopVO;
	import com.godpaper.as3.model.vos.ccjVO.CannonVO;
	import com.godpaper.as3.model.vos.ccjVO.KnightVO;
	import com.godpaper.as3.model.vos.ccjVO.MarshalVO;
	import com.godpaper.as3.model.vos.ccjVO.OfficalVO;
	import com.godpaper.as3.model.vos.ccjVO.PawnVO;
	import com.godpaper.as3.model.vos.ccjVO.RookVO;
	import com.godpaper.as3.utils.LogUtil;
	import com.godpaper.as3.views.components.ChessPiece;
	import com.lookbackon.ds.BitBoard;

	import de.polygonal.ds.Array2;

	import mx.collections.ArrayCollection;
	import mx.logging.ILogger;


	/**
	 * ChessGasketsModel.as class. A singleton model hold all Chess gaskets' information.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jan 26, 2011 12:37:31 PM
	 */   	 
	public class ChessGasketsModel
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//Singleton instance of ChessGasketsModel;
		private static var instance:ChessGasketsModel;
		//
		private var _gaskets:Array2=new Array2(BoardConfig.xLines, BoardConfig.yLines);
		//----------------------------------
		//  CONSTANTS
		//----------------------------------

		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		//----------------------------------
		//  gaskets
		//----------------------------------
		public function get gaskets():Array2
		{
			return _gaskets;
		}
		public function set gaskets(value:Array2):void
		{
			_gaskets = value;
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
		public function ChessGasketsModel(access:Private)
		{
			if (access != null)
			{
				if (instance == null)
				{
					instance=this;
				}
			}
			else
			{
				throw new CcjErrors(CcjErrors.INITIALIZE_SINGLETON_CLASS);
			}
		}
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		/**
		 *
		 * @return the singleton instance of ChessGasketsModel
		 *
		 */
		public static function getInstance():ChessGasketsModel
		{
			if (instance == null)
			{
				instance=new ChessGasketsModel(new Private());
			}
			return instance;
		}
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
/**
 *Inner class which restricts construtor access to Private
 */
internal class Private
{
}


