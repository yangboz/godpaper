package com.lookbackon.ds
{
	import com.godpaper.as3.utils.ProxyArray;
	import de.polygonal.ds.Array2;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------

	/**
	 * The numbers in this array are labels on the winnable n-in-a-row areas of the board.</br>
	 * This is useful so that when a piece is dropped into an arbitrary board position, </br>
	 * the algorithm can determine very quickly which n-in-a-row areas have become more likely destined for a win for the player, </br>
	 * and, as importantly, which n-in-a-row areas are no longer possibilities for the opposing player.  </br>
	 * The numbers in the map[x][y] array are indexes into a pair of parallel single-dimensional arrays
	 * which keep track of how likely each n-in-a-row area is to be the winning area for each player.  </br>
	 * I call this the stats array.  The "score" of a player is merely the sum of the stats array of the player.  </br>
	 * Subtracting one score from another determines how well a player is doing relative to the opposing player.  </br>
	 * You throw these numbers into your general run-of-the-mill minimax algorithm, throw in some alpha-beta cutoff logic for efficiency,
	 * and that, in a nutshell, is the secret to my algorithm.</br>
	 * The original connect-4 algorithm created by Keith Pomakis(pomakis@pobox.com),aslo I get this right to translate to AS3 version.
	 * 
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created May 23, 2011 6:18:17 PM
	 * @see http://www.pomakis.com/c4/
	 */
	public class NumberBoard
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//map setting.
		private var map:Array2;
		private var size_x:int;
		private var size_y:int;
		private var num_to_connect:int;
		//for lattance/window indexing.
		private var win_index:int=0;
		//labels.
		private var _horizontalLabels:Array=[];
		private var _verticalLabels:Array=[];
		private var _forwardDiagonalLabels:Array=[];
		private var _backwardDiagonalLabels:Array=[];
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		public static const HORIZONTAL:String = "H";//"horizontal direction";
		public static const VERTICAL:String = "V";//"vertical direction";
		public static const FORWARD_DIAGONAL:String = "F"//"forward diagonal direction";
		public static const BACKWARD_DIAGONAL:String = "B";//"backward diagonal direction";
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		/**
		 * Each n-in-a-row area on the board in which a winning connection
		 * can be made is given a unique number from 0 to z-1.
		 * Each space on the board is told which n-in-a-row areas it is part of.
		 * This is done with the array...
		 * @return the number of possible n-in-a-row areas on the board in which a winning connection can be made.
		 */
		public function get z():int
		{
			return 4 * size_x * size_y - 3 * size_x * num_to_connect - 3 * size_y * num_to_connect + 3 * size_x + 3 * size_y - 4 * num_to_connect + 2 * num_to_connect * num_to_connect + 2;
		}
	   /**                                                                        
		*  This function returns the number of possible win positions on a board 
		*  of dimensions x by y with n being the number of pieces required in a  
		*  row in order to win.                                                  
		*/                                                                        
		public function get numOfWinPlaces():int
		{
			if (size_x < num_to_connect && size_y < num_to_connect)
				return 0;
			else if (size_x < num_to_connect)
				return size_x * ((size_y - num_to_connect) + 1);
			else if (size_y < num_to_connect)
				return size_y * ((size_x - num_to_connect) + 1);
			else
				return 4 * size_x * size_y - 3 * size_x * num_to_connect - 3 * size_y * num_to_connect + 3 * size_x + 3 * size_y - 4 * num_to_connect + 2 * num_to_connect * num_to_connect + 2;
		}
		/**
		 * @return the magic win number;
		 */		
		public function get magicWinNumber():uint
		{
			return 1 << num_to_connect;
		}
		/**
		 * 
		 * @return the number labels in horiztoal direction.
		 * 
		 */		
		public function get horizontalLabels():Array
		{
			return getElementUniqueArray(_horizontalLabels);
		}
		/**
		 * 
		 * @return the number labels in vertical direction.
		 * 
		 */
		public function get verticalLabels():Array
		{
			return getElementUniqueArray(_verticalLabels);
		}
		/**
		 * 
		 * @return the number labels in forward diagonal direction.
		 * 
		 */
		public function get forwardDiagonalLabels():Array
		{
			return getElementUniqueArray(_forwardDiagonalLabels);
		}
		/**
		 * 
		 * @return the number labels in backward diagonal direction.
		 * 
		 */
		public function get backwardDiagonalLabels():Array
		{
			return getElementUniqueArray(_backwardDiagonalLabels);
		}
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
//		sample map[x][y] for x = 7, y = 6, and n = 4:
//      +---------+---------+---------+---------+---------+---------+---------+
//	    |20,26,59 |20,21,29,|20,21,22,|20,21,22,|21,22,23,|22,23,41,|23,44,56 |
//		|         |62       |32,65    |23,35,47,|38,50    |53       |         |
//	  5 |         |         |         |68       |         |         |         |
//		|         |         |         |         |         |         |         |
//		|         |         |         |         |         |         |         |
//		+---------+---------+---------+---------+---------+---------+---------+
//		|16,25,26,|16,17,28,|16,17,18,|16,17,18,|17,18,19,|18,19,40,|19,43,44,|
//		|58       |29,59,61 |31,32,47,|19,34,35,|37,38,49,|41,52,56 |55       |
//	  4 |         |         |62,64    |46,50,65,|53,68    |         |         |
//		|         |         |         |67       |         |         |         |
//		|         |         |         |         |         |         |         |
//		+---------+---------+---------+---------+---------+---------+---------+
//		|12,24,25,|12,13,27,|12,13,14,|12,13,14,|13,14,15,|14,15,39,|15,42,43,|
//		|26,57    |28,29,47,|30,31,32,|15,33,34,|36,37,38,|40,41,51,|44,54    |
//	  3 |         |58,60    |46,50,59,|35,45,49,|48,52,56,|55,68    |         |
//		|         |         |61,63    |53,62,64,|65,67    |         |         |
//		|         |         |         |66       |         |         |         |
//		+---------+---------+---------+---------+---------+---------+---------+
//		|8,24,25, |8,9,27,  |8,9,10,  |8,9,10,  |9,10,11, |10,11,39,|11,42,43,|
//		|26,47    |28,29,46,|30,31,32,|11,33,34,|36,37,38,|40,41,54,|44,68    |
//	  2 |         |50,57    |45,49,53,|35,48,52,|51,55,62,|65,67    |         |
//		|         |         |58,60    |56,59,61,|64,66    |         |         |
//		|         |         |         |63       |         |         |         |
//		+---------+---------+---------+---------+---------+---------+---------+
//		|4,24,25, |4,5,27,  |4,5,6,30,|4,5,6,7, |5,6,7,36,|6,7,39,  |7,42,43, |
//		|46       |28,45,49 |31,48,52,|33,34,51,|37,54,61,|40,64,66 |67       |
//	  1 |         |         |57       |55,58,60 |63       |         |         |
//		|         |         |         |         |         |         |         |
//		|         |         |         |         |         |         |         |
//		+---------+---------+---------+---------+---------+---------+---------+
//		|0,24,45  |0,1,27,  |0,1,2,30,|0,1,2,3, |1,2,3,36,|2,3,39,63|3,42,66  |
//		|         |48       |51       |33,54,57 |60       |         |         |
//	  0 |         |         |         |         |         |         |         |
//		|         |         |         |         |         |         |         |
//		|         |         |         |         |         |         |         |
//		+---------+---------+---------+---------+---------+---------+---------+
//		
//		0         1         2         3         4         5         6
//		
//		0 - 23: horizontal wins
//		24 - 44: vertical wins
//		45 - 56: forward diagonal wins
//		57 - 68: backward diagonal wins

		/**
		 * A magic number board data structure, mixed number labels' permutation and combination.
		 * @param x the width of map.
		 * @param y the height of map.
		 * @param n the connection number in some direction.
		 * @param h whether horizontal connection.
		 * @param v whether vertical connection.
		 * @param f whether forward diagonal connection.
		 * @param b whether backward diagonal connection.
		 */
		public function NumberBoard(x:int, y:int, n:int,h:Boolean,v:Boolean,f:Boolean,b:Boolean)
		{
			//
			this.size_x=x;
			this.size_y=y;
			this.num_to_connect=n;
			//initialization.
			this.setupMap();
//			trace("map@setupMap:", map.dump());
			if(h)
			{
				this.horizontalFillIn();
//				trace("map@horizontalFillIn:", map.dump());
			}
			if(v)
			{
				this.verticalFillIn();
//				trace("map@verticalFillIn:", map.dump());
			}
			if(f)
			{
				this.forwardDiagonalFillIn();
//				trace("map@forwardDiagonalFillIn:", map.dump());
			}
			if(b)
			{
				this.backwardDiagonalFillIn();
//				trace("map@backwardDiagonalFillIn:", map.dump());
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		//
		public function toString():String
		{
			return map.dump();
		}
		/**
		 * The referenced source's connex determined by number board's label with direction and the length of connection;
		 * @param x the x coordinate.
		 * @param y the y coordinate.
		 * @param ref the referenced source.
		 * @param dir the direction label.
		 * @return whether the connex label on the direction existed.
		 * 
		 */		
		public function hasConnex(x:int,y:int,ref:Array,dir:String):Boolean
		{
			//Under this order: 
			//from LEFT to RIGHT;
			//from UP to DOWN.
			var hasLabel:Boolean = Boolean(this.findMathedElements(this.map.gett(x,y),ref).length);
			var fellShortOf:Boolean;//not enough length;
			switch(dir)
			{
				case HORIZONTAL:
					fellShortOf = (size_x>=x+this.num_to_connect);
					break;
				case VERTICAL:
					fellShortOf = (size_y>=y+this.num_to_connect);
					break;
				case FORWARD_DIAGONAL:
					fellShortOf = ( (x+this.num_to_connect<=size_x) && (y+this.num_to_connect<=size_y) );
					break;
				case BACKWARD_DIAGONAL:
					fellShortOf = ( (x>=this.num_to_connect) &&(y+this.num_to_connect<=size_y) );
					break;
				default:
					break;
			}
			return (hasLabel && fellShortOf);
		}
		/**
		 * Should keep the providing board as the same size of numberboard.
		 * Partial with flag object to indentify the connex elements.
		 * Return the connex results,such as z[0]-horizontally,z[1]-vertically,z[2]-forwardDiagonal,z[3]-backwardDiagonal
		 * @param board the board resource;
		 * @param len the length of connex;
		 * @return the calculated connections categoried by array;
		 */		
		public function getConnex(board:Array2,len:int):Array
		{
//			trace("connex board:",board.dump());
			var z:Array = [];
			z[0] = [];//for horizontally.
			z[1] = [];//for vertically.
			z[2] = [];//for forwardDiagonally.
			z[3] = [];//for backwardDiagonally.
			//
			for(var y:int=0;y<board.height;y++)
			{
				for(var x:int=0;x<board.width;x++)
				{
					//horizontally
					if( this.hasConnex(x,y,this.horizontalLabels,HORIZONTAL))
					{
//						trace("horizontal connex coordinate:",x,y);
						//then find it
						var hGroup:Array = [];
						var hk:int=0;
						while(hk<len)
						{
							hGroup.push(board.gett(x+hk,y));
							hk++;
						}
						//get successionalGroup.
						var hSuccessionalGroup:Array = this.getSuccessionalGroup(hGroup,len);
						if(hSuccessionalGroup.length)
						{
							if(-1==(z[0] as Array).indexOf(hSuccessionalGroup[0]))
							{
								(z[0] as Array).push( hSuccessionalGroup );
							}
						}
					}
					//vertically
					if( this.hasConnex(x,y,this.verticalLabels,VERTICAL))
					{
//						trace("vertical connex coordinate:",x,y);
						//then find it
						var vGroup:Array = [];
						var vk:int=0;
						while(vk<len)
						{
							vGroup.push(board.gett(x,y+vk));
							vk++;
						}
						//get successionalGroup.
						var vSuccessionalGroup:Array = this.getSuccessionalGroup(vGroup,len);
						if(vSuccessionalGroup.length)
						{
							(z[1] as Array).push( vSuccessionalGroup );
						}
					}
					//forward diagonal
					if( this.hasConnex(x,y,this.forwardDiagonalLabels,FORWARD_DIAGONAL))
					{
//						trace("forwardDiagonal connex coordinate:",x,y);
						//then find it
						var fGroup:Array = [];
						var fk:int=0;
						while(fk<len)
						{
							fGroup.push(board.gett(x+fk,y+fk));
							fk++;
						}
						//get successionalGroup.
						var fSuccessionalGroup:Array = this.getSuccessionalGroup(fGroup,len);
						if(fSuccessionalGroup.length)
						{
							(z[2] as Array).push( fSuccessionalGroup );
						}
					}
					//backward diagonal
					if( this.hasConnex(x,y,this.backwardDiagonalLabels,BACKWARD_DIAGONAL))
					{
//						trace("backwardDiagonal connex coordinate:",x,y);
						//then find it
						var bGroup:Array = [];
						var bk:int=0;
						while(bk<len)
						{
							bGroup.unshift(board.gett(x-bk,y+bk));
							bk++;
						}
						//get successionalGroup.
						var bSuccessionalGroup:Array = this.getSuccessionalGroup(bGroup,len);
						if(bSuccessionalGroup.length)
						{
							(z[3] as Array).push( bSuccessionalGroup );
						}
					}
				}
			}
			//filter array elements
			if(z[0].length)
			{
				z[0] = getUniqueArrays(z[0]);
				for(var z0:int=0;z0<z[0].length;z0++)
				{
//					trace("z0[",z0,"]:",z[0][z0]);
				}
			}
			if(z[1].length)
			{
				z[1] = getUniqueArrays(z[1]);
				for(var z1:int=0;z1<z[1].length;z1++)
				{
//					trace("z1[",z1,"]:",z[1][z1]);
				}
			}
			if(z[2].length)
			{
				z[2] = getUniqueArrays(z[2]);
				for(var z2:int=0;z2<z[2].length;z2++)
				{
//					trace("z2[",z2,"]:",z[2][z2]);
				}
			}
			if(z[3].length)
			{
				z[3] = getUniqueArrays(z[3]);
				for(var z3:int=0;z3<z[3].length;z3++)
				{
//					trace("z3[",z3,"]:",z[3][z3]);
				}
			}
			//
			return z;
		}
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		/* Set up the map */
		/**
		 * an array in which each element is a list specifying,
		 * for each corresponding board space,
		 * which n-in-a-row areas it is part of.
		 */
		protected function setupMap():void
		{
			//
			map = new Array2(size_x,size_y);
			//
			for (var i:int=0; i < size_x; i++)
			{
				for (var j:int=0; j < size_y; j++)
				{
//					map[x][y] is an array of win place indices, terminated by a -1.
					map.sett(i,j,[]);
					map.gett(i,j)[0]=-1;
				}
			}
			//
			this.win_index=0;
		}
		//
		protected function horizontalFillIn():void
		{
			for (var i:int=0; i < size_y; i++)
			{
				for (var j:int=0; j < (size_x - num_to_connect + 1); j++)
				{
					for (var k:int=0; k < num_to_connect; k++)
					{	
						//
						var x:int = 0;
						while (map.gett(j + k,i)[x] != -1)
						{
							x++;
						}
						//set label
						map.gett(j + k,i)[x++]=win_index;
						map.gett(j + k,i)[x]=-1;
						//push lables
						_horizontalLabels.push(win_index);
					}
					win_index++;
				}
			}
		}
		//
		protected function verticalFillIn():void
		{
			for (var i:int=0; i < size_x; i++)
			{
				for (var j:int=0; j < (size_y - num_to_connect + 1); j++)
				{
					for (var k:int=0; k < num_to_connect; k++)
					{
						//
						var x:int = 0;
						while (map.gett(i,j+k)[x] != -1)
						{
							x++;
						}
						//set label
						map.gett(i,j + k)[x++]=win_index;
						map.gett(i,j + k)[x]=-1;
						//push lables
						_verticalLabels.push(win_index);
					}
					win_index++;
				}
			}
		}
		//
		protected function forwardDiagonalFillIn():void
		{
			for (var i:int=0; i < (size_y - num_to_connect + 1); i++)
			{
				for (var j:int=0; j < (size_x - num_to_connect + 1); j++)
				{
					for (var k:int=0; k < num_to_connect; k++)
					{
						//
						var x:int = 0;
						while (map.gett(j + k,i + k)[x] != -1)
						{
							x++;
						}
						//set label
						map.gett(j + k,i + k)[x++]=win_index;
						map.gett(j + k,i + k)[x]=-1;
						//push lables
						_forwardDiagonalLabels.push(win_index);
					}
					win_index++;
				}
			}
		}
		//
		protected function backwardDiagonalFillIn():void
		{
			for (var i:int=0; i < (size_y - num_to_connect + 1); i++)
			{
				for (var j:int=size_x - 1; j >= num_to_connect - 1; j--)
				{
					for (var k:int=0; k < num_to_connect; k++)
					{
						//
						var x:int = 0;
						while (map.gett(j - k,i + k)[x] != -1)
						{
							x++;
						}
						//set label
						map.gett(j - k,i + k)[x++]=win_index;
						map.gett(j - k,i + k)[x]=-1;
						//push lables
						_backwardDiagonalLabels.push(win_index);
					}
					win_index++;
				}
			}
		}
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		/**
		 * Both of the source and target should pre filtered the dumplicated elements to save loop cost.
		 * @param source the source should be filtered by target table.
		 * @param target the matching target table.
		 * @return filtered result.
		 */		
		private function findMathedElements(source:Array,target:Array):Array
		{
			var z:Array = [];
			for(var i:int=0;i<source.length;i++)
			{
				if(source[i] in target)
				{
					z.push(source[i]);
				}
			}
			return z;
		}
		//At least the group's element shoule be successional align.
		private function getSuccessionalGroup(source:Array,len:int):Array
		{
			var result:Array = [];
			var groupProxy:ProxyArray = new ProxyArray(source);
			var objectSum:int = groupProxy.objectSum();
			//if the total number at least bigger than len?
			if(objectSum==len)
			{
				return source;
			}
			return result;
		}
		//Array filter callback functions.
		private function notNull(element:*, index:int, arr:Array):Boolean 
		{
			return (element != null);
		}
		//
		private function getElementUniqueArray(source:Array):Array
		{
			var z:Array = source.filter(function (a:*,b:int,c:Array):Boolean { return ((z ? z : z = new Array()).indexOf(a) >= 0 ? false : (z.push(a) >= 0)); }, this);
			return z;
		}
		//
		private function getUniqueArrays(source:Array):Array
		{
			var result:Array = [];
			if(source.length)
			{
				result.push(source[0]);
			}
			for(var i:int=1;i<source.length;i++)
			{
				for(var j:int=0;j<result.length;j++)
				{
					//only check the first element value.
					if(result[j][0]!=source[i][0])
					{
						result.push(source[i]);
					}
				}
			}
			return result;
		}
	}

}