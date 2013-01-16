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
	import com.godpaper.as3.business.factory.ChessFactoryBase;
	import com.godpaper.as3.business.managers.ChessPiecesManagerDefault;
	import com.godpaper.as3.configs.BoardConfig;
	import com.godpaper.as3.configs.GameConfig;
	import com.godpaper.as3.configs.GasketConfig;
	import com.godpaper.as3.configs.PieceConfig;
	import com.godpaper.as3.configs.PluginConfig;
	import com.godpaper.as3.configs.TextureConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.core.FlexGlobals;
	import com.godpaper.as3.core.IChessFactory;
	import com.godpaper.as3.core.IChessPieceManager;
	import com.godpaper.as3.model.ChessPiecesModel;
	import com.godpaper.as3.plugins.IPlug;
	import com.godpaper.as3.plugins.PluginUIComponent;
	import com.godpaper.as3.plugins.kongregate.KongregatePlugin;
	import com.godpaper.as3.plugins.mochi.MochiPlugin;
	import com.godpaper.as3.plugins.nonoba.NonobaPlugin;
	import com.godpaper.as3.plugins.platogo.PlatogoPlugin;
	import com.godpaper.as3.utils.LogUtil;
	import com.godpaper.as3.utils.VersionController;
	import com.godpaper.two_hit_one.buiness.factory.ChessFactory_TwoHitOne;
	import com.godpaper.two_hit_one.buiness.managers.ChessPieceManager_TwoHitOne;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	
	import mx.logging.ILogger;
	
	import net.hires.debug.Stats;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.textures.Texture;
	
	/**
	 * TwoHitOne.as class.   
	 * @see http://www.godpaper.com/godpaper/index.php/六子棋	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Jun 26, 2012 4:13:21 PM
	 */   	 
	[SWF(frameRate="60", width="400", height="480", backgroundColor="0xffffff")]//320×480 for iPhone devices
	//	[SWF(frameRate="60", width="384", height="512", backgroundColor="0xffffff")]//384×512 for iPad devices
	public class TwoHitOne extends ApplicationBase
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(TwoHitOne);
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
		public function TwoHitOne()
		{
			//TODO: implement function
			super();
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		/**
		 * Override this for customize chess pieces manager.
		 */
		override public function get chessPiecesManager():IChessPieceManager
		{
			//			return new ChessPieceManagerDefault();
			return new ChessPieceManager_TwoHitOne();
		}
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		override protected function initializeHandler():void
		{
			//config initialization here.
			//about chess board:
			BoardConfig.xLines=4;
			BoardConfig.yLines=4;
			BoardConfig.xOffset=100;
			BoardConfig.yOffset=100;	
//			BoardConfig.width=300;
//			BoardConfig.height=300;
			BoardConfig.xScale=1;
			BoardConfig.yScale=1;
			BoardConfig.xAdjust=50;
			BoardConfig.yAdjust=50;
			BoardConfig.backgroundImageRequired = true;
			//Customize starling texture sample:
			//			var texture:Texture = AssetEmbedsDefault.getTexture(DefaultConstants.IMG_BACK_GROUND);
			//			BoardConfig.backgroundImage = new Image(texture);
			//gasket config:
			GasketConfig.maxPoolSize = 25;
			GasketConfig.tipsVisible = true;
			GasketConfig.backgroundAlpha = 0.0;
			GasketConfig.width = 30;
			GasketConfig.height = 30;
			//about piece:
			PieceConfig.factory = ChessFactory_TwoHitOne;
			PieceConfig.maxPoolSizeBlue = 6;
			PieceConfig.maxPoolSizeRed = 6;
			//Notice:starling scaleX/Y seldom triggle touch event issues.
			PieceConfig.scaleX = 1.2;
			PieceConfig.scaleY = 1.2;
			//about plugin:
			PluginConfig.gameID = "cc2fd3b3196f4281";//your custom game related id.
			PluginConfig.boardID = "51c558cd0315f8e7";//your custom game related board id.
			this._mochiads_game_id = "cc2fd3b3196f4281";//espical for mochi game platform.
			//TextureConfig
			TextureConfig.AssetEmbeds_1x_class = AssetEmbeds_1x_two_hit_one;
			TextureConfig.AssetEmbeds_2x_class = AssetEmbeds_2x_two_hit_one;
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