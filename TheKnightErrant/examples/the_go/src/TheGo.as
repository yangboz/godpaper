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
	import com.godpaper.as3.configs.TextureConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.core.FlexGlobals;
	import com.godpaper.as3.core.IChessPieceManager;
	import com.godpaper.as3.plugins.IPlug;
	import com.godpaper.as3.utils.LogUtil;
	import com.godpaper.the_go.business.factory.ChessFactory_TheGo;
	import com.godpaper.the_go.business.managers.ChessPiecesManager_TheGo;
	
	import mx.logging.ILogger;
	
	import starling.display.Image;
	import starling.textures.TextureAtlas;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * TigerInBeijing.as class. 
	 * @see http://www.godpaper.com/godpaper/index.php/围棋	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Jul 13, 2012 3:32:11 PM
	 */   	 
	[SWF(frameRate="60", width="750", height="660", backgroundColor="0xffffff")]//320×480 for iPhone devices
	//	[SWF(frameRate="60", width="384", height="512", backgroundColor="0xffffff")]//384×512 for iPad devices
	public class TheGo extends ApplicationBase
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(TheGo);
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		/**
		 * Override this for customize chess pieces manager.
		 */ 
		override public function get chessPiecesManager():IChessPieceManager
		{
			return new ChessPiecesManager_TheGo();
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
		public function TheGo()
		{
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
			BoardConfig.xLines=19;
			BoardConfig.yLines=19;
			BoardConfig.xOffset=30;
			BoardConfig.yOffset=30;	
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
			//gasket config:
			GasketConfig.maxPoolSize = 361;
			GasketConfig.tipsVisible = true;
			GasketConfig.backgroundAlpha = 0.2;
			GasketConfig.width = 30;
			GasketConfig.height = 30;
			//about piece:
			PieceConfig.factory = ChessFactory_TheGo;
			PieceConfig.maxPoolSizeBlue = 100;
			PieceConfig.maxPoolSizeRed = 100;
			//Notice:starling scaleX/Y seldom triggle touch event issues.
			PieceConfig.scaleX = .8;
			PieceConfig.scaleY = .8;
			//about plugin:
			PluginConfig.gameID = "34331f335e39fb05";//your custom game related id.
//			PluginConfig.boardID = "51c558cd0315f8e7";//your custom game related board id.
			this._mochiads_game_id = "34331f335e39fb05";//espical for mochi game platform.
			//TextureConfig
			TextureConfig.AssetEmbeds_1x_class=AssetEmbeds_1x_the_go;
			//			TextureConfig.AssetEmbeds_2x_class=AssetEmbeds_2x;
//			TextureConfig.altalsTexture_img_name = "AtlasTexture_the_go";
//			TextureConfig.altalsTexture_xml_name = "AtlasTexture_the_go";
			//Stats configure
			//Displays the statistics box at a certain position.
			PluginConfig.showStats = true;
			//Pieces box config:
			PluginConfig.piecesBoxRequired = false;
			PluginConfig.piecesBoxPosition = PluginConfig.PBOX_AT_RIGHT;
			//
			LOG.debug("SigletonFactory(cp) test:{0}",FlexGlobals.chessPiecesModel.BLUE_BISHOP.dump());
			LOG.debug("SigletonFactory(cg) test:{0}",FlexGlobals.chessGasketsModel.gaskets);
			LOG.debug("SigletonFactory(cb) test:{0}",FlexGlobals.chessBoardModel.status.dump());
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}
	
}