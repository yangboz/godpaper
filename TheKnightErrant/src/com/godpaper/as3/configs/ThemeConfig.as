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
package com.godpaper.as3.configs
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.core.FlexGlobals;
	
	import chinese_chess_jam.src.feathers.themes.AeonDesktopTheme;
	import feathers.themes.AzureTheme;
	import feathers.themes.MinimalTheme;
	import the_bejeweled_jam.src.feathers.themes.MetalWorksMobileTheme;

	import feathers.skins.IFeathersTheme;
	/**
	 * ThemeConfig.as class.Used to customize the whole application's theme.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Aug 16, 2012 1:55:18 PM
	 */   	 
	public class ThemeConfig
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//Keep the one instance.
		private static var _instance:IFeathersTheme;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		//Theme class enum list.
		public static var THEME_MINIMAL:Class = MinimalTheme;
//		public static var THEME_AZURE:Class = AzureTheme;
//		public static var THEME_AEON_DESKTOP:Class = AeonDesktopTheme;
//		public static var THEME_METAL_WORK_MOBILE:Class = MetalWorksMobileTheme;
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
		public static function getThemeImpl(...args):IFeathersTheme
		{
			var themeClass:Class = FlexGlobals.topLevelApplication.themeClass;
			if(_instance==null) _instance = new themeClass(args[0]);//TODO:more arguments assemble.
			return _instance;
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