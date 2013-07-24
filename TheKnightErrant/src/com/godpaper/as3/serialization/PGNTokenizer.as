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
package com.godpaper.as3.serialization
{
	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * PGNTokenizer.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Aug 6, 2012 11:27:37 AM
	 */   	 
	public class PGNTokenizer
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		/**
		 * Flag indicating if the tokenizer should only recognize
		 * standard PGN tokens. Setting to <code>false</code> allows
		 * tokens such as NaN and allows numbers to be formatted as
		 * hex, etc.
		 */
		private var strict:Boolean;
		
		/** The object that will get parsed from the PGN string */
		private var obj:Object;
		
		/** The PGN string to be parsed */
		private var pgnString:String;
		
		/** The current parsing location in the PGN string */
		private var loc:int;
		
		/** The current character in the PGN string during parsing */
		private var ch:String;
		
		/**
		 * The regular expression used to make sure the string does not
		 * contain invalid control characters.
		 */
		private const controlCharsRegExp:RegExp = /[\x00-\x1F]/;
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
		 */
		public function PGNTokenizer( s:String, strict:Boolean )
		{
			pgnString = s;
			this.strict = strict;
			loc = 0;
			
			// prime the pump by getting the first character
			nextChar();
		}    	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		/**
		 * Gets the next token in the input sting and advances
		 * the character to the next character after the token
		 */
		public function getNextToken():PGNToken
		{
			var token:PGNToken = null;
			
			// skip any whitespace / comments since the last
			// token was read
			skipIgnored();
			
			// examine the new character and see what we have...
			switch ( ch )
			{
				case '{':
					token = PGNToken.create( PGNTokenType.LEFT_BRACE, ch );
					nextChar();
					break
				
				case '}':
					token = PGNToken.create( PGNTokenType.RIGHT_BRACE, ch );
					nextChar();
					break
				
				case '[':
					token = PGNToken.create( PGNTokenType.LEFT_BRACKET, ch );
					nextChar();
					break
				
				case ']':
					token = PGNToken.create( PGNTokenType.RIGHT_BRACKET, ch );
					nextChar();
					break
				
				case ',':
					token = PGNToken.create( PGNTokenType.COMMA, ch );
					nextChar();
					break
				
				case ':':
					token = PGNToken.create( PGNTokenType.COLON, ch );
					nextChar();
					break;
				
				case 't': // attempt to read true
					var possibleTrue:String = "t" + nextChar() + nextChar() + nextChar();
					
					if ( possibleTrue == "true" )
					{
						token = PGNToken.create( PGNTokenType.TRUE, true );
						nextChar();
					}
					else
					{
						parseError( "Expecting 'true' but found " + possibleTrue );
					}
					
					break;
				
				case 'f': // attempt to read false
					var possibleFalse:String = "f" + nextChar() + nextChar() + nextChar() + nextChar();
					
					if ( possibleFalse == "false" )
					{
						token = PGNToken.create( PGNTokenType.FALSE, false );
						nextChar();
					}
					else
					{
						parseError( "Expecting 'false' but found " + possibleFalse );
					}
					
					break;
				
				case 'n': // attempt to read null
					var possibleNull:String = "n" + nextChar() + nextChar() + nextChar();
					
					if ( possibleNull == "null" )
					{
						token = PGNToken.create( PGNTokenType.NULL, null );
						nextChar();
					}
					else
					{
						parseError( "Expecting 'null' but found " + possibleNull );
					}
					
					break;
				
				case 'N': // attempt to read NaN
					var possibleNaN:String = "N" + nextChar() + nextChar();
					
					if ( possibleNaN == "NaN" )
					{
						token = PGNToken.create( PGNTokenType.NAN, NaN );
						nextChar();
					}
					else
					{
						parseError( "Expecting 'NaN' but found " + possibleNaN );
					}
					
					break;
				
				case '"': // the start of a string
					token = readString();
					break;
				//PGN metadata revelants
				case 'G':// the name of game
					var possibleGame:String = "G" + nextChar() + nextChar() + nextChar();
					
					if ( possibleGame == "Game" )
					{
						token = PGNToken.create( PGNTokenType.META_KEY_GAME, null );
						nextChar();
					}
					else
					{
						parseError( "Expecting 'Game' but found " + possibleNull );
					}
					break;
				case 'E':
				case 'S':
				case 'D':
				case 'R':
				case 'B':
				case 'R':
					token = readString();
					break;
				
				
				default:
					// see if we can read a number
					if ( isDigit( ch ) || ch == '-' )
					{
						token = readNumber();
					}
					else if ( ch == '' )
					{
						// check for reading past the end of the string
						token = null;
					}
					else
					{
						// not sure what was in the input string - it's not
						// anything we expected
						parseError( "Unexpected " + ch + " encountered" );
					}
			}
			
			return token;
		}
		/**
		 * Convert all JavaScript escape characters into normal characters
		 *
		 * @param input The input string to convert
		 * @return Original string with escape characters replaced by real characters
		 */
		public function unescapeString( input:String ):String
		{
			// Issue #104 - If the string contains any unescaped control characters, this
			// is an error in strict mode
			if ( strict && controlCharsRegExp.test( input ) )
			{
				parseError( "String contains unescaped control character (0x00-0x1F)" );
			}
			
			var result:String = "";
			var backslashIndex:int = 0;
			var nextSubstringStartPosition:int = 0;
			var len:int = input.length;
			do
			{
				// Find the next backslash in the input
				backslashIndex = input.indexOf( '\\', nextSubstringStartPosition );
				
				if ( backslashIndex >= 0 )
				{
					result += input.substr( nextSubstringStartPosition, backslashIndex - nextSubstringStartPosition );
					
					// Move past the backslash and next character (all escape sequences are
					// two characters, except for \u, which will advance this further)
					nextSubstringStartPosition = backslashIndex + 2;
					
					// Check the next character so we know what to escape
					var escapedChar:String = input.charAt( backslashIndex + 1 );
					switch ( escapedChar )
					{
						// Try to list the most common expected cases first to improve performance
						
						case '"':
							result += escapedChar;
							break; // quotation mark
						case '\\':
							result += escapedChar;
							break; // reverse solidus
						case 'n':
							result += '\n';
							break; // newline
						case 'r':
							result += '\r';
							break; // carriage return
						case 't':
							result += '\t';
							break; // horizontal tab
						
						// Convert a unicode escape sequence to it's character value
						case 'u':
							
							// Save the characters as a string we'll convert to an int
							var hexValue:String = "";
							
							var unicodeEndPosition:int = nextSubstringStartPosition + 4;
							
							// Make sure there are enough characters in the string leftover
							if ( unicodeEndPosition > len )
							{
								parseError( "Unexpected end of input. Expecting 4 hex digits after \\u." );
							}
							
							// Try to find 4 hex characters
							for ( var i:int = nextSubstringStartPosition; i < unicodeEndPosition; i++ )
							{
								// get the next character and determine
								// if it's a valid hex digit or not
								var possibleHexChar:String = input.charAt( i );
								if ( !isHexDigit( possibleHexChar ) )
								{
									parseError( "Excepted a hex digit, but found: " + possibleHexChar );
								}
								
								// Valid hex digit, add it to the value
								hexValue += possibleHexChar;
							}
							
							// Convert hexValue to an integer, and use that
							// integer value to create a character to add
							// to our string.
							result += String.fromCharCode( parseInt( hexValue, 16 ) );
							
							// Move past the 4 hex digits that we just read
							nextSubstringStartPosition = unicodeEndPosition;
							break;
						
						case 'f':
							result += '\f';
							break; // form feed
						case '/':
							result += '/';
							break; // solidus
						case 'b':
							result += '\b';
							break; // bell
						default:
							result += '\\' + escapedChar; // Couldn't unescape the sequence, so just pass it through
					}
				}
				else
				{
					// No more backslashes to replace, append the rest of the string
					result += input.substr( nextSubstringStartPosition );
					break;
				}
				
			} while ( nextSubstringStartPosition < len );
			
			return result;
		}
		
		/**
		 * Attempts to read a number from the input string. Places
		 * the character location at the first character after the
		 * number.
		 *
		 * @return The PGNToken with the number value if a number could
		 * be read. Throws an error otherwise.
		 */
		private final function readNumber():PGNToken
		{
			// the string to accumulate the number characters
			// into that we'll convert to a number at the end
			var input:String = "";
			
			// check for a negative number
			if ( ch == '-' )
			{
				input += '-';
				nextChar();
			}
			
			// the number must start with a digit
			if ( !isDigit( ch ) )
			{
				parseError( "Expecting a digit" );
			}
			
			// 0 can only be the first digit if it
			// is followed by a decimal point
			if ( ch == '0' )
			{
				input += ch;
				nextChar();
				
				// make sure no other digits come after 0
				if ( isDigit( ch ) )
				{
					parseError( "A digit cannot immediately follow 0" );
				}
					// unless we have 0x which starts a hex number, but this
					// doesn't match PGN spec so check for not strict mode.
				else if ( !strict && ch == 'x' )
				{
					// include the x in the input
					input += ch;
					nextChar();
					
					// need at least one hex digit after 0x to
					// be valid
					if ( isHexDigit( ch ) )
					{
						input += ch;
						nextChar();
					}
					else
					{
						parseError( "Number in hex format require at least one hex digit after \"0x\"" );
					}
					
					// consume all of the hex values
					while ( isHexDigit( ch ) )
					{
						input += ch;
						nextChar();
					}
				}
			}
			else
			{
				// read numbers while we can
				while ( isDigit( ch ) )
				{
					input += ch;
					nextChar();
				}
			}
			
			// check for a decimal value
			if ( ch == '.' )
			{
				input += '.';
				nextChar();
				
				// after the decimal there has to be a digit
				if ( !isDigit( ch ) )
				{
					parseError( "Expecting a digit" );
				}
				
				// read more numbers to get the decimal value
				while ( isDigit( ch ) )
				{
					input += ch;
					nextChar();
				}
			}
			
			// check for scientific notation
			if ( ch == 'e' || ch == 'E' )
			{
				input += "e"
				nextChar();
				// check for sign
				if ( ch == '+' || ch == '-' )
				{
					input += ch;
					nextChar();
				}
				
				// require at least one number for the exponent
				// in this case
				if ( !isDigit( ch ) )
				{
					parseError( "Scientific notation number needs exponent value" );
				}
				
				// read in the exponent
				while ( isDigit( ch ) )
				{
					input += ch;
					nextChar();
				}
			}
			
			// convert the string to a number value
			var num:Number = Number( input );
			
			if ( isFinite( num ) && !isNaN( num ) )
			{
				// the token for the number that we've read
				return PGNToken.create( PGNTokenType.NUMBER, num );
			}
			else
			{
				parseError( "Number " + num + " is not valid!" );
			}
			
			return null;
		}
		
		/**
		 * Reads the next character in the input
		 * string and advances the character location.
		 *
		 * @return The next character in the input string, or
		 * null if we've read past the end.
		 */
		private final function nextChar():String
		{
			return ch = pgnString.charAt( loc++ );
		}
		
		/**
		 * Advances the character location past any
		 * sort of white space and comments
		 */
		private final function skipIgnored():void
		{
			var originalLoc:int;
			
			// keep trying to skip whitespace and comments as long
			// as we keep advancing past the original location
			do
			{
				originalLoc = loc;
				skipWhite();
				skipComments();
			} while ( originalLoc != loc );
		}
		
		/**
		 * Skips comments in the input string, either
		 * single-line or multi-line. Advances the character
		 * to the first position after the end of the comment.
		 */
		private function skipComments():void
		{
			if ( ch == '/' )
			{
				// Advance past the first / to find out what type of comment
				nextChar();
				switch ( ch )
				{
					case '/': // single-line comment, read through end of line
						
						// Loop over the characters until we find
						// a newline or until there's no more characters left
						do
						{
							nextChar();
						} while ( ch != '\n' && ch != '' )
						
						// move past the \n
						nextChar();
						
						break;
					
					case '*': // multi-line comment, read until closing */
						
						// move past the opening *
						nextChar();
						
						// try to find a trailing */
						while ( true )
						{
							if ( ch == '*' )
							{
								// check to see if we have a closing /
								nextChar();
								if ( ch == '/' )
								{
									// move past the end of the closing */
									nextChar();
									break;
								}
							}
							else
							{
								// move along, looking if the next character is a *
								nextChar();
							}
							
							// when we're here we've read past the end of
							// the string without finding a closing */, so error
							if ( ch == '' )
							{
								parseError( "Multi-line comment not closed" );
							}
						}
						
						break;
					
					// Can't match a comment after a /, so it's a parsing error
					default:
						parseError( "Unexpected " + ch + " encountered (expecting '/' or '*' )" );
				}
			}
			
		}
		
		
		/**
		 * Skip any whitespace in the input string and advances
		 * the character to the first character after any possible
		 * whitespace.
		 */
		private final function skipWhite():void
		{
			// As long as there are spaces in the input
			// stream, advance the current location pointer
			// past them
			while ( isWhiteSpace( ch ) )
			{
				nextChar();
			}
			
		}
		
		/**
		 * Determines if a character is whitespace or not.
		 *
		 * @return True if the character passed in is a whitespace
		 * character
		 */
		private final function isWhiteSpace( ch:String ):Boolean
		{
			// Check for the whitespace defined in the spec
			if ( ch == ' ' || ch == '\t' || ch == '\n' || ch == '\r' )
			{
				return true;
			}
				// If we're not in strict mode, we also accept non-breaking space
			else if ( !strict && ch.charCodeAt( 0 ) == 160 )
			{
				return true;
			}
			
			return false;
		}
		
		/**
		 * Determines if a character is a digit [0-9].
		 *
		 * @return True if the character passed in is a digit
		 */
		private final function isDigit( ch:String ):Boolean
		{
			return ( ch >= '0' && ch <= '9' );
		}
		
		/**
		 * Determines if a character is a hex digit [0-9A-Fa-f].
		 *
		 * @return True if the character passed in is a hex digit
		 */
		private final function isHexDigit( ch:String ):Boolean
		{
			return ( isDigit( ch ) || ( ch >= 'A' && ch <= 'F' ) || ( ch >= 'a' && ch <= 'f' ) );
		}
		
		/**
		 * Raises a parsing error with a specified message, tacking
		 * on the error location and the original string.
		 *
		 * @param message The message indicating why the error occurred
		 */
		public final function parseError( message:String ):void
		{
			throw new PGNParseError( message, loc, pgnString );
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
		/**
		 * Attempts to read a string from the input string. Places
		 * the character location at the first character after the
		 * string. It is assumed that ch is " before this method is called.
		 *
		 * @return the PGNToken with the string value if a string could
		 * be read. Throws an error otherwise.
		 */
		private final function readString():PGNToken
		{
			// Rather than examine the string character-by-character, it's
			// faster to use indexOf to try to and find the closing quote character
			// and then replace escape sequences after the fact.
			
			// Start at the current input stream position
			var quoteIndex:int = loc;
			do
			{
				// Find the next quote in the input stream
				quoteIndex = pgnString.indexOf( "\"", quoteIndex );
				
				if ( quoteIndex >= 0 )
				{
					// We found the next double quote character in the string, but we need
					// to make sure it is not part of an escape sequence.
					
					// Keep looping backwards while the previous character is a backslash
					var backspaceCount:int = 0;
					var backspaceIndex:int = quoteIndex - 1;
					while (pgnString.charAt( backspaceIndex ) == "\\" )
					{
						backspaceCount++;
						backspaceIndex--;
					}
					
					// If we have an even number of backslashes, that means this is the ending quote
					if ( ( backspaceCount & 1 ) == 0 )
					{
						break;
					}
					
					// At this point, the quote was determined to be part of an escape sequence
					// so we need to move past the quote index to look for the next one
					quoteIndex++;
				}
				else // There are no more quotes in the string and we haven't found the end yet
				{
					parseError( "Unterminated string literal" );
				}
			} while ( true );
			
			// Unescape the string
			// the token for the string we'll try to read
			var token:PGNToken = PGNToken.create(
				PGNTokenType.STRING,
				// Attach resulting string to the token to return it
				unescapeString( pgnString.substr( loc, quoteIndex - loc ) ) );
			
			// Move past the closing quote in the input string. This updates the next
			// character in the input stream to be the character one after the closing quote
			loc = quoteIndex + 1;
			nextChar();
			
			return token;
		}
	}
	
}