package com.lookbackon.ds
{
	import de.polygonal.ds.Array2;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * This interface pre-define the board data struct aviable functions. 	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jun 2, 2011 1:55:22 PM
	 */
	public interface IConnex
	{
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		/**
		 * Should keep the providing board as the same size of numberboard.
		 * Partial with flag object to indentify the connex elements.
		 * @param board the board resource;
		 * @param len the length of connex;
		 * @return the calculated connections;
		 */			
		function getConnex(board:Array2,len:int):Array;
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
	}
}