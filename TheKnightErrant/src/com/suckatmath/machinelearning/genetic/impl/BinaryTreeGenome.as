package com.suckatmath.machinelearning.genetic.impl {
	import com.suckatmath.machinelearning.genetic.core.Genome;
	import com.suckatmath.machinelearning.genetic.core.Gene;
	import flash.utils.Dictionary;
	
	/**
	* Binary tree backed Genome. 
	* This uses non-isomorphic trees, and may grow arbitrarily.
	* @author srs
	*/
	public class BinaryTreeGenome implements Genome
	{
		/**
		 * content Gene for this node
		 */
		public var gene:Gene; 
		
		/**
		 * BinaryTreeGenome left child of this Genome
		 */
		public var left:BinaryTreeGenome;
		
		/**
		 * BinaryTreeGenome right child of this Genome
		 */
		public var right:BinaryTreeGenome;
		
		/**
		 * reference to parent BinaryTreeGenome
		 */
		public var parent:BinaryTreeGenome;
		
		/**
		 * maximum number of random nodes to generate in newRandom - defaults to 1
		 */
		public var randomNodeLimit:int;
		
		/**
		 * constructs a new empty BinaryTreeGenome
		 */
		public function BinaryTreeGenome() {
			left = null;
			right = null;
			parent = null;
			gene = null;
			randomNodeLimit = 1;
		}
		
		/**
		 * sets left child genome
		 * @param	b BinaryTreeGenome
		 */
		public function setLeft(b:BinaryTreeGenome):void {
			left = b;
			left.parent = this;
		}
		
		/**
		 * sets right child genome
		 * @param	b BinaryTreeGenome
		 */
		public function setRight(b:BinaryTreeGenome):void {
			right = b;
			right.parent = this;
		}
		
		/**
		 * set back reference to parent genome
		 * @param	b BinaryTreeGenome
		 */
		public function setParent(b:BinaryTreeGenome):void {
			parent = b;
		}
		
		/**
		 * set maximum number of nodes to generate in newRandom
		 * @param	i int
		 */
		public function setRandomNodeLimit(i:int):void {
			randomNodeLimit = i;
		}
		
		/**
		 * create a copy of this Genome with some probability of mutation in a single Gene
		 * @param	probability
		 * @return Genome
		 */
		public function mutate(probability:Number):Genome {
			var toreturn:BinaryTreeGenome = this.clone() as BinaryTreeGenome;
			var p:Number;
			p = Math.random();
			if (p < probability) { //we do mutate.
				var allNodes:Array = toreturn.collectAllNodes(toreturn);
				allNodes[Math.floor(Math.random() * allNodes.length)].mutateInPlace();
			}
			return toreturn;
		}
		
		/**
		 * replaces content gene with mutated version
		 */
		private function mutateInPlace():void
		{
			this.gene = gene.mutate();
		}
		
		
		/**
		 * generate a new genome through "sexual" reproduction combining subtrees of a collection of BinaryTreeGenomes
		 * @param	others Array of BinaryTreeGenome
		 * @param	numpoints int number of splice points for subtree replacement
		 * @return  BinaryTreeGenome as Genome
		 */
		public function crossover(others:Array, numpoints:int):Genome {
			var toreturn:BinaryTreeGenome = this.clone() as BinaryTreeGenome;
			if (others.indexOf(this) == -1) {
				others.push(toreturn);
			}
			var nodes:Array;
			var nodesets:Dictionary = new Dictionary(); //from BinaryTreeGenome to flat Array of nodes in Genome
			for (var i:int = 0; i < others.length; i++) {
				nodesets[others[i]] = collectAllNodes(others[i]);
			}
			nodesets[toreturn] = collectAllNodes(toreturn);
			
			var nodeFromOther:BinaryTreeGenome;
			var nodeFromTR:BinaryTreeGenome;
			for (i = 0; i < numpoints; i++) {
				nodes = nodesets[others[Math.floor(Math.random() * others.length)]];
				//choose random node from nodes
				nodeFromOther = nodes[Math.floor(Math.random() * nodes.length)].clone();
				
				nodes = nodesets[toreturn];
				//choose random node from toreturn;
				nodeFromTR = nodes[Math.floor(Math.random() * nodes.length)];  //this threw nullpointer somehow.
				if (nodeFromTR.parent == null) {
					toreturn = nodeFromOther;
					nodesets[toreturn] = collectAllNodes(toreturn);
				}else{
					if (nodeFromTR.parent.left == nodeFromTR) {
						nodeFromTR.setLeft(nodeFromOther);
					}else {
						nodeFromTR.setRight(nodeFromOther);
					}
				}
			}
			return toreturn;
		}
		
		/**
		 * generate a new random BinaryTreeGenome
		 * @return BinaryTreeGenome as Genome
		 */
		public function newRandom():Genome {
			//since trees are not guaranteed to be isomorphic, create nodes willy nilly.  Up to rand()*limit.
			var toreturn:BinaryTreeGenome = new BinaryTreeGenome();
			var limit:int = Math.floor(Math.random() * randomNodeLimit);
			toreturn.gene = this.gene.newRandom();
			
			var allnodes:Array = new Array();
			allnodes.push(toreturn);
			var anode:BinaryTreeGenome;
			var pnode:BinaryTreeGenome;
			var attached:Boolean = false;
			var pidx:int;
			for (var i:int = 0; i < limit; i++) {
				attached = false;
				anode = new BinaryTreeGenome();
				anode.gene = this.gene.newRandom();
				pidx = Math.floor(Math.random() * allnodes.length);
				while (!attached){
					pnode = allnodes[pidx];
					if (pnode.left == null) {
						pnode.setLeft(anode);
						attached = true;
					}else if (pnode.right == null) {
						pnode.setRight(anode);
						attached = true;
					}else {
						allnodes.splice(pidx, 1); //remove nodes with both kids.  can't add more kids to 'em.
					}
				}
				allnodes.push(anode);
			}
			return toreturn;
		}
		
		/**
		 * return a copy of this BinaryTreeGenome
		 * @return BinaryTreeGenome as Genome
		 */
		public function clone():Genome {
			var toreturn:BinaryTreeGenome = new BinaryTreeGenome();
			toreturn.gene = this.gene;
			if (left != null) {
				toreturn.setLeft(left.clone() as BinaryTreeGenome);
			}
			if (right != null) {
				toreturn.setRight(right.clone() as BinaryTreeGenome);
			}
			return toreturn;
		}
		
		/**
		 * flatten tree into an array
		 * @param	btg BinaryTreeGenome
		 * @return  Array of BinaryTreeGenome
		 */
		private function collectAllNodes(btg:BinaryTreeGenome):Array {
			var toreturn:Array = new Array();
			_collectAllNodes(btg, toreturn);
			return toreturn;
		}
		
		/**
		 * flatten tree into a collector Array variable
		 * @param	btg BinaryTreeGenome
		 * @param	collect Array
		 */
		private function _collectAllNodes(btg:BinaryTreeGenome, collect:Array):void {
			collect.push(btg);
			if (btg.left != null) {
				_collectAllNodes(btg.left, collect);
			}
			if (btg.right != null) {
				_collectAllNodes(btg.right, collect);
			}
		}
		
		/**
		 * return a String representation of this BinaryTreeGenome
		 * reports in indented multi-line depth first order, where left is before right
		 * @return String
		 */
		public function toString():String {
			return _toString("");
		}
		
		/**
		 * return an indented representation of this BinaryTreeGenome
		 * @param	indent String to prepend to each line
		 * @return String
		 */
		private function _toString(indent:String):String {
			var toreturn:String = "\n"+indent + gene;
			if (left != null) {
				toreturn += left._toString(indent + " ");
			}
			if (right != null) {
				toreturn += right._toString(indent + " ");
			}
			return toreturn;
		}
		
		
		
	}
	
}