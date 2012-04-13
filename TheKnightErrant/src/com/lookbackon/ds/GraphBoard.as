package com.lookbackon.ds
{
	import com.lookbackon.ds.graph.Edge;
	import com.lookbackon.ds.graph.Node;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	/**
	 * This graphic board providing the graph data struct and searchable functions;
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jun 1, 2011 5:49:28 PM
	 */
	public class GraphBoard
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var nNodes_:int;
		private var nodes_:Array /* of Node */;
		private var edges_:Array /* of Array */;
		private var isDigraph_:Boolean;

		//----------------------------------
		//  CONSTANTS
		//----------------------------------

		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		/**
		 * Size of node buffer (number of ≠ nodes)
		 */
		public function size():int
		{
			return nodes_.length;
		}

		/**
		 * Number of nodes
		 */
		public function nNodes():int
		{
			return nNodes_;
		}

		/**
		 * Node acquisition
		 * @param index Index
		 */
		public function node(index:int):Node
		{
			return nodes_[index];
		}

		/**
		 * Edge group acquisition
		 * @param src Start point
		 */
		public function edge(src:int):Array /* of Edge */
		{
			return edges_[src];
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
		/**
		 * Constructor<br />
		 * Graph uncorrespondence for ..no..
		 *
		 * @param isDigraph Whether it is an effective graph or not?
		 */
		public function GraphBoard(w:int, h:int, isDigraph:Boolean=true)
		{
			//
			isDigraph_=isDigraph;
			nodes_=[];
			edges_=[];
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		//
		/**
		 * Node addition
		 *
		 * @param node Added node
		 * @return Index of added node
		 */
		public function addNode(node:Node):int
		{
			var l:int=nodes_.length;
			var ind:int=node.index;

			// nodes_When it drinks and range [ni] has been installed, it substitutes it as it is. 
			if (0 <= ind && ind < l)
			{
				nodes_[ind]=node;
				edges_[ind]=[];
			}
			// When it drinks and range [ni] has not been installed, nodes _ is enlarged and push. 
			else if (l <= ind)
			{
				for (var i:int=l; i < ind; i++)
				{
					nodes_.push(null);
					edges_.push([]);
				}
				nodes_.push(node);
				edges_.push([]);
			}
			// -1Then, push. 
			else
			{
				node.index=nodes_.length;
				nodes_.push(node);
				edges_.push([]);
			}

			nNodes_++;

			return node.index;
		}


		/**
		 * Node deletion
		 *
		 * @param index Index of deleted node
		 */
		public function removeNode(index:int):void
		{
			if (0 <= index && index < nodes_.length)
			{
				(nodes_[index] as Node).index=-1;
				edges_[index]=[];
				nNodes_--;
			}
		}


		/**
		 * Edge addition
		 *
		 * @param edge Added edge
		 * @return Whether it was possible to add it or not?
		 */
		public function addEdge(edge:Edge):Boolean
		{
			var src:int=edge.src;
			// When src has been installed within the range of nodes _, it is push as it is. 
			if (0 <= src && src < nodes_.length)
			{
				(edges_[src] as Array).push(edge);
				return true;
			}
			// It fails when not installing. 
			else
			{
				return false;
			}
		}


		/**
		 * Edge deletion
		 *
		 * @param src Starting point of deleted edge
		 * @param dst Terminal of deleted edge
		 */
		public function removeEdge(src:int, dst:int):void
		{
			if (0 <= src && src < edges_.length)
			{
				var e:Array=edges_[src] as Array;
				var l:int=e.length;
				for (var i:int=0; i < l; i++)
				{
					if ((e[i] as Edge).dst == dst)
					{
						(e[i] as Edge).src=(e[i] as Edge).dst=-1;
						break;
					}
				}
			}
		}

		/**
		 * Prints out all elements (for debug/demo purposes).
		 *
		 * @return A human-readable representation of the structure.
		 */
		public function dump():String
		{
			var s:String="GraphEx\n{";
			s+="\n" + "nNodes:" + this.nNodes();
			for (var i:int=0; i < this.size(); i++)
			{
				if ((this.edges_[i] as Array).length > 0)
				{
					s+="\n" + "\t" + "edge[" + i + "]:{";
					for (var j:int=0; j < (this.edges_[i] as Array).length; j++)
					{
						s+="\n" + "\t" + "\t" + "edges[" + j + "]:" + (this.edges_[i] as Array)[j].dump();
					}
					s+="\n" + "\t" + "}";
				}
				else
				{
					s+="\n" + "\t" + "edge[" + i + "]:" + this.edges_[i];
				}
			}

			s+="\n" + "}";
			return s;
		}

		//to be fixed..
		public function clear():void
		{
			for (var k:int=0; k < this.nNodes(); k++)
			{
				this.removeNode(k);
			}
			for (var i:int=0; i < this.nNodes(); i++)
			{
				for (var j:int=0; j < this.nNodes(); j++)
				{
					this.removeEdge(i, j);
				}
			}
			nodes_=[];
			edges_=[];
			trace("GraphBoard after clear:", dump());
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
	}

}
