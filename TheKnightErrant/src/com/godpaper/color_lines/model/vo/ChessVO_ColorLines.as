package com.godpaper.color_lines.model.vo
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.impl.AbstractChessVO;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.utils.LogUtil;
	import com.lookbackon.ds.BitBoard;
	import com.lookbackon.ds.aStar.AStar;
	
	import flash.events.Event;
	
	import mx.logging.ILogger;

	/**
	 * ColorLinesChessVO.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Feb 25, 2011 12:38:37 PM
	 */   	 
	public class ChessVO_ColorLines extends AbstractChessVO
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(ChessVO_ColorLines);
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
		public function ChessVO_ColorLines(width:int, height:int, rowIndex:int, colIndex:int, flag:int=0)
		{
			super(width, height, rowIndex, colIndex, flag);
		}     	

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		override public function initialization(rowIndex:int, colIndex:int, flag:int=0, identifier:String=""):void
		{
			//TODO: implement function
			//Define chess occupy/move/capture even defend bitboard here.
			//@see http://www.godpaper.com/godpaper/index.php/%E5%B0%8F%E7%A0%96%E6%A0%BC%E6%A3%8B
			// *
			// *s*
			// *
			//Notice:Don't worry about bitboard over-fence issues,that it wouble be handle it as default.
			//about occupies.
			this.occupies.setAll();
			this.occupies.setBitt(rowIndex,colIndex,false);
			LOG.debug("occupies:{0}",this.occupies.dump());
			//about legal moves.
			this.moves.clear();
//			LOG.debug("allPieces:{0}",chessPieceModel.allPieces.dump());
			//
			LOG.info("moves:{0}",this.moves.dump());
			//blocker
			//about attacked captures.
			//about defends.
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

