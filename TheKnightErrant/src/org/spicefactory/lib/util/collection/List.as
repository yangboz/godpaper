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

/**
 * @private
 * Temporary implementation, will be removed in later versions. Do not use in application code.
 * 
 * @author Jens Halm
 */	
public interface List {
	
	 function append (item:*) : void ;
	
	 function insert (index:uint, item:*) : void ;
	
	 function appendAll (l:List) : void ;
	
	 function insertAll (index:uint, l:List) : void ;
	
	 function contains (item:*) : Boolean ;
	
	 function isEmpty () : Boolean ;
	
	 function getSize () : uint ;
	
	 function indexOf (item:*) : int ;
	
	 function lastIndexOf (item:*) : int ;
	
	 function remove (item:*) : Boolean ;
	
	 function removeAt (index:uint) : * ;
	
	 function removeAll () : void ;
	
	 function removeFirst () : * ;
	
	 function removeLast () : * ;
	
	 function sort (compareFunction:Function, options:uint) : void ;
	
	 function sortOn (propertyNames:Array, options:uint) : void ;
	
	 function get (index:uint) : *  ;
	
	 function set (index:uint , item:*) : void ;
	
	 function getFirst () : * ;
	
	 function getLast () : * ;
	
	 function clone () : List;
	
	 function subList (start:uint, end:uint) : List ;
	
	 function toArray () : Array ;	
		
}
	
}