package come2play_as3.api
{
import come2play_as3.api.auto_copied.*;

import flash.display.*;
public final class CreateGrid
{
	/**
	 * graphics should have a linkage name called <squareLinkageName>.
	 * A grid of movieclips will be instantiated and added as children to graphics. 
	 * The movieclips will be called:
	 * Square_<ROW>_<COL>
	 * For example,
	 * Square_0_0 , Square_0_1 , Square_0_2 , . . .
	 * Square_1_0 , Square_1_1 , Square_1_2 , . . .
	 * Square_2_0 , Square_2_1 , Square_2_2 , . . .
	 * . . .
	 * 
	 * The grid parameters are determined by gotCustomInfo via reflection:
	 * The grid size is ROWS times COLS
	 * The movieclips are scaled by:
	 * squareScaleX and squareScaleY
	 * (for example, if they are 50, then the size is reduced by half.)
	 * The distance between the squares is:
	 * squareDeltaX and squareDeltaY
	 * And the initial position of the first square is: 
	 * squareStartX and squareStartY
	 */
	public static var ROWS:int = 3;
	public static var COLS:int = 3;
	public static var squareScaleX:int = 100;
	public static var squareScaleY:int = 100;
	public static var squareStartX:int = 50;
	public static var squareStartY:int = 50;
	public static var squareDeltaX:int = 84;
	public static var squareDeltaY:int = 84;
		
	public function CreateGrid() {
		StaticFunctions.assert(ROWS>1, "Illegal ROWS=",[ROWS]);
		StaticFunctions.assert(COLS>1, "Illegal COLS=",[COLS]);
	}
	public function createMovieClips(graphics:MovieClip, squareLinkageName:String):void {
		for (var row:int=0; row<ROWS; row++)
			for (var col:int=0; col<COLS; col++) {
				var dup:MovieClip = AS3_vs_AS2.createMovieInstance(graphics, squareLinkageName, "Square_"+row+"_"+col);
				placeInGrid(dup, row, col);	
			}
	}
	public function placeInGrid(dup:MovieClip, row:int, col:int):void {
		AS3_vs_AS2.setMovieXY(dup, squareStartX + squareDeltaX*row, squareStartY + squareDeltaY*col);
		AS3_vs_AS2.scaleMovie(dup, squareScaleX, squareScaleY);		
	}
	public function width():int {
		return 2*squareStartX + squareDeltaX*ROWS;
	}
	public function height():int {
		return 2*squareStartY + squareDeltaY*COLS;
	}
}
}