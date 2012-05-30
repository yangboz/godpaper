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
	
	/**
	 * AssetsEmbed_2x.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created May 30, 2012 2:44:17 PM
	 */   	 
	public class AssetEmbeds_2x
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		//tollgate icon class here
		[Embed(source="/assets/images/2x/icon_tollgate00.png")]
		public static const ICON_TOLLGATE_01:Class;
		
		[Embed(source="/assets/images/2x/icon_tollgate01.png")]
		public static const ICON_TOLLGATE_02:Class;
		
		[Embed(source="/assets/images/2x/icon_tollgate02.png")]
		public static const ICON_TOLLGATE_03:Class;
		
		[Embed(source="/assets/images/2x/icon_tollgate03.png")]
		public static const ICON_TOLLGATE_04:Class;
		
		[Embed(source="/assets/images/2x/icon_tollgate04.png")]
		public static const ICON_TOLLGATE_05:Class;
		
		//plugin category icon class here.
		[Embed(source="/assets/images/2x/icon_store.png")]
		public static const ICON_STORE:Class;
		
		[Embed(source="/assets/images/2x/icon_coin.png")]
		public static const ICON_COIN:Class;
		
		[Embed(source="/assets/images/2x/icon_account.png")]
		public static const ICON_ACCOUNT:Class;
		//
		// Bitmaps
		
		[Embed(source="/assets/images/2x/background.png")]
		public static const IMG_BACK_GROUND:Class;
		
		// Compressed textures
		
//		[Embed(source="/assets/textures/2x/compressed_texture.atf", mimeType="application/octet-stream")]
//		public static const CompressedTexture:Class;
		
		// Fonts
		
		// The 'embedAsCFF'-part IS REQUIRED!!!!
		[Embed(source="/assets/fonts/2x/Ubuntu-R.ttf", embedAsCFF="false", fontFamily="Ubuntu")]
		public static const UbuntuRegular:Class;
		
		[Embed(source="/assets/fonts/2x/desyrel.fnt", mimeType="application/octet-stream")]
		public static const DesyrelXml:Class;
		
		[Embed(source="/assets/fonts/2x/desyrel.png")]
		public static const DesyrelTexture:Class;
		
		// Texture Atlas
		[Embed(source="/assets/textures/2x/defaultAtlasTexture.xml", mimeType="application/octet-stream")]
		public static const AtlasTextureXml:Class;
		
		[Embed(source="/assets/textures/2x/defaultAtlasTexture.png")]
		public static const AtlasTexture:Class;
		
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