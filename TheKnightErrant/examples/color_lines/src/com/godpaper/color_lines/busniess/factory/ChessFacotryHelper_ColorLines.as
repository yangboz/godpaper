package color_lines.src.com.godpaper.color_lines.busniess.factory
{
	import com.godpaper.as3.configs.BoardConfig;
	import com.godpaper.as3.core.FlexGlobals;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.utils.LogUtil;
	import com.godpaper.as3.utils.MathUtil;
	import com.godpaper.as3.model.vos.ColorPositionVO;
	import com.masterbaboon.AdvancedMath;
	
	import flash.geom.Point;
	
	import mx.logging.ILogger;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * ColorLinesChessFacotryHelper.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created May 20, 2011 11:10:16 AM
	 */   	 
	public class ChessFacotryHelper_ColorLines
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private static var chessPieceModel:ChessPiecesModel = FlexGlobals.chessPiecesModel;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(ChessFacotryHelper_ColorLines);
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
		    	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		public static function randomColorfulPieces():Vector.<ColorPositionVO>
		{
			//@see http://erwnerve.tripod.com/prog/recursion/connect4.htm
			// probability of the faces; red/blue is about twice more likely to appear
			// blue,red,saffron,yellow,blue,purple,cyanine
			var p:Array = [0.15, 0.15, 0.14, 0.14, 0.14, 0.14,0.14];
			var pColor:Number = 1/7;
			var pBlue:Number = Number((1/MathUtil.premutate(7,1)).toFixed(10));
			var probability:Array = [pColor, pColor, pColor, pColor, pColor, pColor];
			// count the number of times a face appears
			var count:Array = AdvancedMath.zeros(7);
			// throw dice 1000 times
			var face:int;
			for (var i:int = 0; i < 6; i++) {
				face = AdvancedMath.sampleMultinomial(p);
				count[face]++;
			}
			//			trace(count);
			// e.g.
			//			trace(MathUtil.factorial(7));
			//			trace(MathUtil.permutateArray([1,2,3,4,5,6,7],3));
			//			trace(MathUtil.permutation(7,3));
			//			trace(MathUtil.premutate(7,3));
			//			trace(MathUtil.toFactoradic(3));
			//			trace(MathUtil.toFactoradic2(3,2));
			//			var blue:Number = Number( (1/MathUtil.premutate(7,1)).toFixed(10) );
			//			var red:Number = Number( (1/MathUtil.premutate(7,1)).toFixed(10) );
			//			trace("blue:",blue,"red:",red,"blue+red:",(blue*red).toFixed(10));
			var result:Vector.<ColorPositionVO> = new Vector.<ColorPositionVO>();
			//
			var colors:Array = ["BLUE","RED","SAFFRON","YELLOW","CYANINE","PURPLE","GREEN"];
			var randomPremutatedColors:Array = MathUtil.randomPremutate(colors,3);
			LOG.debug("randomPremutatedColors:{0}",randomPremutatedColors);
			var positions:Array = caculateTheRestPostions();
			var randomPremutatedPositions:Array = MathUtil.randomPremutate(positions,3);
			LOG.debug("randomPremutatedPositions:{0}",randomPremutatedPositions);	
			for(var c:int=0;c<randomPremutatedColors.length;c++)
			{
				var colorPosObj:ColorPositionVO = new ColorPositionVO();
				colorPosObj.color = randomPremutatedColors[c];
				colorPosObj.position = randomPremutatedPositions[c];
				result.push(colorPosObj);
			}
//			trace("random premutated color and position:",result.toString());
			return result;
		}
		//
		private static function caculateTheRestPostions():Array
		{
			var results:Array = [];
			//caculate now
			//Notice:the original all pieces size is 9*10;
			for(var col:int=0;col<chessPieceModel.allPieces.column;col++)
			{
				for(var row:int=0;row<chessPieceModel.allPieces.row-1;row++)
				{
					if(!chessPieceModel.allPieces.getBitt(row,col))
					{
						results.push(new Point(col,row));
					}
				}
			}
			return results;
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