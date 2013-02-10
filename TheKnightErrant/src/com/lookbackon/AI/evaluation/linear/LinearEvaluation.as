package com.lookbackon.AI.evaluation.linear
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.core.FlexGlobals;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.model.vos.PositionVO;
	import com.lookbackon.AI.evaluation.IEvaluation;
	import com.lookbackon.ds.BitBoard;

	/**
	 * LinearEvaluation.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Aug 24, 2011 6:32:15 PM
	 */
	public class LinearEvaluation implements IEvaluation
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var chessPiecesModel:ChessPiecesModel = FlexGlobals.chessPiecesModel;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------

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
		public function LinearEvaluation()
		{
		}

		/**
		 * KQRBNP = number of kings, queens, rooks, bishops, knights and pawns;</br>
		 * D,S,I = doubled, blocked and isolated pawns;</br>
		 * M = Mobility (the number of legal moves);</br>
		 *
		 * @see http://chessprogramming.wikispaces.com/Evaluation
		 * @param conductVO The conductVO which obtained position information.
		 * @param gamePosition The game position which obtained board position information.
		 * @return Red should try to maximize T as large as possible,
		 * while the Blue should try to minimize T as small as possible.
		 */		
		public function doEvaluation(conductVO:ConductVO,gamePosition:PositionVO):int
		{
			//Material
//			var M:BitBoard = ChessPiecesModel.getInstance()[DefaultConstants.RED_MARSHAL] as BitBoard;
//			var m:BitBoard = ChessPiecesModel.getInstance()[DefaultConstants.BLUE_MARSHAL] as BitBoard;
//			var R:BitBoard = ChessPiecesModel.getInstance()[DefaultConstants.RED_ROOK] as BitBoard;
//			var r:BitBoard = ChessPiecesModel.getInstance()[DefaultConstants.BLUE_ROOK] as BitBoard;
//			var K:BitBoard = ChessPiecesModel.getInstance()[DefaultConstants.RED_KNIGHT] as BitBoard;
//			var k:BitBoard = ChessPiecesModel.getInstance()[DefaultConstants.BLUE_KNIGHT] as BitBoard;
//			var O:BitBoard = ChessPiecesModel.getInstance()[DefaultConstants.RED_OFFICAL] as BitBoard;
//			var o:BitBoard = ChessPiecesModel.getInstance()[DefaultConstants.BLUE_OFFICAL] as BitBoard;
//			var C:BitBoard = ChessPiecesModel.getInstance()[DefaultConstants.RED_CANNON] as BitBoard;
//			var c:BitBoard = ChessPiecesModel.getInstance()[DefaultConstants.BLUE_CANNON] as BitBoard;
//			var P:BitBoard = ChessPiecesModel.getInstance()[DefaultConstants.RED_PAWN] as BitBoard;
//			var p:BitBoard = ChessPiecesModel.getInstance()[DefaultConstants.BLUE_PAWN] as BitBoard;
//			var B:BitBoard = ChessPiecesModel.getInstance()[DefaultConstants.RED_BISHOP] as BitBoard;
//			var b:BitBoard = ChessPiecesModel.getInstance()[DefaultConstants.BLUE_BISHOP] as BitBoard;
//			
			var M:BitBoard = FlexGlobals.chessPiecesModel[DefaultConstants.RED] as BitBoard;
			var m:BitBoard = FlexGlobals.chessPiecesModel[DefaultConstants.BLUE] as BitBoard;
			var R:BitBoard = FlexGlobals.chessPiecesModel[DefaultConstants.RED] as BitBoard;
			var r:BitBoard = FlexGlobals.chessPiecesModel[DefaultConstants.BLUE] as BitBoard;
			var K:BitBoard = FlexGlobals.chessPiecesModel[DefaultConstants.RED] as BitBoard;
			var k:BitBoard = FlexGlobals.chessPiecesModel[DefaultConstants.BLUE] as BitBoard;
			var O:BitBoard = FlexGlobals.chessPiecesModel[DefaultConstants.RED] as BitBoard;
			var o:BitBoard = FlexGlobals.chessPiecesModel[DefaultConstants.BLUE] as BitBoard;
			var C:BitBoard = FlexGlobals.chessPiecesModel[DefaultConstants.RED] as BitBoard;
			var c:BitBoard = FlexGlobals.chessPiecesModel[DefaultConstants.BLUE] as BitBoard;
			var P:BitBoard = FlexGlobals.chessPiecesModel[DefaultConstants.RED] as BitBoard;
			var p:BitBoard = FlexGlobals.chessPiecesModel[DefaultConstants.BLUE] as BitBoard;
			var B:BitBoard = FlexGlobals.chessPiecesModel[DefaultConstants.RED] as BitBoard;
			var b:BitBoard = FlexGlobals.chessPiecesModel[DefaultConstants.BLUE] as BitBoard;
			
			var T_red:int = M.celled*133
				+B.celled*166
				+R.celled*600
				+K.celled*266
				+C.celled*300
				+P.celled*66
				;
			var T_blue:int = m.celled*133
				+b.celled*166
				+r.celled*600
				+k.celled*266
				+c.celled*300
				+p.celled*66
				;
			//Mobility
			//TODO:
			//Threat
			//
			return T_blue-T_red;
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

		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}

}
