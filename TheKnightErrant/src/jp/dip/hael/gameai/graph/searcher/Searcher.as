package jp.dip.hael.gameai.graph.searcher
{
	import flash.events.EventDispatcher;
	
	import jp.dip.hael.gameai.graph.Edge;
	import jp.dip.hael.gameai.graph.GraphEx;


	/**
	 * グラフの経路探索を行うクラス<br />
	 * イベントを投げるver.にも対応予定？
	 */
	public class Searcher extends EventDispatcher
	{
		/**
		 * 直近で成功した探索で見つけた経路への参照
		 */
		public function get pathRef():Array /* of Edge */ {
			if(found_){
				path_  = route2path(route_, src_, dst_);
				found_ = false;
			}
			return path_;
		}
		
		/**
		 * 直近で成功した探索で見つけた経路のコピー
		 */
		public function get path():Array /* of Edge */{
			return pathRef.slice();
		}
		
		
		/**
		 * コンストラクタ
		 * 
		 * @param graph 探索対象のグラフ
		 */
		public function Searcher(graph:GraphEx)
		{
			graphRef_ = graph;
			path_     = [];
			route_    = [];
			found_    = false;
			super();
		}
		
		/**
		 * 探索実行
		 * 
		 * @param src 始点
		 * @param dst 終点
		 * @return 該当経路は存在したらtrue, 存在しなかったらfalse
		 */
		public function search(src:int, dst:int):Boolean
		{
			return false;
		}
		
		
		/**
		 * @private
		 * あとでかく
		 */
		protected function route2path(route:Array, src:int, dst:int):Array
		{
			var path:Array = [];
			var s:int = -1, d:int = dst;
			while(s != src){
				s = route[d];
				path.push(new Edge(s, d));
				d = s;
			}
			return path.reverse();
		}
		
		protected var graphRef_:GraphEx;
		protected var path_:Array /* of int */;
		protected var route_:Array /* of int */;
		protected var src_:int, dst_:int;
		protected var found_:Boolean;
	}
}