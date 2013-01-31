/*
 * Copyright 2008 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.spicefactory.lib.errors {


/**
 * Base <code>Error</code> implementation that allows to specify a cause.
 * 
 * @author Jens Halm
 */
public class NestedError extends Error {
	
	
	private var _cause:Error;
	

	/**
	 * Creates a new instance.
	 * 
	 * @param message the error message
	 * @param cause the cause of this Error
	 * @param id an optional reference number
	 */
	function NestedError (message:String = "", cause:Error = null, id:int = 0) {
		super(message, id);
		_cause = cause;
	}
	
	
	/**
	 * The cause of this Error, may be null.
	 * The cause is the original Error that caused this Error to get thrown.
	 */
	public function get cause () : Error {
		return _cause;
	}
	

	/**
	 * @private
	 */
	public override function getStackTrace () : String {
		var st:String = super.getStackTrace();
		if (_cause != null) {
			st += "\n Caused by: " + _cause.getStackTrace();
		}
		return st;
	}
	
	
}

}
