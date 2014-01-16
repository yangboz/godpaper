package jp.dip.hael.gameai.graph
{
	public class CoodinatedNode extends Node
	{
		public var x:int;
		public var y:int;
		public function CoodinatedNode(index:int=-1,x:int=-1,y:int=-1)
		{
			this.x = x;
			this.y = y;
			super(index);
		}
	}
}