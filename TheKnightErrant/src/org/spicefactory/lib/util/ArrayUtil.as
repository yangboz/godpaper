/*
 * Copyright 2007 the original author or authors.
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
 
package org.spicefactory.lib.util {

/**
 * Static utility methods for Arrays.
 * 
 * @author Jens Halm
 */
public class ArrayUtil {

	/**
	 * Removes the specified instance from the Array.
	 * 
	 * @param arr the Array to remove the element from
	 * @param element the element to remove
	 * @return true if the Array contained the specified element 
	 */
	public static function remove (arr:Array, element:*) : Boolean {
		for (var i:int = arr.length - 1; i >= 0; i--) {
			if (arr[i] == element) {
				arr.splice(i,1);
				return true;
			}
		}
		return false;
	}
	
	/**
	 * Returns the index of the first occurence of the specified element in the Array or -1 if the
	 * Array does not contain that element.
	 * 
	 * @param arr the Array to examine
	 * @param element the element to return the index for
	 * @return the zero-based index of the first occurence of the specified element or -1 if the
	 * Array does not contain that element
	 */
	public static function indexOf (arr:Array, element:*) : int {
		for (var i:int = 0; i < arr.length; i++) {
			if (arr[i] == element) return i;
		}	
		return -1;
	}	

	/**
	 * Returns the index of the last occurence of the specified element in the Array or -1 if the
	 * Array does not contain that element.
	 * 
	 * @param arr the Array to examine
	 * @param element the element to return the index for
	 * @return the zero-based index of the last occurence of the specified element or -1 if the
	 * Array does not contain that element
	 */	
	public static function lastIndexOf (arr:Array, element:*) : int {
		for (var i:int = arr.length - 1; i >= 0; i--) {
			if (arr[i] == element) return i;
		}	
		return -1;
	}	

	/**
	 * Checks whether the Array contains the specified element.
	 * 
	 * @param arr the Array to examine
	 * @param element the element to look for
	 * @return true if the Array contains the specified element
	 */		
	public static function contains (arr:Array, element:*) : Boolean {
		return  (indexOf(arr, element) != -1);
	}	

}
	
}