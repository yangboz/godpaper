package jp.dip.hael.gameai.graph
{
	/**
	 * グラフ
	 */
	public class GraphEx
	{
		//---------------------------------------------------------------------
		//
		//  Accessor
		//
		//---------------------------------------------------------------------
		/**
		 * ノードバッファの大きさ(≠ノード数)
		 */
		public function size():int{ return nodes_.length; }
		
		/**
		 * ノード数
		 */
		public function nNodes():int{ return nNodes_; }
		
		/**
		 * ノード取得
		 * @param index インデクス
		 */
		public function node(index:int):Node { return nodes_[index]; }
		
		/**
		 * エッジ群取得
		 * @param src 始点
		 */
		public function edge(src:int):Array /* of Edge */ { return edges_[src]; }
		
		
		
		
		//---------------------------------------------------------------------
		//
		//  Public methods
		//
		//---------------------------------------------------------------------
		/**
		 * コンストラクタ<br />
		 * 無向グラフ未対応
		 * 
		 * @param isDigraph 有効グラフか否か
		 */
		public function GraphEx(isDigraph:Boolean = true)
		{
			isDigraph_ = isDigraph;
			nodes_ = [];
			edges_ = [];
		}
		
		
		/**
		 * ノード追加
		 * 
		 * @param node 追加するノード
		 * @return 追加したノードのインデクス
		 */
		public function addNode(node:Node):int
		{
			var l:int = nodes_.length;
			var ind:int = node.index;
			
			// nodes_の範囲に収まっていたらそのまま代入
			if(0 <= ind && ind < l){
				nodes_[ind] = node;
				edges_[ind] = [];
			}
				// nodes_の範囲に収まっていなかったらnodes_を大きくしてpush
			else if(l <= ind){
				for(var i:int = l; i < ind; i++){
					nodes_.push(null);
					edges_.push([]);
				}
				nodes_.push(node);
				edges_.push([]);
			}
				// -1ならpush
			else{
				node.index = nodes_.length;
				nodes_.push(node);
				edges_.push([]);
			}
			
			nNodes_++;
			
			return node.index;
		}
		
		
		/**
		 * ノード削除
		 * 
		 * @param index 削除するノードのインデクス
		 */
		public function removeNode(index:int):void
		{
			if(0 <= index && index < nodes_.length){
				(nodes_[index] as Node).index = -1;
				edges_[index] = [];
				nNodes_--;
			}
		}
		
		
		/**
		 * エッジ追加
		 * 
		 * @param edge 追加するエッジ
		 * @return 追加できたか否か
		 */
		public function addEdge(edge:Edge):Boolean
		{
			var src:int = edge.src;
			// srcがnodes_の範囲に収まっていたらそのままpush
			if(0 <= src && src < nodes_.length){
				(edges_[src] as Array).push(edge);
				return true;
			}
				// 収まってなかったら失敗
			else{
				return false;
			}
		}
		
		
		/**
		 * エッジ削除
		 * 
		 * @param src 削除するエッジの始点
		 * @param dst 削除するエッジの終点
		 */
		public function removeEdge(src:int, dst:int):void
		{
			if(0 <= src && src < edges_.length){
				var e:Array = edges_[src] as Array;
				var l:int = e.length;
				for(var i:int = 0; i < l; i++){
					if((e[i] as Edge).dst == dst){
						(e[i] as Edge).src = (e[i] as Edge).dst = -1;
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
			var s:String = "GraphEx\n{";
			s += "\n"+"nNodes:"+this.nNodes();
			for(var i:int=0;i<this.size();i++)
			{
				if( (this.edges_[i] as Array).length>0 )
				{
					s += "\n"+"\t"+"edge["+i+"]:{";
					for(var j:int=0;j<(this.edges_[i] as Array).length;j++)
					{
						s += "\n"+"\t"+"\t"+"edges["+j+"]:"+(this.edges_[i] as Array)[j].dump();
					}
					s += "\n"+"\t"+"}";
				}else
				{
					s += "\n"+"\t"+"edge["+i+"]:"+this.edges_[i];
				}
			}
			
			s += "\n"+"}";
			return s;
		}
		//to be fixed..
		public function clear():void
		{
			for(var k:int=0;k<this.nNodes();k++)
			{
				this.removeNode( k );
			}
			for(var i:int=0;i<this.nNodes();i++)
			{
				for(var j:int=0;j<this.nNodes();j++)
				{
					this.removeEdge( i,j);
				}
			}
			nodes_ = [];
			edges_ = [];
			trace("GraphEx after clear:",dump());
		}
		
		//---------------------------------------------------------------------
		//
		//  Purivate variables
		//
		//---------------------------------------------------------------------
		private var nNodes_:int;
		private var nodes_:Array/* of Node */;
		private var edges_:Array/* of Array */;
		private var isDigraph_:Boolean;
		
	}
}
