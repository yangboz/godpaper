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
package com.godpaper.as3.business
{
	import com.godpaper.as3.model.PGN_Model;
	import com.godpaper.as3.model.vos.pgn.ChessBookMoveVO;
	import com.godpaper.as3.model.vos.pgn.ChessBookVO;
	import com.godpaper.as3.model.vos.pgn.PGN_VO;
	import com.godpaper.as3.utils.LogUtil;

	import mx.logging.ILogger;
	import mx.utils.StringUtil;
	
	import org.hamcrest.text.RegExpMatcher;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * A parser with PGN(Portable Game Notation) file;
	 * @see https://github.com/mikechambers/as3corelib/tree/master/src/com/adobe/serialization/json   	
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
		private var _source:String;
		private var pgnVO:PGN_VO;
		private var chessbookVO:ChessBookVO;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
//		private const WHITESPACE:Vector.<String> = new Vector.<String>(" ","\t","\n","\r","\f");//" \t\n\r\f"
		private const WHITESPACE:String = " \t\n\r\f";
//		private const DIGITS:String = "0123456789";
//		private const FILES:String = "abcdefghABCDEFGH";
//		private const RANKS:String = "12345678";
//		private const PIECES:String = "车马象士将炮兵";
//		private const MOVECHARACTERS:String = FILES + RANKS + PIECES + "xX:-=Oo+#";
//		private const GAMETERMCHARACTERS:String = "01-2/";
		//
		private static const LOG:ILogger = LogUtil.getLogger(PGN_Parser);
		//RegExpressions
		private const REG_EXP_META_DATA:RegExp = /\[.*\]$/igms;//metadata
		private const REG_EXP_CHESS_BOOK:RegExp = /\{.*\}$/igms;//chessbook
		//Model
		private var pgnModel:PGN_Model = PGN_Model.getInstance();
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		public function get source():String
		{
			return _source;
		}
		
		public function set source(value:String):void
		{
			_source = value;
			//Update model
			pgnModel.source = value;
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
		public function PGN_Parser(source:String="")
		{
			this._source = StringUtil.trim(source);
			this.pgnVO = new PGN_VO();
			this.chessbookVO = new ChessBookVO();
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		public function parse():void
		{
			this.chessbookParse();
			this.metaDataParse();
			var pgnModel:PGN_Model = PGN_Model.getInstance();
			trace(pgnModel);
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
		//
		private function metaDataParse():void
		{
			var metaLabelStr:String = REG_EXP_META_DATA.exec(this.source);
			//			LOG.debug(metaLabelStr);
			var metaLabels:Array = metaLabelStr.split("\n");
			//			LOG.debug(metaLabels.toString());
			//
			for(var i:int=0;i<metaLabels.length;i++)
			{
				//Game
				if(String(metaLabels[i]).indexOf(PGN_VO.META_KEY_GAME)!=-1)
				{
					var gameLabels:Array = String(metaLabels[i]).split("\"");
					this.pgnVO.game = gameLabels[1];
					LOG.debug("pgnVO->game:{0}",this.pgnVO.game);
				}
				//Event
				if(String(metaLabels[i]).indexOf(PGN_VO.META_KEY_EVENT)!=-1)
				{
					var eventLabels:Array = String(metaLabels[i]).split("\"");
					this.pgnVO.event = eventLabels[1];
					LOG.debug("pgnVO->event:{0}",this.pgnVO.event);
				}
				//Site
				if(String(metaLabels[i]).indexOf(PGN_VO.META_KEY_SITE)!=-1)
				{
					var siteLabels:Array = String(metaLabels[i]).split("\"");
					this.pgnVO.site = siteLabels[1];
					LOG.debug("pgnVO->site:{0}",this.pgnVO.site);
				}
				//Date
				if(String(metaLabels[i]).indexOf(PGN_VO.META_KEY_DATE)!=-1)
				{
					var dateLabels:Array = String(metaLabels[i]).split("\"");
					this.pgnVO.date = dateLabels[1];
					LOG.debug("pgnVO->date:{0}",this.pgnVO.date);
				}
				//Round
				if(String(metaLabels[i]).indexOf(PGN_VO.META_KEY_ROUND)!=-1)
				{
					var roundLabels:Array = String(metaLabels[i]).split("\"");
					this.pgnVO.round = roundLabels[1];
					LOG.debug("pgnVO->round:{0}",this.pgnVO.round);
				}
				//Red
				if(String(metaLabels[i]).indexOf(PGN_VO.META_KEY_RED)!=-1)
				{
					var redLabels:Array = String(metaLabels[i]).split("\"");
					this.pgnVO.red = redLabels[1];
					LOG.debug("pgnVO->red:{0}",this.pgnVO.red);
				}
				//RedTeam
				if(String(metaLabels[i]).indexOf(PGN_VO.META_KEY_RED_TEAM)!=-1)
				{
					var redTeamLabels:Array = String(metaLabels[i]).split("\"");
					this.pgnVO.redTeam = redTeamLabels[1];
					LOG.debug("pgnVO->redTeam:{0}",this.pgnVO.redTeam);
				}
				//Black
				if(String(metaLabels[i]).indexOf(PGN_VO.META_KEY_BLACK)!=-1)
				{
					var blackLabels:Array = String(metaLabels[i]).split("\"");
					this.pgnVO.black = blackLabels[1];
					LOG.debug("pgnVO->black:{0}",this.pgnVO.black);
				}
				//BlackTeam
				if(String(metaLabels[i]).indexOf(PGN_VO.META_KEY_BLACK_TEAM)!=-1)
				{
					var blackTeamLabels:Array = String(metaLabels[i]).split("\"");
					this.pgnVO.blackTeam = blackTeamLabels[1];
					LOG.debug("pgnVO->blackTeam:{0}",this.pgnVO.blackTeam);
				}
				//Result
				if(String(metaLabels[i]).indexOf(PGN_VO.META_KEY_RESULT)!=-1)
				{
					var resultLabels:Array = String(metaLabels[i]).split("\"");
					this.pgnVO.result = resultLabels[1];
					LOG.debug("pgnVO->result:{0}",this.pgnVO.result);
				}
				//ECCO
				if(String(metaLabels[i]).indexOf(PGN_VO.META_KEY_ECCO)!=-1)
				{
					var eccoLabels:Array = String(metaLabels[i]).split("\"");
					this.pgnVO.ECCO = eccoLabels[1];
					LOG.debug("pgnVO->ECCO:{0}",this.pgnVO.ECCO);
				}
				//Opening
				if(String(metaLabels[i]).indexOf(PGN_VO.META_KEY_OPENING)!=-1)
				{
					var openingLabels:Array = String(metaLabels[i]).split("\"");
					this.pgnVO.opening = openingLabels[1];
					LOG.debug("pgnVO->opening:{0}",this.pgnVO.opening);
				}
				//Variation
				if(String(metaLabels[i]).indexOf(PGN_VO.META_KEY_VARIATION)!=-1)
				{
					var variationLabels:Array = String(metaLabels[i]).split("\"");
					this.pgnVO.variation = variationLabels[1];
					LOG.debug("pgnVO->variation:{0}",this.pgnVO.variation);
				}
				//Annotator
				if(String(metaLabels[i]).indexOf(PGN_VO.META_KEY_ANNOTATOR)!=-1)
				{
					var annotatorLabels:Array = String(metaLabels[i]).split("\"");
					this.pgnVO.annotator = annotatorLabels[1];
					LOG.debug("pgnVO->annotator:{0}",this.pgnVO.annotator);
				}
				//Mode
				if(String(metaLabels[i]).indexOf(PGN_VO.META_KEY_MODE)!=-1)
				{
					var modeLabels:Array = String(metaLabels[i]).split("\"");
					this.pgnVO.mode = modeLabels[1];
					LOG.debug("pgnVO->mode:{0}",this.pgnVO.mode);
				}
				//PlyCount
				if(String(metaLabels[i]).indexOf(PGN_VO.META_KEY_PLY_COUNT)!=-1)
				{
					var plyCountLabels:Array = String(metaLabels[i]).split("\"");
					this.pgnVO.plyCount = plyCountLabels[1];
					LOG.debug("pgnVO->plyCount:{0}",this.pgnVO.plyCount);
				}
				//...
			}
			//			LOG.debug(labelStr);
			//Update model
			pgnModel.pgnVO = this.pgnVO;
		}
		//
		private function chessbookParse():void
		{
			//
			var allLables:Array = this.source.split("\n");
//			LOG.debug(allLables.toString());//TODO:double check the position assure is valid.
			this.chessbookVO.footer = allLables[allLables.length-1];
			//
			var chessbookLabelStr:String = REG_EXP_CHESS_BOOK.exec(this.source);
//			LOG.debug("chessbook:{0}",chessbookLabelStr);
			var chessbookLabels:Array = chessbookLabelStr.split("\n");
//			LOG.debug("origin chessbook:{0}",chessbookLabels.toString());
			//ChessBookVO assemble
			//title
			this.chessbookVO.title = chessbookLabels[0];
			//shift the chessbook' title.
			chessbookLabels.shift();
			var bodyStr:String = StringUtil.trim(this.source);
			//First off,group the chessbook label
			var chessbookLabelGroups:Vector.<String> = new Vector.<String>();
			//XXX:double check all of the PGN file's chess book index identify with this flags "1/2/3."
			for(var i:int=1;i<bodyStr.length;i++)
			{
				var indexStr:String = String(i).concat(".");
				var currIndex:int = bodyStr.indexOf(indexStr);
				var lastIndex:int = bodyStr.lastIndexOf(indexStr);
				var nextIndexStr:String = String(i+1).concat(".");
				var nextIndex:int = bodyStr.indexOf(nextIndexStr,i);
				if(nextIndex==-1) break;//cut off the string stack process.
				var chessBookStr:String = bodyStr.substring(currIndex,nextIndex);
				chessBookStr = chessBookStr.split("\n").join("");
				chessBookStr = chessBookStr.split("\r").join("");
				chessBookStr = chessBookStr.split("\s").join("");
				chessBookStr = chessBookStr.split("\t").join("");
				chessBookStr = chessBookStr.split(" ").join("");
				//Assemble the string stack.
//				chessbookLabelGroups[i-1] = StringUtil.trim(chessBookStr);
				chessbookLabelGroups[i-1] = chessBookStr;
			}
			LOG.debug("trimmed chessbook labels:{0}",chessbookLabelGroups.toString());
			//move list assemble
			//@example as follows:
//			10. 车六进一 
//			{ 去士，下着变二 }
//			10...        士５退４ 
//			{ 去车，变二 }
			const curlyBracesLeft:String = "{";
			const curlyBracesRight:String = "}";
			var cbMoveVO:ChessBookMoveVO;
			for(var j:int=0;j<chessbookLabelGroups.length;j++)
			{
				cbMoveVO = new ChessBookMoveVO();
				//Option 01(no comments,one sentence)
				if(chessbookLabelGroups[j].indexOf(curlyBracesLeft)==-1)//no comments
				{
					var dotIndex:int;
					var strLen:int = chessbookLabelGroups[j].length;
					//simplify to one sentence
					if(chessbookLabelGroups[j].indexOf("...")==-1)
					{
						//move info
						dotIndex = chessbookLabelGroups[j].lastIndexOf(".");
						cbMoveVO.redMove = chessbookLabelGroups[j].substr(dotIndex+1,ChessBookMoveVO.LEN_OF_MOVE_CHAR);//one for red
						cbMoveVO.blackMove = chessbookLabelGroups[j].substring(strLen-ChessBookMoveVO.LEN_OF_MOVE_CHAR,strLen);//the other for black
					}
				}
				//Option 02(one or more comments)
				else if(chessbookLabelGroups[j].indexOf(curlyBracesLeft)!=-1)
				{
					//comments parse
					if(chessbookLabelGroups[j].indexOf(curlyBracesLeft)!=-1 && chessbookLabelGroups[j].indexOf(curlyBracesRight)!=-1)//a pair of curly braces.
					{
						//move info
						dotIndex = chessbookLabelGroups[j].indexOf(".");
						var dotLastIndex:int = chessbookLabelGroups[j].lastIndexOf(".");
						cbMoveVO.redMove = chessbookLabelGroups[j].substr(dotIndex+1,ChessBookMoveVO.LEN_OF_MOVE_CHAR);//one for red
						cbMoveVO.blackMove = chessbookLabelGroups[j].substr(dotLastIndex+1,ChessBookMoveVO.LEN_OF_MOVE_CHAR);//the other for black
						//comments
						var index_curlyBraceLeft01:int = chessbookLabelGroups[j].indexOf(curlyBracesLeft);
						var index_curlyBraceLeft02:int = chessbookLabelGroups[j].lastIndexOf(curlyBracesLeft);
						var index_curlyBraceRight01:int = chessbookLabelGroups[j].indexOf(curlyBracesRight);
						var index_curlyBraceRight02:int = chessbookLabelGroups[j].lastIndexOf(curlyBracesRight);
						if(index_curlyBraceLeft01!=-1 && index_curlyBraceRight01!=-1)
						{
							cbMoveVO.redComments = chessbookLabelGroups[j].substring(index_curlyBraceLeft01+1,index_curlyBraceRight01);
						}
						if(index_curlyBraceLeft02!=-1 && index_curlyBraceRight02!=-1)
						{
							cbMoveVO.blackComments = chessbookLabelGroups[j].substring(index_curlyBraceLeft02+1,index_curlyBraceRight02);
						}
					}
				}else
				{
					//
				}
				//
				this.chessbookVO.body.push(cbMoveVO);
			}
			//
			LOG.debug("#0,chessbookMoveVO:{0}",this.chessbookVO.body[0].toString());
			//Update model
			pgnModel.chessbookVO = this.chessbookVO;
		}
	}
	
}