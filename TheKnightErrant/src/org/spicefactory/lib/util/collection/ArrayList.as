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
 
package org.spicefactory.lib.util.collection {
import org.spicefactory.lib.errors.IllegalArgumentError;
import org.spicefactory.lib.util.ArrayUtil;	

/**
 * @private
 * Temporary implementation, will be removed in later versions. Do not use in application code.
 * 
 * @author Jens Halm
 */	
public class ArrayList implements List {

	
	private var _array:Array;
	
	
	function ArrayList () {
		_array = new Array();
	}

	public function append (item:*) : void {
		_array.push(item);
	}
	
	public function insert (index:uint, item:*) : void {
		if (index < 0 || index > _array.length) {
			throw new IllegalArgumentError("insert: index out of range: " + index);
		}
		_array.splice(index, 0, item);
	}
	
	public function appendAll (l:List) : void {
		var cnt:Number = l.getSize();
		for (var i:Number = 0; i < cnt; i++) {
			append(l.get(i));
		}
	}
	
	public function insertAll (index:uint, l:List) : void {
		if (index < 0 || index > _array.length) {
			throw new IllegalArgumentError("insert: index out of range: " + index);
		}
		_array.splice(index, 0, l.toArray());
	}		
	
	public function contains (item:*) : Boolean {
		return ArrayUtil.contains(_array, item);
	}
	
	public function isEmpty () : Boolean {
		return (_array.length == 0);
	}
	
	public function getSize () : uint {
		return _array.length;
	}
	
	public function indexOf (item:*) : int {
		return ArrayUtil.indexOf(_array, item);
	}
	
	public function lastIndexOf (item:*) : int {
		return ArrayUtil.lastIndexOf(_array, item);
	}
	
	public function remove (item:*) : Boolean {
		return ArrayUtil.remove(_array, item);
	}
	
	public function removeAt (index:uint) : * {
		if (index < 0 || index >= _array.length) {
			throw new IllegalArgumentError("Index out of range: " + index);
		}
		var item:* = _array[index];
		_array.splice(index, 1);
		return item;
	}
	
	public function removeAll () : void {
		_array = new Array();
	}
	
	public function removeFirst () : * {
		if (_array.length == 0) return null;
		return removeAt(0);
	}
	
	public function removeLast () : * {
		if (_array.length == 0) return null;
		return removeAt(_array.length - 1);		
	}
	
	public function sort (compareFunction:Function, options:uint) : void {
		_array.sort(compareFunction, options);
	}
	
	public function sortOn (propertyNames:Array, options:uint) : void {
		_array.sortOn(propertyNames, options);
	}
	
	public function get (index:uint) : * {
		if (index < 0 || index >= _array.length) {
			throw new IllegalArgumentError("Index out of range: " + index);
		}
		return _array[index];
	}
	
	public function getFirst () : * {
		return (_array.length == 0) ? null : _array[0];
	}
	
	public function getLast () : * {
		return (_array.length == 0) ? null : _array[_array.length - 1];
	}
	
	public function set (index:uint, item:*) : void {
		if (index < 0 || index >= _array.length) {
			throw new IllegalArgumentError("Index out of range: " + index);
		}	
		_array[index] = item;
	}	
	
	public function clone () : List {
		var clone:List = new ArrayList();
		clone.appendAll(this);
		return clone;
	}
	
	public function subList (start:uint, end:uint) : List {
		var l:ArrayList = new ArrayList();
		l._array = _array.slice(start, end);
		return l;
	}
	
	public function toArray () : Array {
		return _array.concat();
	}
	
	
	public static function wrap (arr:Array) : List {
		var l:ArrayList = new ArrayList();
		l._array = arr;
		return l;
	}	
	
}

}