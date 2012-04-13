package com.godpaper.as3.core
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	import com.godpaper.as3.views.components.ChessGasket;
	/**
	 * The term X-ray attack was apparently originated by Kenneth Harkness. </br>
	 * On page 25 of the April 1947 Chess Review, in his series Picture Guide to Chess, </br>
	 * he mentioned forks and then wrote [1]:</br>
	 * There is another type of double attack in which the targets are threatened in one direction. </br>
	 * The attacking piece threatens two units, one behind the other, on the same rank, file or diagonal. </br>
	 * This double threat has lacked a good descriptive name. We suggest ‘X-Ray’ attack.</br>
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Feb 17, 2011 5:27:53 PM
	 */
	public interface IXray
	{
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		//----------------------------------
		//  X-Ray properties
		//----------------------------------
		function get bottomNode():ChessGasket;

		function get rightNode():ChessGasket;

		function get upNode():ChessGasket;

		function get leftNode():ChessGasket;
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

