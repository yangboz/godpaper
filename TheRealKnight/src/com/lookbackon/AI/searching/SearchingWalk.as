package com.lookbackon.AI.searching
{
	import flash.geom.Point;

	/**
	 * private var _array1:Array = [
	 *									[  0 , 'a',  0  ],
	 *									[ 'd',  0 , "b" ],
	 *									[  0 , 'c',  0  ]
	 *								];
	 * private var _array:Array = [ 
	 *								 [  0,  'a1', 0, 'a2',  0  ],
	 *								 [ 'd2',  0,  0,   0, 'b1' ],
	 *								 [  0,    0,  0,   0,   0  ],
	 *								 [ 'd1',  0,  0,   0, 'b2' ],
	 *								 [  0,  'c2', 0,  'c1', 0  ]
	 *							  ];
	 * private var _bigArray:Array = [
	 *									[ 1, 1, 1, 1, 1, 1, 1, 1, 1 ],
	 *									[ 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
	 *									[ 0, 1, 0, 0, 0, 0, 0, 1, 0 ],
	 *									[ 1, 0, 1, 0, 1, 0, 1, 0, 1 ],
	 *									[ 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
	 *									[ 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
	 *									[ 1, 0, 1, 0, 1, 0, 1, 0, 1 ],
	 *									[ 0, 1, 0, 0, 0, 0, 0, 1, 0 ],
	 *									[ 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
	 *									[ 1, 1, 1, 1, 1, 1, 1, 1, 1 ]
	 *								  ];
	 * 
	 *  var checkBalks:Array = checkBalk( _array1, _bigArray, new Point( 0, 1 ), false );
	 *  log( checkBalks );
	 * 	var searchPoints:Array = searchPoint( _array, checkBalks, new Point( 2, 2 ) );
	 * 	log( searchPoints );
	 * 	var nestArrays:Array = nestArray( _bigArray, searchPoints, new Point( 1, 0 ), true );
	 * 	log( nestArrays );
	 * 
	 * 
	 * 
	 * 
	 * 
	 */
	
	public class SearchingWalk
	{
		public function SearchingWalk()
		{
			
		}
		
		private function checkBalk( parent:Array, child:Array, point:Point, alginMiddle:Boolean = false ):Array
		{
			var array:Array = [];
			var i:int;
			var j:int;
			for ( i = 0; i < parent.length; i++ ) {
				array[ i ] = [];
				for ( j = 0; j < parent[i].length; j++ ) {
					if ( alginMiddle ) {
						if( Math.abs( i - point.y ) >= 0 &&
							Math.abs( i - point.y ) <= ( child.length - 1 ) / 2 &&
							Math.abs( j - point.x ) >= 0 &&
							Math.abs( j - point.x ) <= ( child[ 0 ].length - 1 ) / 2 
						) {
							array[i][j] = child[ int ( i - point.y + ( child[0].length - 1 ) / 2 ) ][ j - point.x + int( ( child.length - 1 ) / 2 ) ] == 0 ? parent[i][j] : 0 ;
						}
						else {
							array[i][j] = 0;
						}
					}
					else {
						if ( i - point.y >= 0 &&
							i - point.y < child.length &&
							j - point.x >= 0 &&
							j - point.x < child[ i - point.y ].length ) {
							array[i][j] = child[i - point.y][j - point.x] == 0 ? parent[i][j] : 0 ;
						}
						else {
							array[i][j] = 0;
						}
					}
				}
			}
			return array;
		}
		
		private function searchPoint( parent:Array, child:Array, point:Point ):Array
		{
			var array:Array = [];
			var result:Array = [];
			var i:int;
			var j:int;
			var z:int;
			var balk:String = "";
			for ( i = 0; i < child.length; i++ ) {
				balk += child[ i ].join("")
			}
			array = balk.split( "0" );
			
			for ( i = 0; i < parent.length; i++ ) {
				result[i] = [];
				for ( j = 0; j < parent[i].length; j++ ) {
					var isSearched:Boolean = false;
					for ( z = 0; z < array.length; z++ ) {
						if ( ( array[z] != "" ) && ( String( parent[i][j] ).indexOf( array[z] ) != -1 ) ) {
							isSearched = true;
							result[i][j] = 1;
							break;
						}
					}
					if ( !isSearched ) {
						result[i][j] = 0;
					}
				}
			}
			
			return result;
		}
		
		private function nestArray( parent:Array, child:Array, point:Point, alginMiddle:Boolean = false ):Array
		{
			var array:Array = [];
			var i:int;
			var j:int;
			for ( i = 0; i < parent.length; i++ ) {
				array[ i ] = [];
				for ( j = 0; j < parent[i].length; j++ ) {
					if ( alginMiddle ) {
						var centerX:int = ( child[ 0 ].length + 1 ) / 2;
						var centerY:int = ( child.length + 1 ) / 2;
						if( Math.abs( i - point.y ) >= 0 &&
							Math.abs( i - point.y ) <= ( child.length - 1 ) / 2 &&
							Math.abs( j - point.x ) >= 0 &&
							Math.abs( j - point.x ) <= ( child[ 0 ].length - 1 ) / 2 
						){
							array[i][j] = child[ int ( i - point.y + ( child[0].length - 1 ) / 2 ) ][ j - point.x + int( ( child.length - 1 ) / 2 ) ] //== 0 ? parent[i][j] : child[ int ( i - point.y + ( child[0].length - 1 ) / 2 ) ][ j - point.x + int( ( child.length - 1 ) / 2 ) ];
						}
						else {
							array[i][j] = 0//parent[i][j];
						}
					}
					else {
						if ( i - point.y >= 0 &&
							i - point.y < child.length &&
							j - point.x >= 0 &&
							j - point.x < child[ i - point.y ].length ) {
							array[i][j] = child[i - point.y][j - point.x] //== 0 ? parent[i][j] : child[i - point.y][j - point.x];
						}
						else {
							array[i][j] = 0//parent[i][j];
						}
					}
				}
			}
			return array;
		}
		
		private function log( array:Array ):void
		{
			var i:int;
			for ( i = 0; i < array.length; i++ ) {
				trace( array[ i ] );
			}
		}
	}
}