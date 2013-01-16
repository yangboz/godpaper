package com.godpaper.as3.model
{
	import com.godpaper.as3.errors.DefaultErrors;
	import com.godpaper.as3.utils.LogUtil;
	
	import mx.logging.ILogger;

	/**
	 * A singleton model hold chess board opening book information.</p>
	 *
	 * In the endgame, few Pawns remain, so other strong pieces have more space to move.</p>
	 * The search depth in this stage is limited owing to the freedom of the pieces
	 * and the large size of the Chinese chessboard. </p>
	 * Since, human players can employ expert knowledge to help search in this stage,
	 * most Chinese-chess programs are inferior to human players in this stage. </p>
	 * Hence, improving the endgame is key to defeating human top players.</p>
	 * The earliest retrograde algorithm is proposed by Ströhlein (1970). </p>
	 * Subsequently Van den Herik and Herschberg (1985) have significantly contributed to the retrograde concept. </p>
	 * Then Thompson (1986, 1996) has published his great contributions to Western-chess endgames. </p>
	 * His endgame databases built on retrograde analysis succeeded
	 * to increase the playing strength of many chess-playing programs. </p>
	 * Thereafter we have seen the contributions by Nalimov et al. (2001). </p>
	 * In recent years, many people have shown interest in developing Chinese-chess endgame databases (Fang, 1996, 2001, 2003;
	 * Hsu and Liu, 2002; Wu and Beal, 2001a,b,c).</p>
	 * Their essential procedure is using a retrograde algorithm to construct the basic endgame database
	 * and then constructing the more complex endgame database gradually. </p>
	 * This kind of endgame system contains complete information. </p>
	 * That is, it has knowledge on wins or losses, and it knows the optimal moves. </p>
	 * Nowadays, acomputer can automatically, without the help of expert knowledge, construct such endgame databases.</p>
	 * Rather than being built on retrograde analysis, an endgame database can also be built on massive experts’ knowledge (Chen, 1998).</p>
	 * This kind of endgame database is smaller, more practical and easier to incorporate into the existing Chinese-chess programs.</p>
	 *
	 * @author Knight.zhou
	 *
	 */	
	public class EndingGameModel
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//Singleton instance of EndGameModel;
		private static var instance:EndingGameModel;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(EndingGameModel);
		//generation.
		//TODO.other structs.
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function EndingGameModel(access:Private)
		{
			if (access != null) {
				if (instance == null) {
					instance=this;
				}
			} else {
				throw new DefaultErrors(DefaultErrors.INITIALIZE_SINGLETON_CLASS);
			}
		}
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------	
		/**
		 *
		 * @return the singleton instance of EndGameModel
		 *
		 */
		public static function getInstance():EndingGameModel 
		{
			if (instance == null) 
			{
				instance=new EndingGameModel(new Private());
			}
			return instance;
		}
	}
}
/**
 *Inner class which restricts construtor access to Private
 */
internal class Private 
{
}

