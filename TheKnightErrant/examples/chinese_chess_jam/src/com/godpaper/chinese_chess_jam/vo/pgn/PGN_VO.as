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
	 * PGN(Portable Game Notation) VO.是棋类游戏过程的文件格式，既然国际象棋以这个规范作为记录棋谱的标准，那么对于中国象棋来说，在还没有一个统一标准的今天，PGN无疑是一个好的选择。
	 * @see http://www.xqbase.com/protocol/cchess_pgn.htm 	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Aug 3, 2012 12:54:23 PM
	 */   	 
	public class PGN_VO
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		public var game:String="";//游戏类型，国际象棋没有这个标签，中国象棋的PGN文件中这个标签必须放在第一位，其值必须为“Chinese Chess”；
		public var event:String="";//比赛名;
		public var site:String="";//比赛地点；
		public var date:String="";//比赛日期，格式统一为“yyyy.mm.dd”；
		public var round:String="";//比赛轮次；
		public var red:String="";//红方棋手，不同与国际象棋的White；
		public var black:String="";//黑方棋手；
		public var result:String="";//比赛结果，“红先胜”用“1-0”表示，“黑先胜”用“0-1”表示，和棋用“1/2-1/2”表示，未知用“*”表示。
		public var redTeam:String="";//这是棋手所属的代表队(俱乐部、棋协、省份或国家)，它们通常写在Red和Black标签的前面；
		public var blackTeam:String="";//
		//可参考《中国象棋开局编号——说明》一文；
		//@see http://www.xqbase.com/ecco/ecco_intro.htm
		public var opening:String="";//开局名称
		public var variation:String="";//变例
		public var ECCO:String="";//ECCO编号
		//
		public var FEN:String="";//开始局面，中局、残局和排局等摆出来的局面，作棋谱记录时通常要规定这个选项；
		public var format:String="";//表示记谱方法，可以是Chinese(中文纵线格式)、WXF(WXF纵线格式)和ICCS(ICCS坐标格式)，默认为Chinese。
		//
//		以下信息可以作为标签存在，也可以写在注释中：
//		　　(1) 棋手相关信息：红方有RedTitle、RedElo、RedNA(这项通常会被RedTeam所取代)、RedType等，黑方写法雷同；
//		　　(2) 赛事相关信息：EventDate、EventSponsor、Section、Stage、Board、Time等；
//		　　(3) 时限：以TimeControl为标签的多种表示。
//		　　(4) 对局结论，以Termination为标签的多种表示。
//		　　(5) 其他，诸如Annotator、Mode、PlyCount等，请参阅《国际象棋译文苑》文摘——关于PGN和FEN记谱规范(上)一文。
		//The chess book
		public var chessbook:ChessBookVO = new ChessBookVO();
		//Misc
		public var annotator:String="";//评注者(们)的名字
		public var mode:String="";//这是下该局的方式，比如OTB代表棋盘上，PM代表通过书面邮件，EM代表通过电子邮件，ICS指在网上站点下的，TC代表通过通常的长途电讯
		public var plyCount :String="";//表示该局的步数，严格来说是指“半”步数
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		public static const META_KEY_GAME:String = "Game";
		public static const META_KEY_EVENT:String = "Event";
		public static const META_KEY_SITE:String = "Site";
		public static const META_KEY_DATE:String = "Date";
		//
		public static const META_KEY_ROUND:String = "Round";
		public static const META_KEY_RED:String = "Red";
		public static const META_KEY_RED_TEAM:String = "RedTeam";
		public static const META_KEY_BLACK:String = "Black";
		public static const META_KEY_BLACK_TEAM:String = "BlackTeam";
		//
		public static const META_KEY_RESULT:String = "Result";
		public static const META_KEY_ECCO:String = "ECCO";
		public static const META_KEY_OPENING:String = "Opening";
		public static const META_KEY_VARIATION:String = "Variation";
		//
		public static const META_KEY_ANNOTATOR:String = "Annotator";
		public static const META_KEY_MODE:String = "Mode";
		public static const META_KEY_PLY_COUNT:String = "PlyCount";
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