package com.lookbackon.ds
{
	import de.polygonal.ds.HashTable;
	import de.polygonal.ds.Iterator;
	import de.polygonal.math.PM_PRNG;

	/**
	 * These old hashes defined my requirements:
	 * The keys are unaligned variable-length byte arrays.</br>
	 * Sometimes keys are several such arrays.</br>
	 * Sometimes a set of independent hash functions were required.</br>
	 * Average key lengths ranged from 8 bytes to 200 bytes.</br>
	 * Keys might be character strings, numbers, bit-arrays, or weirder things.</br>
	 * Table sizes could be anything, including powers of 2.</br>
	 * The hash must be faster than the old one.</br>
	 * The hash must do a good job. </br></p>
	 * 
	 * <b>A Survey of Hash Functions:</b></p>
	 * <b>Additive Hash,</b></p>
	 * <b>Rotating Hash,</b></p>
	 * <b>One-at-a-Time Hash,</b></p>
	 * <b>Bernstein's hash,</b></p>
	 * <b>FNV Hash,</b></p>
	 * <b>Goulburn Hash,</b></p>
	 * <b>MurmurHash,</b></p>
	 * <b>Cessu,</b></p>
	 * <b>Pearson's Hash,</b></p>
	 * <b>CRC Hashing,</b></p>
	 * <b>Generalized CRC Hashing,</b></p>
	 * <b>Universal Hashing,</b></p>
	 * <b>Zobrist Hashing,</b></p>
	 * <b>Paul Hsieh's hash...</b></p>
	 * 
	 * @see http://www.burtleburtle.net/bob/hash/doobs.html
	 * @see http://chessprogramming.wikispaces.com/Zobrist+Hashing
	 * @inheritDoc
	 * @author Knight.zhou
	 * 
	 */	
	public class ZobristHashTable extends HashTable
	{
		/**
		 * An important issue is the question of what size the hash keys should have. </br>
		 * Smaller hash keys are faster and more space efficient, while larger ones reduce the risk of a hash collision. </br>
		 * A collision occurs if two positions map the same key [7]  . </br>
		 * The dangers of which were well assessed by Robert Hyatt  and Anthony Cozzie in their paper Hash Collisions Effect [8]  . </br>
		 * Usually 64bit are used as a standard size in modern chess programs. </br>
		 * But our chinese chess jam using <b>32bit*3</b> size.
		 * @param size what size the hash keys should have.
		 * @param zobristKey the zobristed key for hash map.
		 * 
		 */		
		public function ZobristHashTable(size:int,zobristKey:int)
		{
			//TODO: implement function
			super(size, 
				  function():int{
									return HashTable.hashInt(zobristKey);
							    }
				 );
		}
		/**
		 * Prints out all elements (for debug/demo purposes).
		 * 
		 * @return A human-readable representation of the structure.
		 */
		override public function dump():String
		{
			var s:String = "ZobristHashTable:\n";
			for (var i:int = 0; i < _size; i++)
			{
				if (_table[i])
					s += "[" + i + "]" + "\n" + _table[i];
			}
			return s;
		}
		/**
		 * If we now want to get the Zobrist hash code of a certain position, </br>
		 * we initialize the hash key bei xoring  all random numbers linked to the given feature.</br>
		 * E.g the starting position:</br>
		 * [Hash for White Rook on a1] xor [White Knight on b1] xor [White Bishop on c1] xor ... ( all pieces )
		 * ... xor [White castling short] xor [White castling long] xor ... ( all castling rights )</br>
		 * The fact that xor-operation is own inverse and can be undone by using the same xor-operation again, is often used by chess engines.</br> 
		 * It allows a fast incremental update of the hash key during make or unmake moves.</br>
		 * E.g., for a White Knight that jumps from b1 to c3 capturing a Black Bishop, these operations are performed:</br>
		 * [Original Hash of position] xor [Hash for White Knight on b1] ... ( removing the knight from b1 )</br>
		 * ... xor [Hash for Black Bishop on c3] ( removing the captured bishop from c3 )</br>
		 * ... xor [Hash for White Knight on c3] ( placing the knight on the new square )</br>
		 * ... xor [Hash for Black to move] ( change sides)</b>
		 * 
		 * @param anewTable to be xor-ed.
		 * @return after xoring anew zobrist hash table. 
		 * 
		 */		
		public function xor(anewTable:ZobristHashTable):ZobristHashTable
		{
			var pm_prng:PM_PRNG = new PM_PRNG();
			var xorResult:ZobristHashTable = new ZobristHashTable(anewTable.size,-1);
			var iterator:Iterator = this.getIterator();
			while(iterator.hasNext())
			{
				trace(iterator.data);
			}
			return xorResult;
		}
	}
}