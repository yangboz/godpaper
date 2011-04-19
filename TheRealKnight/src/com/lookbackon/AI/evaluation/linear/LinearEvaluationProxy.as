package com.lookbackon.AI.evaluation.linear
{
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.model.vos.ConductVO;
	import com.godpaper.as3.model.vos.PositionVO;
	import com.lookbackon.AI.evaluation.IEvaluation;
	import com.lookbackon.ds.BitBoard;

	import flash.utils.Proxy;
	import flash.utils.flash_proxy;

	/**
	 * LinearEvaluationProxy.as class.
	 * Similar to Shannon’s 1949 paper, the evaluation for this type of evaluation is defined as:</br>
	 * T = T(red) -T(blue)
	 * Where_ _ * 266 _ _ * 300 _ _ * 66_ *133 _ _ *166 _ _ * 600number of Horses number of Cannon number of pawns
	 * T number Guards number of Elephants number of Rooks black+ + += + +
	 * _ _ * 266 _ _ *300 _ _ * 66_ *133 _ _ *166 _ _ * 600
	 * @author Knight.zhou
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jun 10, 2010 2:09:53 PM
	 */
	public class LinearEvaluationProxy extends Proxy implements IEvaluation
	{
		use namespace flash_proxy;
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
		//  Private properties
		//
		//--------------------------------------------------------------------------
		private var _item:Array;
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		//sample:trace(arr.sum()); 6arr.clear();
		public function LinearEvaluationProxy()
		{
			//TODO: implement function
			super();
			_item = new Array();
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
			//TODO: implement function
			//Material
			var M:BitBoard = ChessPiecesModel.getInstance()[DefaultConstants.RED_MARSHAL] as BitBoard;
			var m:BitBoard = ChessPiecesModel.getInstance()[DefaultConstants.BLUE_MARSHAL] as BitBoard;
			var R:BitBoard = ChessPiecesModel.getInstance()[DefaultConstants.RED_ROOK] as BitBoard;
			var r:BitBoard = ChessPiecesModel.getInstance()[DefaultConstants.BLUE_ROOK] as BitBoard;
			var K:BitBoard = ChessPiecesModel.getInstance()[DefaultConstants.RED_KNIGHT] as BitBoard;
			var k:BitBoard = ChessPiecesModel.getInstance()[DefaultConstants.BLUE_KNIGHT] as BitBoard;
			var O:BitBoard = ChessPiecesModel.getInstance()[DefaultConstants.RED_OFFICAL] as BitBoard;
			var o:BitBoard = ChessPiecesModel.getInstance()[DefaultConstants.BLUE_OFFICAL] as BitBoard;
			var C:BitBoard = ChessPiecesModel.getInstance()[DefaultConstants.RED_CANNON] as BitBoard;
			var c:BitBoard = ChessPiecesModel.getInstance()[DefaultConstants.BLUE_CANNON] as BitBoard;
			var P:BitBoard = ChessPiecesModel.getInstance()[DefaultConstants.RED_PAWN] as BitBoard;
			var p:BitBoard = ChessPiecesModel.getInstance()[DefaultConstants.BLUE_PAWN] as BitBoard;
			var B:BitBoard = ChessPiecesModel.getInstance()[DefaultConstants.RED_BISHOP] as BitBoard;
			var b:BitBoard = ChessPiecesModel.getInstance()[DefaultConstants.BLUE_BISHOP] as BitBoard;

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
		override flash_proxy function callProperty(methodName:*, ... args):* 
		{
			var res:*;
			switch (methodName.toString()) 
			{
				case "clear":
					_item = new Array();
					break;
				case "sum":
					var sum:Number = 0;
					for each (var i:* in _item) 
					{
						// ignore non-numeric values
						if (!isNaN(i)) 
						{
							sum += i;
						}
					}
					res = sum;
					break;
				default:
					res = _item[methodName].apply(_item, args);
					break;
			}
			return res;
		}

		override flash_proxy function getProperty(name:*):* 
		{
			return _item[name];
		}

		override flash_proxy function setProperty(name:*, value:*):void 
		{
			_item[name] = value;
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

