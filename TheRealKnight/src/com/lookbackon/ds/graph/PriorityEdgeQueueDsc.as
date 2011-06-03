package com.lookbackon.ds.graph
{

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------

	/**
	 * PriorityEdgeQueueDsc.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jun 1, 2011 6:19:31 PM
	 */
	public class PriorityEdgeQueueDsc
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var edgList_:Array /* of Edge*/;
		private var priList_:Array /* of int */;

		//----------------------------------
		//  CONSTANTS
		//----------------------------------

		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		public function get length():int
		{
			return priList_.length;
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
		public function PriorityEdgeQueueDsc()
		{
			edgList_=[];
			priList_=[];
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		public function insert(edg:Edge, priority:int):void
		{
			var l:int=priList_.length;
			for (var i:int=0; i < l; i++)
			{
				if (priority >= priList_[i])
				{
					priList_.splice(i, 0, priority);
					edgList_.splice(i, 0, edg);
					break;
				}
			}
			if (i == l)
			{
				priList_.push(priority);
				edgList_.push(edg);
			}
		}

		public function pop():Array
		{
			return [edgList_.pop(), priList_.pop()];
		}

		public function popObj():Edge
		{
			priList_.pop();
			return edgList_.pop();
		}

		public function popPriority():int
		{
			edgList_.pop();
			return priList_.pop();
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
