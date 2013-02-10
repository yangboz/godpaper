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
package
{
	import com.godpaper.as3.configs.BoardConfig;
	import com.godpaper.as3.configs.GameConfig;
	import com.godpaper.as3.configs.GasketConfig;
	import com.godpaper.as3.configs.PieceConfig;
	import com.godpaper.as3.configs.PluginConfig;
	import com.godpaper.as3.core.IChessPieceManager;
	import com.godpaper.as3.utils.LogUtil;
	import com.godpaper.the_2_tigers.busniess.factory.ChessFactory_The2Tigers;
	import com.godpaper.the_2_tigers.busniess.managers.ChessPiecesManager_The2Tigers;
	
	import mx.logging.ILogger;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	[SWF(frameRate="60", width="500", height="550", backgroundColor="0xffffff")]//320×480 for iPhone devices
	//	[SWF(frameRate="60", width="384", height="512", backgroundColor="0xffffff")]//384×512 for iPad devices
	/**
	 * The2Tigers.as class.   	
	 * @see www.godpaper.com/godpaper/index.php/二虎棋
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Jul 19, 2012 1:49:40 PM
	 */   	 
	public class The2Tigers extends ApplicationBase
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(The2Tigers);
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		override public function get chessPiecesManager():IChessPieceManager
		{
			return new ChessPiecesManager_The2Tigers();
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
		public function The2Tigers()
		{
			//TODO: implement function
			super();
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
		override protected function initializeHandler():void
		{
			//config initialization here.
			//about chess board:
			BoardConfig.xLines=5;
			BoardConfig.yLines=5;
			BoardConfig.xOffset=100;
			BoardConfig.yOffset=100;	
			//			BoardConfig.width=300;
			//			BoardConfig.height=300;
			BoardConfig.xScale=1;
			BoardConfig.yScale=1;
			BoardConfig.xAdjust=50;
			BoardConfig.yAdjust=50;
			//for connex
//			BoardConfig.hConnex = true;//enable the horizontal connection.
//			BoardConfig.vConnex = true;//enable the vertical connection.
//			BoardConfig.fdConnex = true;//enable the forward connection.
//			BoardConfig.bdConnex = true;//enable the backward connection.
//			BoardConfig.numConnex = 3;//the number of connection.
			//Customize starling texture sample:
			//			var texture:Texture = AssetEmbedsDefault.getTexture(DefaultConstants.IMG_BACK_GROUND);
			//			BoardConfig.backgroundImage = new Image(texture);
			//Pieces box config:
			BoardConfig.piecesBoxRequired = false;
			//			BoardConfig.piecesBoxBgImage = null;
			//gasket config:
			GasketConfig.maxPoolSize = 9;//Notices:Object pools full of objects with dangerously stale state are sometimes called object cesspools and regarded as an anti-pattern.
			GasketConfig.tipsVisible = true;
			GasketConfig.backgroundAlpha = 0.2;
			GasketConfig.width = 30;
			GasketConfig.height = 30;
			//about piece:
			PieceConfig.factory = ChessFactory_The2Tigers;//your custom chess factory.
			PieceConfig.maxPoolSizeBlue = 5;//What's the number of blue(computer) chess pieces?
			PieceConfig.maxPoolSizeRed = 5;//What's the number of red(human) chess pieces?
			//Notice:starling scaleX/Y seldom triggle touch event issues.
			PieceConfig.scaleX = 1;
			PieceConfig.scaleY = 1;
			//about plugin:
			PluginConfig.gameID = "0573fa7cbce361b5";//your custom game related id.
//			PluginConfig.boardID = "51c558cd0315f8e7";//your custom game related board id.
			this._mochiads_game_id = "0573fa7cbce361b5";//espical for mochi game platform.
			//
//			LOG.debug("SigletonFactory(cp) test:{0}",FlexGlobals.chessPiecesModel.BLUE_BISHOP.dump());
//			LOG.debug("SigletonFactory(cg) test:{0}",FlexGlobals.chessGasketsModel.gaskets);
//			LOG.debug("SigletonFactory(cb) test:{0}",FlexGlobals.chessBoardModel.status.dump());
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}
	
}