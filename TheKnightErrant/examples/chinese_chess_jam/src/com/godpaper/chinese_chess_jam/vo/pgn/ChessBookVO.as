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
package chinese_chess_jam.src.com.godpaper.chinese_chess_jam.vo.pgn
{
	import mx.utils.ObjectUtil;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * ChessBookVO,棋谱部分是PGN的主要内容，记录了每一回合的着法、评注和结果。
	 * @see http://www.xqbase.com/protocol/cchess_pgn.htm   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Aug 7, 2012 11:04:01 AM
	 */   	 
	public class ChessBookVO
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
//		对于这部分内容的格式，有以下几个规定：
//		(1) 棋谱部分必须在标签部分的后面，棋谱部分当中不能插入标签；
//		(2) 每一回合都由“回合数”、“红方着法”和“黑方着法”三部分组成，回合数后面要跟“.”(句点)，三者之间用两个分隔符隔开(回合数后面的句点也不例外)，回合之间也用分隔符隔开；
//	    (3) 着法的表示必须和Format标签相统一，如果没有Format标签，则用中文纵线格式来表示；
//		(4) 分割符只能是空格、制表符或换行符，一个着法当中不能有分割符(回合数也一样)；
//		(5) 评注用花括号“{}”表示，评注内可以是除花括号以外的任何字符(包括分割符)，评注可以插在任何着法的后面，它和着法之间必须用分割符隔开；
//		(6) 整个棋局结束时必须用“1-0”(红方胜)、“0-1”(黑方胜)、“1/2-1/2”(和棋)或“*”(未知)表示结果，结果和着法之间必须用分割符隔开；
//	    (7) 结果以后只能有评注，不能有着法；如果出现标签，则说明这是下一局棋。
		public var title:String = "";
		public var body:Vector.<ChessBookMoveVO> = new Vector.<ChessBookMoveVO>();
		public var footer:String = "";//Result：比赛结果，“红先胜”用“1-0”表示，“黑先胜”用“0-1”表示，和棋用“1/2-1/2”表示，未知用“*”表示。
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		
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
		public function toString():String
		{
			return ObjectUtil.toString(this);
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