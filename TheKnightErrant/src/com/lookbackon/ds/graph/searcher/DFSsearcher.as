package com.lookbackon.ds.graph.searcher
{
	import com.lookbackon.ds.graph.Edge;
	import com.lookbackon.ds.GraphBoard;

	import mx.collections.ArrayCollection;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------

	/**
	 * DFSsearcher.as class.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Jun 1, 2011 6:17:43 PM
	 */
	public class DFSsearcher extends SearcherBase
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

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
		public function DFSsearcher(graph:GraphBoard)
		{
			super(graph);
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		override public function search(src:int, dst:int):Boolean
		{
			var queue:Array /* of Edge */=[];
			queue.push(new Edge(src, src));

			var visited:Array /* of Boolean */=new Array(graphRef_.size);
			visited[src]=true;

			var route:Array /* of int */=new Array(graphRef_.size);

			while (queue.length > 0)
			{
				var next:Edge=queue.pop();
				route[next.dst]=next.src;

				if (next.dst == dst)
				{
					src_=src;
					dst_=dst;
					route_=route;
					found_=true;
					return true;
				}

				var dsts:Array=graphRef_.edge(next.dst);
				for each (var e:Edge in dsts)
				{
					if (!visited[e.dst])
					{
						queue.push(e);
						visited[e.dst]=true;
					}
				}
			}

			return false;
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
		/*采用邻接表存储结构编写一个判别无向图中任意给定的两个顶点之间是否存在一条长度为k的简单路径的算法  
		int DDFSTRVAERSE(algraph graph,int num1,int num2,int kk)//kk是要判断的长度，num1,num2为给定的两个点，graph为图；
		{int v;，
		arclist P;
		visited[num1]=TRUE;//表示已访问num1节点
		P=graph.vetices[num1].firstarc;
		for(v=P->adjvex;v>=0;P=P->nextarc,v=P->adjvex)
		{if(!visited[v])
		{if((kk==1)&&(v==num2))return YES;
		else if(kk==1)continue;//
		else if(v==num2)continue;//
		else{P=P->nextarc;
		v=P->adjvex;
		if(DDFSTRVAERSE(graph,v,num2,kk-1))return YES;
		}
		}
		visited[num1]=FLASE;
		return NO;
		}
		} */
	}

}
