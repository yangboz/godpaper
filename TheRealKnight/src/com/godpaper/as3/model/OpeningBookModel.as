package com.godpaper.as3.model
{
	import com.godpaper.as3.errors.CcjErrors;
	import com.godpaper.as3.model.vos.ccjVO.BishopVO;
	import com.godpaper.as3.model.vos.ccjVO.CannonVO;
	import com.godpaper.as3.model.vos.ccjVO.KnightVO;
	import com.godpaper.as3.model.vos.ccjVO.MarshalVO;
	import com.godpaper.as3.model.vos.ccjVO.OfficalVO;
	import com.godpaper.as3.model.vos.ccjVO.PawnVO;
	import com.godpaper.as3.model.vos.ccjVO.RookVO;
	import com.godpaper.as3.utils.LogUtil;
	import com.lookbackon.ds.BitBoard;
	
	import de.polygonal.ds.Array2;
	import de.polygonal.ds.Graph;
	import de.polygonal.ds.GraphNode;
	
	import mx.logging.ILogger;
	
	/**
	 * <b>A singleton model hold chess board opening book information.</b></p>
	 * Whether you like it or not,opening book are very important in many games.</br>
	 * Some games already have a large body of thory produced by humams(e.g. chess,checker),</br>
	 * for other games,particularly for relatively new or less popular games, there is nothing to go on. </br>
	 * For those games where humans are competitive (like in chess), </br>
	 * there is a simple approach to generating an opening book: </br>
	 * produce it manually, selecting moves played by strong players. </br>
	 * This type of approach is obivously not very interesting for our purposes,</br>
	 * and for games where there is no theory or where computers are already superior to humans (like checkers), </p>
	 * it is impossible or pointless. I will only look at approaches to generating books without manual intervention.</p>
	 * 
	 * <b>Automated generation from a database</b></p>
	 * A simple way to generate an opening book is to take a database of games,</br>
	 * and select promising moves based on the results of games in that database.</p>
	 * 
	 * <b>Automated computation by drop-out expansion</b></p>
	 * If there is no human theory available, then you will have to compute an opening book with your program itself. </p>
	 * 
	 * <b>DOE in the real world</b></p>
	 * DOE is a relatively new technique and has been applied successfully to checkers (by Ed Gilbert and Fierz) and Awari (by Thomas Lincke).</p>
	 * 
	 * @see http://www.fierz.ch/strategy4.htm
	 * @see http://chess.uoknor.edu
	 * @see Computers and games: Second International Conference, CG 2000, Hamamatsu ...By T. Anthony Marsland, Ian Frank
	 * @see 2004CCC.pdf
	 * @author Knight.zhou
	 * 
	 */	
	public class OpeningBookModel
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//Singleton instance of OpeningBookModel;
		private static var instance:OpeningBookModel;
		//
		private var _startNode:GraphNode;
		private var _interiorNode:GraphNode;
		private var _leafNode:GraphNode;
		private var _expansion:Graph;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		private static const LOG:ILogger = LogUtil.getLogger(OpeningBookModel);
		//generation.
		//TODO.other structs.
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function OpeningBookModel(access:Private)
		{
			if (access != null) {
				if (instance == null) {
					instance=this;
				}
			} else {
				throw new CcjErrors(CcjErrors.INITIALIZE_SINGLETON_CLASS);
			}
		}
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  startNode
		//----------------------------------
		public function get startNode():GraphNode
		{
			return _startNode;
		}
		/**
		 * 
		 * @param value represents the start position.
		 * 
		 */		
		public function set startNode(value:GraphNode):void
		{
			_startNode = value;
			//TODO:create expansion.define interiorNode,leafNode.
		}
		//----------------------------------
		//  interiorNode
		//----------------------------------
		public function get interiorNode():GraphNode
		{
			return _interiorNode;
		}
		/**
		 * 
		 * @param value a node has an edge for each of it moves.
		 * 
		 */		
		public function set interiorNode(value:GraphNode):void
		{
			_interiorNode = value;
		}
		//----------------------------------
		//  leafNode
		//----------------------------------
		public function get leafNode():GraphNode
		{
			return _leafNode;
		}
		/**
		 * 
		 * @param value a node has not an edge for each of it moves.
		 * 
		 */		
		public function set leafNode(value:GraphNode):void
		{
			_leafNode = value;
		}
		//----------------------------------
		//  expansion(read-only)
		//----------------------------------
		/**
		 * When an opening book is created,it contains only the start node.</br>
		 * Expansion is done with three steps.</br>
		 * 1.Choose a leaf node and add all successors to the book.</br>
		 * 2.Calculate the values of the new successors.</br>
		 * 3.Propagate the values.</br>
		 * 
		 * @param value deal with the first step with next node.
		 * 
		 */	
		public function get expansion():Graph
		{
			return _expansion;
		}
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------	
		/**
		 *
		 * @return the singleton instance of OpeningBookModel
		 *
		 */
		public static function getInstance():OpeningBookModel 
		{
			if (instance == null) 
			{
				instance=new OpeningBookModel(new Private());
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
/**
 * Every node has two attribute:</br>
 * 1.the huristic value is computed by the search engine,using a brute-force search.</br>
 * 2.the propagated value.</br>
 * For interior node P(i) is the negamax value of P(i) of P(S(j)) of all successor S(j).</br>
 * For leaf node P(i) is equal to H(i).</br>
 * For book construction it is not actually nesscesssary to keep H(i) once i has become interior node.</br>
 * However,for testing the expansion strategies,it is usful to be able to compare H(i) and P(j) during the calculation.</br>
 * Unless explicitely stated otherwise,let value mean progagated value.</br>
 * ----[MAX s(j)(-Ps(j)) for interior node.	</br>
 * P(i)|</br>
 * ----[H(i)             for leaf node.</br>
 */
internal class BookNode
{
	public var huristic:int;
	public var propagated:int;
	
	public function BookNode(huristic:int=-1,propagated:int=-1)
	{
		this.huristic =  huristic;
		this.propagated = propagated;
	}
}