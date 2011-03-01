/*
Copyright (c) 2009 Drew Cummins

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
**/
package com.lookbackon.ds
{
	/**
	 * the implementation would look something like this:
	 * //offline
	 * var n:uint = objects.length;
	 * var bv:BitVector = new BitVector( null, n * ( n - 1 ) / 2 );
	 * //test
	 * function handleCollision( minObj:CollidableObject, maxObj:CollidableObject ) : void
	 * {
	 * var bit:uint = minObj.index * ( 2 * n - minObj.index - 3 ) / 2 + maxObj.index - 1;
	 * if( !bv.getBit( bit ) ){
	 * //test for collision
	 * bv.setBit( bit, true );
	 * }
	 * }
	 * @see http://blog.generalrelativity.org/actionscript-30/avm2-memory-considerations-and-bit-vectors/
	 * 
	 */	
	public class BitVector
	{
		private var vector:Vector.<uint>;
		
		public function BitVector( source:Vector.<uint> = null, numBits:uint = 128 )
		{
			if( source != null ) vector = source;
			else vector = new Vector.<uint>( numBits >>> 5, true );
		}
		
		public function setBit( bit:uint, flag:Boolean = true ) : void
		{
			if( flag ) vector[ ( bit - 1 ) >>> 5 ] |= 1 << ( bit & 31 );
			else vector[ ( bit - 1 ) >>> 5 ] &= ~( 1 << ( bit & 31 ) );
		}
		
		public function getBit( bit:uint ) : uint
		{
			return ( vector[ ( bit - 1 ) >>> 5 ] >> ( bit & 31 ) ) & 1;
		}
		
		public function OR( bitVector:BitVector ) : BitVector
		{
			
			var result:Vector.<uint>;
			var min:Vector.<uint>;
			
			if( length < bitVector.length ) 
			{
				min = vector;
				result = bitVector.vector.slice();
			}
			else 
			{
				min = bitVector.vector;
				result = vector.slice();
			}
			
			var n:int = min.length;
			
			while( --n > -1 )
			{
				result[ n ] |= min[ n ];
			}
			
			return new BitVector( result );
			
		}
		
		public function AND( bitVector:BitVector ) : BitVector
		{
			
			var result:Vector.<uint>;
			var min:Vector.<uint>;
			
			if( length < bitVector.length ) 
			{
				min = vector;
				result = bitVector.vector.slice();
			}
			else 
			{
				min = bitVector.vector;
				result = vector.slice();
			}
			
			var n:int = min.length;
			while( --n > -1 )
			{
				result[ n ] &= min[ n ];
			}
			
			return new BitVector( result );
			
		}
		
		public function flagAllOn() : void
		{
			
			const MAX:uint = uint.MAX_VALUE;
			
			var n:int = length;
			while( --n > -1 )
			{
				vector[ n ] = MAX;
			}
			
		}
		
		public function flagAllOff() : void
		{
			
			var n:int = length;
			while( --n > -1 )
			{
				vector[ n ] = 0;
			}
			
		}
		
		public function get length() : uint
		{
			return vector.length;
		}
		
		public function get bits() : uint
		{
			return vector.length >> 5;
		}
		
		public function get bytes() : uint
		{
			return vector.length >> 3;
		}
		
		public function toString() : String
		{
			
			var output:String = "";
			
			for( var i:int = 0; i < length; i++ )
			{
				
				var bytes:uint = vector[ i ];
				
				for( var j:int = 1; j <= 32; j++ )
				{
					output += ( ( bytes >>> j ) & 1 ).toString();
				}
				
				if( i < length - 1 ) output += " | ";
				
			}
			
			return output;
			
		}
		
	}
}
import com.lookbackon.ds.BitVector;

import flash.display.Stage;
import flash.events.KeyboardEvent;

internal class Key
{
	private static var instance:Key;
	
	private var map:BitVector;
	
	public function Key( singletonEnforcer:SingletonEnforcer )
	{
	}
	
	public function isDown( keyCode:uint ) : Boolean
	{
		return map.getBit( keyCode ) == 1;
	}
	
	public function set stage( value:Stage ) : void
	{
		
		map = new BitVector( null, 256 );
		
		value.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
		value.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
		
	}
	
	private function onKeyUp( event:KeyboardEvent ) : void
	{
		map.setBit( event.keyCode, false );
	}
	
	private function onKeyDown( event:KeyboardEvent ) : void
	{
		map.setBit( event.keyCode, true );
	}
	
	public static function getInstance() : Key
	{
		if( instance == null ) instance = new Key( new SingletonEnforcer() );
		return instance;
	}
	
}
class SingletonEnforcer{}