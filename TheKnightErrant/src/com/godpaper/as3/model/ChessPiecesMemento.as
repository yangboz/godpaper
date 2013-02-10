package com.godpaper.as3.model
{
	import com.godpaper.as3.model.vos.ConductVO;
	
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * The Memento pattern says that: in order to record the state for this class,
	 * We must create a memento type that we will call ChessPiecesMemento. 
	 * The ChessPiecesMemento is capable of storing the Chess Pieces' values.	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Dec 2, 2010 11:22:25 AM
	 */   	 
	public class ChessPiecesMemento
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var _conduct:ConductVO;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		public function set conduct(value:ConductVO):void
		{
			_conduct = value;
		}
		public function get conduct():ConductVO
		{
			return _conduct;
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
		public function ChessPiecesMemento(conduct:ConductVO)
		{
			this._conduct = conduct;
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
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