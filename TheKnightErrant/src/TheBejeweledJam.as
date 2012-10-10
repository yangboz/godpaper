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
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.business.managers.GameStateManagerDefault;
	import com.godpaper.as3.configs.BoardConfig;
	import com.godpaper.as3.configs.GameConfig;
	import com.godpaper.as3.configs.GasketConfig;
	import com.godpaper.as3.configs.LoggerConfig;
	import com.godpaper.as3.configs.PieceConfig;
	import com.godpaper.as3.configs.PluginConfig;
	import com.godpaper.as3.configs.TextureConfig;
	import com.godpaper.as3.configs.ThemeConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.core.FlexGlobals;
	import com.godpaper.as3.core.IChessPieceManager;
	import com.godpaper.as3.core.IGameStateManager;
	import com.godpaper.as3.plugins.IPlug;
	import com.godpaper.as3.plugins.PluginUIComponent;
	import com.godpaper.as3.plugins.kongregate.KongregatePlugin;
	import com.godpaper.as3.utils.LogUtil;
	import com.godpaper.as3.utils.VersionController;
	import com.godpaper.as3.views.scenes.MainScene;
	import com.godpaper.the_bejeweled_jam.business.factory.ChessFactory_TheBejeweledJam;
	import com.godpaper.the_bejeweled_jam.business.managers.ChessPiecesManager_TheBejeweledJam;
	import com.godpaper.the_bejeweled_jam.business.managers.GameStateManager_TheBejeweledJam;
	
	import mx.logging.ILogger;
	import mx.logging.LogEventLevel;
	
	[SWF(frameRate="60", width="400", height="440", backgroundColor="0xffffff")] //320×480 for iPhone devices
	//	[SWF(frameRate="60", width="384", height="512", backgroundColor="0xffffff")]//384×512 for iPad devices
	/**
	 * Bejeweled is a tile-matching puzzle game,inspired by the gameplay of Shariki.
	 *    	
	 * @see http://en.wikipedia.org/wiki/Bejeweled
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Oct 10, 2012 1:17:43 PM
	 */   	 
	public class TheBejeweledJam extends ApplicationBase
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(TheBejeweledJam);
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
			//			return new ChessPieceManagerDefault();
			return new ChessPiecesManager_TheBejeweledJam();
		}
		
		/**
		 * Override this for customize game state manager.
		 */
		override public function get gameStateManager():IGameStateManager
		{
//			return new GameStateManagerDefault();
			return new GameStateManager_TheBejeweledJam();
		}
		
		/**
		 * Override this for customize game theme.
		 */
		override public function get themeClass():Class
		{
			//			return ThemeConfig.THEME_AEON_DESKTOP;
			return ThemeConfig.THEME_MINIMAL;
			//			return ThemeConfig.THEME_AZURE;
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
		public function TheBejeweledJam()
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
		//applicationBase_initializeHandler
		/**
		 * All kinds of view components initialization here.
		 */
		override protected function initializeHandler():void
		{
			//config initialization here.
			//about chess board:
			BoardConfig.xLines=9; //
			BoardConfig.yLines=9; //
			BoardConfig.xOffset=40; //
			BoardConfig.yOffset=40; //	
			//			BoardConfig.width=300;
			//			BoardConfig.height=300;
			BoardConfig.xScale=1; //
			BoardConfig.yScale=1; //
			BoardConfig.xAdjust=40; //
			BoardConfig.yAdjust=40; //
			//for connex
			BoardConfig.hConnex=true; //enable the horizontal connection.
			BoardConfig.vConnex=true; //enable the vertical connection.
			BoardConfig.fdConnex=true; //enable the forward connection.
			BoardConfig.bdConnex=true; //enable the backward connection.
			BoardConfig.numConnex=3; //the number of connection.
			BoardConfig.type = DefaultConstants.CHESS_BOARD_TYPE_CHECKERING;//the type of chess board.(checkering,intersection,segament,fractal...)
			//Customize starling texture sample:
			//			var texture:Texture = AssetEmbedsDefault.getTexture(DefaultConstants.IMG_BACK_GROUND);
			//			BoardConfig.backgroundImage = new Image(texture);
			//Pieces box config:
			BoardConfig.piecesBoxRequired=false; //Pieces box used to obtain chess pieces as a container.
			BoardConfig.backgroundImageRequired=false; //
			//gasket config:
			GasketConfig.maxPoolSize=9; //Notices:Object pools full of objects with dangerously stale state are sometimes called object cesspools and regarded as an anti-pattern.
			GasketConfig.tipsVisible=true; //Gasket label used to debugger.
			GasketConfig.backgroundAlpha=0.1; //
			GasketConfig.width=40;
			GasketConfig.height=40;
			//about piece:
			PieceConfig.factory=ChessFactory_TheBejeweledJam; //your custom chess factory.
			PieceConfig.maxPoolSizeBlue=5; //What's the number of blue(computer) chess pieces?
			PieceConfig.maxPoolSizeRed=5; //What's the number of red(human) chess pieces?
			//Notice:starling scaleX/Y seldom triggle touch event issues.
			PieceConfig.scaleX=1;
			PieceConfig.scaleY=1;
			//about plugin:
//			PluginConfig.gameID="dadc1bb72ac7ed7f"; //your custom game related id.
//			PluginConfig.boardID="51c558cd0315f8e7"; //your custom game related board id.
//			this._mochiads_game_id="dadc1bb72ac7ed7f"; //espical for mochi game platform.
			//TextureConfig
			TextureConfig.AssetEmbeds_1x_class=AssetEmbeds_1x;
			TextureConfig.AssetEmbeds_2x_class=AssetEmbeds_2x;
			//LogConfig
			LoggerConfig.filters=["com.godpaper.the_bejeweled_jam.busniess.managers.*", "com.godpaper.as3.services.*", "com.godpaper.as3.views.screens.HandshakeScreen"];
			//			LoggerConfig.filters=["*"];//Logging all.
			LoggerConfig.level=LogEventLevel.DEBUG;
			//
			LOG.debug("SigletonFactory(cp) test:{0}", FlexGlobals.chessPiecesModel.BLUE_BISHOP.dump());
			LOG.debug("SigletonFactory(cg) test:{0}", FlexGlobals.chessGasketsModel.gaskets);
			LOG.debug("SigletonFactory(cb) test:{0}", FlexGlobals.chessBoardModel.status.dump());
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}
	
}