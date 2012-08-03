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
package com.godpaper.chinese_chess_jam.business
{
	import com.godpaper.as3.utils.LogUtil;
	
	import mx.logging.ILogger;
	
	import org.hamcrest.text.RegExpMatcher;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * A parser with PGN(Portable Game Notation) file;   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Aug 3, 2012 1:09:56 PM
	 */   	 
	public class PGN_Parser
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var pgnString:String;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const WHITESPACE:Vector.<String> = new Vector.<String>(" ","\t","\n","\r","\f");//" \t\n\r\f"
		private static const DIGITS:String = "0123456789";
		private static const FILES:String = "abcdefghABCDEFGH";
		private static const RANKS:String = "12345678";
		private static const PIECES:String = "车马象士将炮兵";
		private static const MOVECHARACTERS:String = FILES + RANKS + PIECES + "xX:-=Oo+#";
		private static const GAMETERMCHARACTERS:String = "01-2/";
		//
		private static const LOG:ILogger = LogUtil.getLogger(PGN_Parser);
		//RegExpressions
		private static const REG_EXP_METADATA:RegExp = /\[.*\]$/igms;
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
		public function PGN_Parser(pgnStr:String)
		{
			this.pgnString = pgnStr;
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		public function parse():void
		{
//			var lines:Array = this.pgnString.split(WHITESPACE);
//			LOG.debug(lines.toString());
//			var regExp:RegExpMatcher = new RegExpMatcher(
			var labelStr:String = REG_EXP_METADATA.exec(this.pgnString);
			for(var i:int=0;i<WHITESPACE.length;i++)
			{
				labelStr = labelStr.split(WHITESPACE[i]).join("");
			}
			LOG.debug(labelStr);
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