package com.godpaper.as3.model.vos
{
	import com.godpaper.as3.configs.BoardConfig;
	import com.lookbackon.ds.BitBoard;
	
	import de.polygonal.ds.Array2;
	
	import flash.events.EventDispatcher;

	/**
	 * The zobrist key value object obtain the keys(color,type,position).
	 * Zobrist hashing is a technique to transform a board position of arbitrary size 
	 * into a number of a set length, with an equal distribution over all possible numbers, 
	 * invented by Albert Zobrist. 
	 * 
	 * @see http://chessprogramming.wikispaces.com/Zobrist+Hashing
	 * 
	 * @author Knight.zhou
	 * </time> 2012-06-05,code comments added.
	 * 
	 */
//	public class ZobristKeyVO extends EventDispatcher
	public class ZobristKeyVO
	{
		//chess colour bit board.
		public var color:Array2;
		//chess type bit board.
		public var type:Array2;
		//chess position bit board.
		public var position:Array2;
		
		public function ZobristKeyVO()
		{
			super();
			//
			color = new Array2(BoardConfig.xLines,BoardConfig.yLines);
			type = new Array2(BoardConfig.xLines,BoardConfig.yLines);
			position = new Array2(BoardConfig.xLines,BoardConfig.yLines);
		}
		/**
		 * Prints out all elements (for debug/demo purposes).
		 * 
		 * @return A human-readable representation of the structure.
		 */
		public function dump():String
		{
			var s:String = "ZobristKeyVO";
			s += "\n{";
			s += "\n" + "\t";
//			s += "color:"+color.dump()+"\t";
//			s += "type:"+type.dump()+"\t"
			s += "position:"+position.dump()+"\t";
			s += "\n}";
			return s;
		}
	}
}
