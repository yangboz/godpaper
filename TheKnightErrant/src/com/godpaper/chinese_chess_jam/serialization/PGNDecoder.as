/**
 *  GODPAPER Confidential,Copyright 2012. All rights reserved.
 *
 *  Permission is hereby granted, free of charge, to any person obtaining
 *  a copy of this software and associated documentation files (the "Software"),
 *  to deal in the Software without restriction, including without limitation
 *  the rights to use, copy, modify, merge, publish, distribute, sub-license,
 *  and/or sell copies of the Software, and to permit persons to whom the
 *  Software is furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included
 *  in all copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 *  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 *  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
 *  IN THE SOFTWARE.
 */
package com.godpaper.chinese_chess_jam.serialization
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * PGNDecoder.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Aug 6, 2012 11:21:41 AM
	 */   	 
	public class PGNDecoder
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		/**
		 * Flag indicating if the parser should be strict about the format
		 * of the PGN string it is attempting to decode.
		 */
		private var strict:Boolean;
		
		/** The value that will get parsed from the PGN string */
		private var value:*;
		
		/** The tokenizer designated to read the PGN string */
		private var tokenizer:PGNTokenizer;
		
		/** The current token from the tokenizer */
		private var token:PGNToken;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		
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
		
		/**
		 * Constructs a new PGNDecoder to parse a PGN string
		 * into a native object.
		 *
		 * @param s The PGN string to be converted
		 * into a native object
		 * @param strict Flag indicating if the PGN string needs to
		 * strictly match the PGN standard or not.
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 9.0
		 * @tiptext
		 */
		public function PGNDecoder( s:String, strict:Boolean )
		{
			this.strict = strict;
			tokenizer = new PGNTokenizer( s, strict );
			
			nextToken();
			value = parseValue();
			
			// Make sure the input stream is empty
			if ( strict && nextToken() != null )
			{
				tokenizer.parseError( "Unexpected characters left in input stream" );
			}
		}
		
		/**
		 * Gets the internal object that was created by parsing
		 * the PGN string passed to the constructor.
		 *
		 * @return The internal object representation of the PGN
		 * string that was passed to the constructor
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 9.0
		 * @tiptext
		 */
		public function getValue():*
		{
			return value;
		}
		
		/**
		 * Returns the next token from the tokenzier reading
		 * the PGN string
		 */
		private final function nextToken():PGNToken
		{
			return token = tokenizer.getNextToken();
		}
		
		/**
		 * Returns the next token from the tokenizer reading
		 * the PGN string and verifies that the token is valid.
		 */
		private final function nextValidToken():PGNToken
		{
			token = tokenizer.getNextToken();
			checkValidToken();
			
			return token;
		}
		
		/**
		 * Verifies that the token is valid.
		 */
		private final function checkValidToken():void
		{
			// Catch errors when the input stream ends abruptly
			if ( token == null )
			{
				tokenizer.parseError( "Unexpected end of input" );
			}
		}
		
		/**
		 * Attempt to parse an array.
		 */
		private final function parseArray():Array
		{
			// create an array internally that we're going to attempt
			// to parse from the tokenizer
			var a:Array = new Array();
			
			// grab the next token from the tokenizer to move
			// past the opening [
			nextValidToken();
			
			// check to see if we have an empty array
			if ( token.type == PGNTokenType.RIGHT_BRACKET )
			{
				// we're done reading the array, so return it
				return a;
			}
				// in non-strict mode an empty array is also a comma
				// followed by a right bracket
			else if ( !strict && token.type == PGNTokenType.COMMA )
			{
				// move past the comma
				nextValidToken();
				
				// check to see if we're reached the end of the array
				if ( token.type == PGNTokenType.RIGHT_BRACKET )
				{
					return a;
				}
				else
				{
					tokenizer.parseError( "Leading commas are not supported. Expecting ']' but found " + token.value );
				}
			}
			
			// deal with elements of the array, and use an "infinite"
			// loop because we could have any amount of elements
			while ( true )
			{
				// read in the value and add it to the array
				a.push( parseValue() );
				
				// after the value there should be a ] or a ,
				nextValidToken();
				
				if ( token.type == PGNTokenType.RIGHT_BRACKET )
				{
					// we're done reading the array, so return it
					return a;
				}
				else if ( token.type == PGNTokenType.COMMA )
				{
					// move past the comma and read another value
					nextToken();
					
					// Allow arrays to have a comma after the last element
					// if the decoder is not in strict mode
					if ( !strict )
					{
						checkValidToken();
						
						// Reached ",]" as the end of the array, so return it
						if ( token.type == PGNTokenType.RIGHT_BRACKET )
						{
							return a;
						}
					}
				}
				else
				{
					tokenizer.parseError( "Expecting ] or , but found " + token.value );
				}
			}
			
			return null;
		}
		
		/**
		 * Attempt to parse an object.
		 */
		private final function parseObject():Object
		{
			// create the object internally that we're going to
			// attempt to parse from the tokenizer
			var o:Object = new Object();
			
			// store the string part of an object member so
			// that we can assign it a value in the object
			var key:String
			
			// grab the next token from the tokenizer
			nextValidToken();
			
			// check to see if we have an empty object
			if ( token.type == PGNTokenType.RIGHT_BRACE )
			{
				// we're done reading the object, so return it
				return o;
			}
				// in non-strict mode an empty object is also a comma
				// followed by a right bracket
			else if ( !strict && token.type == PGNTokenType.COMMA )
			{
				// move past the comma
				nextValidToken();
				
				// check to see if we're reached the end of the object
				if ( token.type == PGNTokenType.RIGHT_BRACE )
				{
					return o;
				}
				else
				{
					tokenizer.parseError( "Leading commas are not supported. Expecting '}' but found " + token.value );
				}
			}
			
			// deal with members of the object, and use an "infinite"
			// loop because we could have any amount of members
			while ( true )
			{
				if ( token.type == PGNTokenType.STRING )
				{
					// the string value we read is the key for the object
					key = String( token.value );
					
					// move past the string to see what's next
					nextValidToken();
					
					// after the string there should be a :
					if ( token.type == PGNTokenType.COLON )
					{
						// move past the : and read/assign a value for the key
						nextToken();
						o[ key ] = parseValue();
						
						// move past the value to see what's next
						nextValidToken();
						
						// after the value there's either a } or a ,
						if ( token.type == PGNTokenType.RIGHT_BRACE )
						{
							// we're done reading the object, so return it
							return o;
						}
						else if ( token.type == PGNTokenType.COMMA )
						{
							// skip past the comma and read another member
							nextToken();
							
							// Allow objects to have a comma after the last member
							// if the decoder is not in strict mode
							if ( !strict )
							{
								checkValidToken();
								
								// Reached ",}" as the end of the object, so return it
								if ( token.type == PGNTokenType.RIGHT_BRACE )
								{
									return o;
								}
							}
						}
						else
						{
							tokenizer.parseError( "Expecting } or , but found " + token.value );
						}
					}
					else
					{
						tokenizer.parseError( "Expecting : but found " + token.value );
					}
				}
				else
				{
					tokenizer.parseError( "Expecting string but found " + token.value );
				}
			}
			return null;
		}
		
		/**
		 * Attempt to parse a value
		 */
		private final function parseValue():Object
		{
			checkValidToken();
			
			switch ( token.type )
			{
				case PGNTokenType.LEFT_BRACE:
					return parseObject();
					
				case PGNTokenType.LEFT_BRACKET:
					return parseArray();
					
				case PGNTokenType.STRING:
				case PGNTokenType.NUMBER:
				case PGNTokenType.TRUE:
				case PGNTokenType.FALSE:
				case PGNTokenType.NULL:
					return token.value;
					
				case PGNTokenType.NAN:
					if ( !strict )
					{
						return token.value;
					}
					else
					{
						tokenizer.parseError( "Unexpected " + token.value );
					}
				//Meta keys
				case PGNTokenType.META_KEY_GAME:
					return token.value;
				default:
					tokenizer.parseError( "Unexpected " + token.value );
					
			}
			
			return null;
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