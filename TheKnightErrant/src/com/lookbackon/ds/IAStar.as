package com.lookbackon.ds
{
	import com.lookbackon.ds.aStar.AStarNode;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * Holds a two-dimensional array of Nodes methods to manipulate them, start node and end node for finding a path.</br>
	 * <b>Notice:</b> this class code base based on some open source code.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created May 16, 2011 3:27:41 PM
	 */
	public interface IAStar
	{
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		/**
		 * Returns the end node.
		 */
		function get endNode():AStarNode;
		/**
		 * Returns the start node.
		 */
		function get startNode():AStarNode;
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//-------------------------------------------------------------------------- 
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		/**
		 * Returns the node at the given coords.
		 * @param x The x coord.
		 * @param y The y coord.
		 */
		function getNode(x:int, y:int):AStarNode;
		/**
		 * Sets the node at the given coords as the end node.
		 * @param x The x coord.
		 * @param y The y coord.
		 */
		function setEndNode(x:int, y:int):void;
		/**
		 * Sets the node at the given coords as the start node.
		 * @param x The x coord.
		 * @param y The y coord.
		 */
		function setStartNode(x:int, y:int):void;
		/**
		 * Sets the node at the given coords as walkable or not.
		 * @param x The x coord.
		 * @param y The y coord.
		 */
		function setWalkable(x:int, y:int, value:Boolean):void;
	}
}