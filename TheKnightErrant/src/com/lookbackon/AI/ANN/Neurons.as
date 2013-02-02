package com.lookbackon.AI.ANN
{
	/**
	 *A Neural Network Layer or collection of cells or neurons 
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class Neurons
	{
		private var _container:Vector.<Neuron>;
//--------------------------------------------------------------------------
//
//  Constructor
//
//--------------------------------------------------------------------------
		public function Neurons()
		{
			this._container = new Vector.<Neuron>();
		}
//--------------------------------------------------------------------------
//
//  Methods:
//
//--------------------------------------------------------------------------		
		//----------------------------------
		//  add(native)
		//----------------------------------
		/// Adds a neuron to a Neural Network Layer or collection of cells
		/// The neuron to add to a Neural Network Layer
		public function add(newNeuron:Neuron):void
		{
//			this.addItem(newNeuron);
			this._container.push(newNeuron);
		}
		//----------------------------------
		//  insert(native)
		//----------------------------------
		public function insert(index:int,newNeuron:Neuron):void
		{
//			this.addItemAt(newNeuron,index);
			this._container[index] = newNeuron;
		}
		
		/// ReadOnly indexer - retrieves the neuron at a
		/// specific position orlocation in the Neural
		/// Network Layer or Neural Network Collection
		//----------------------------------
		//  gett(native)
		//----------------------------------
		public function getItemAt(index:int):Neuron
		{
//			return this.getItemAt(index) as Neuron;
			return this._container[index];
		}
		//----------------------------------
		//  length(native)
		//----------------------------------
		public function get length():int
		{
			return this._container.length;
		}
	}
}