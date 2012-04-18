package com.godpaper.as3.model
{
	import com.godpaper.as3.configs.BoardConfig;
	import com.godpaper.as3.consts.DefaultConstants;
	import com.godpaper.as3.errors.DefaultErrors;
	import com.godpaper.as3.model.vos.PositionVO;
	import com.godpaper.starling.views.components.ChessPiece;
	import com.lookbackon.ds.AStarNodeBoard;
	import com.lookbackon.ds.GraphBoard;
	import com.lookbackon.ds.NumberBoard;
	
	import de.polygonal.ds.Array2;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * This singlton class maintain the board status information and with manifestation(numercal,graphical,A*Node...) mode.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jul 18, 2011 12:08:28 PM
	 */   	 
	public class ChessBoardModel
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//Singleton instance of ChessBoardModel;
		private static var instance:ChessBoardModel;
		private var chessPiecesModel:ChessPiecesModel = ChessPiecesModel.getInstance();
		//The step number of game played displayed on chess board?.
		private var _stepNumber:Number=0;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		//----------------------------------
		//  stepNumber
		//----------------------------------
//		[Bindable]
		public function get stepNumber():Number
		{
			return _stepNumber;
		}

		public function set stepNumber(value:Number):void
		{
			_stepNumber = value;
		}
		//----------------------------------
		//  numercal
		//----------------------------------
		/**
		 * return the magic number board struct.
		 */		
		public function get numercal():NumberBoard
		{
			return new NumberBoard(BoardConfig.xLines, BoardConfig.yLines,BoardConfig.numConnex, BoardConfig.hConnex, BoardConfig.vConnex, BoardConfig.fdConnex, BoardConfig.bdConnex);
		}
		//----------------------------------
		//  graphical
		//----------------------------------
		/**
		 * return the graphical board struct.Should append the graph board properties and methods customization.
		 */		
		public function get graphical():GraphBoard
		{
			var graphical:GraphBoard = new GraphBoard(BoardConfig.xLines,BoardConfig.yLines);
			//with graph board properties and methods configuration.
//			graphical.addEdge(
//			graphical.addNode(
			return graphical;
		}
		//----------------------------------
		//  aStarNodes
		//----------------------------------
		/**
		 * @return the node type board struct.Integrated the A* algorithm and functions.
		 */		
		public function get aStarNodes():AStarNodeBoard
		{
			var aStarNodes:AStarNodeBoard = new AStarNodeBoard(BoardConfig.xLines,BoardConfig.yLines);
			for (var i:int=0; i < chessPiecesModel.pieces.length; i++)
			{
				var cp:ChessPiece= chessPiecesModel.pieces[i];
				if(null == cp)
				{
					aStarNodes.setWalkable(cp.position.x, cp.position.y,true);//only the blank cell is walkable.
				}
			}
			return aStarNodes;
		}
		//----------------------------------
		//  status
		//----------------------------------
		/**
		 * return the current board's status messages.
		 */		
		public function get status():PositionVO
		{
			var _gamePosition:PositionVO=new PositionVO();
			var board:Array2=new Array2(BoardConfig.xLines,BoardConfig.yLines);
			for (var i:int=0; i < chessPiecesModel.pieces.length; i++)
			{
				var cp:ChessPiece= chessPiecesModel.pieces[i];
				board.sett(cp.position.x, cp.position.y, cp);
			}
			_gamePosition.board=board;
			_gamePosition.color=DefaultConstants.FLAG_BLUE;
			return _gamePosition;
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
		public function ChessBoardModel(access:Private)
		{
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		/**
		 *
		 * @return the singleton instance of ChessBoardModel
		 *
		 */
		public static function getInstance():ChessBoardModel 
		{
			if (instance == null) 
			{
				instance=new ChessBoardModel(new Private());
			}
			return instance;
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
/**
 *Inner class which restricts construtor access to Private
 */
internal class Private 
{
}
