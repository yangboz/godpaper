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
package the_chess_jam.src.com.godpaper.the_chess_jam.views.components
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.views.components.ChessGasket;
	
	import flash.geom.Point;
	
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.utils.Color;
	
	
	/**
	 * ChessGasket_TheChessJam.as class.With customized background graph fill;   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Oct 16, 2012 11:19:32 AM
	 */   	 
	public class ChessGasket_TheChessJam extends ChessGasket
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		override public function set position(value:Point):void
		{
			super.position = value;
			//Customize according to position condition.
			//The chess board backgroud,with bishop position color categorylized.
		    var customBgColor:uint = Color.BLUE;
			if( position.y%2 )
			{
				if(position.x%2)
				{
					customBgColor = Color.WHITE;
				}else
				{
					customBgColor = Color.BLUE;
				}
			}else
			{
				if(position.x%2)
				{
					customBgColor = Color.BLUE;
				}else
				{
					customBgColor = Color.WHITE;
				}
			}
			//Replace the background
			this.background = new Image(this.getUpStateTexture(customBgColor,this.backgroundAlpha,Color.BLACK,this.borderAlpha));
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
		public function ChessGasket_TheChessJam(upState:Texture=null, text:String="", downState:Texture=null)
		{
			super(upState, text, downState);
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