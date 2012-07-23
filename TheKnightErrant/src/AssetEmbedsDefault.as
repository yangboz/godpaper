package 
{
	import com.godpaper.as3.configs.TextureConfig;
	
	import flash.display.Bitmap;
	import flash.media.Sound;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------

	/**
	 * A class for obtainning static embeded resources(images,fonts,sound,texture...).
	 * @see http://livedocs.adobe.com/flex/3/html/help.html?content=embed_3.html
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Aug 12, 2011 10:32:59 AM
	 */
	public class AssetEmbedsDefault
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		// Texture cache
		private static var sTextures:Dictionary=new Dictionary();
		private static var sSounds:Dictionary=new Dictionary();
		private static var sTextureAtlas:TextureAtlas;
		private static var sBitmapFontsLoaded:Boolean;
		private static var sContentScaleFactor:int = 1;
		//About chess pieces
		private static var cpTextureAtlas:TextureAtlas;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		//
		// Bitmaps
		// Comment out for your custom chess background image texture.
//		[Embed(source="/assets/images/background.png")]
//		private static const IMG_BACK_GROUND:Class;

		// Sounds
		//Refs:http://soundrangers.com/index.cfm?currentpage=3&fuseaction=category.display&category_id=554
		[Embed(source="/assets/audio/chess_piece_move.mp3")]
		public static const SOUND_CP_MOVE:Class;
		
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
		//
		public static function getClass(name:String):Class
		{
			return create(name) as Class;
		}
		//
		public static function getTexture(name:String):Texture
		{
			if (sTextures[name] == undefined)
			{
				var data:Object= create(name);
				//
				if (data is Bitmap)
					sTextures[name]=Texture.fromBitmap(data as Bitmap);
				else if (data is ByteArray)
					sTextures[name]=Texture.fromAtfData(data as ByteArray);
			}

			return sTextures[name];
		}

		//
		public static function getTextureAtlas():TextureAtlas
		{
			if (sTextureAtlas == null)
			{
				var texture:Texture = getTexture("AtlasTexture");
				var xml:XML = XML(create("AtlasTextureXml"));
				sTextureAtlas = new TextureAtlas(texture, xml);
			}
			
			return sTextureAtlas;
		}

		//
		public static function loadBitmapFonts():void
		{
			if (!sBitmapFontsLoaded)
			{
				var texture:Texture=getTexture(TextureConfig.altalsTexture_font_name);
				var xml:XML=XML(create(TextureConfig.altalsTexture_font_xml_name));
				TextField.registerBitmapFont(new BitmapFont(texture, xml));
				sBitmapFontsLoaded=true;
			}
		}
		//About chess pieces
		public static function getChessPiecesTextureAtlas():TextureAtlas
		{
			if (cpTextureAtlas == null)
			{
				var texture:Texture = getTexture(TextureConfig.altalsTexture_img_name);
				var xml:XML = XML(createChessPieces(TextureConfig.altalsTexture_xml_name));
				cpTextureAtlas = new TextureAtlas(texture, xml);
			}
			
			return cpTextureAtlas;
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
		//Default create
		private static function create(name:String):Object
		{
			var textureClass:Class = sContentScaleFactor == 1 ? AssetEmbeds_1x : AssetEmbeds_2x;
			return new textureClass[name];
		}
		//Chess pieces' create
		private static function createChessPieces(name:String):Object
		{
			var textureClass:Class = (sContentScaleFactor == 1)?TextureConfig.AssetEmbeds_1x_class:TextureConfig.AssetEmbeds_2x_class;
			return new textureClass[name];
		}
		
		public static function get contentScaleFactor():Number { return sContentScaleFactor; }
		public static function set contentScaleFactor(value:Number):void 
		{
			for each (var texture:Texture in sTextures)
			texture.dispose();
			
			sTextures = new Dictionary();
			sContentScaleFactor = value < 1.5 ? 1 : 2; // assets are available for factor 1 and 2 
		}
	}

}
