package com.suckatmath.machinelearning.genetic.core {
	
	/**
	* performs actual genetic algorithms
	* @author srs
	*/
	public class GeneticEngine implements EvolvableComparator{
		
		/**
		 * constant for ROULETTE selection : proportional selection.  This is the default selection mode
		 */
		public static const ROULETTE:int = 1;
		
		/**
		 * constant for TOURNAMENT selection 
		 */
		public static const TOURNAMENT:int = 2;
		
		/**
		 * Number of new random genomes per generation.
		 */
		public var numNewPerGeneration:int = 1;
		
		/**
		 * size of population
		 */
		private var popSize:int;
		
		/**
		 * population of Evolvables 
		 */
		private var population:Array;
		
		/**
		 * whether to use mutation in constructing new Evolvables
		 */
		private var _mutate:Boolean = true; 
		
		/**
		 * probability of a mutation.  Should be between 0 and 1.
		 */
		private var _mutateProb:Number = 0.5;
		
		/**
		 * whether to use crossover in constructing new Evolvables
		 */
		private var _crossover:Boolean = true;
		
		/**
		 * how many parents contribute to new Evolvables.
		 */
		private var _crossoverNumParents:int = 2;
		
		/**
		 * how many crossover points to use
		 */
		private var _crossoverNumPoints:int = 1;
		
		/**
		 * how many fittest of previous pop to carry over to new generation
		 */
		private var _carryOverNum:int = 0;
		
		/**
		 * selection mode.  ROULETTE or TOURNAMENT
		 */
		private var _selectionMode:int = ROULETTE;
		
		/**
		 * EvolvableComparator to use in TOURNAMENT mode.  defaults to this Genetic Engine
		 */
		private var _tournamentComparator:EvolvableComparator;
		
		/**
		 * factory to use to create new Evolvables
		 */
		private var factory:EvolvableFactory;
		
		
		/**
		 * new engine constructor
		 * @param	f EvolvableFactory to generate new Evolvables from Genomes
		 * @param	mutate Boolean whether to use mutation
		 * @param	crossover Boolean whether to use crossover
		 * @param	npg int number of new random individuals per generation
		 * @param	mprob Number probablity of mutation
		 * @param	cparents int Number of parents to use for crossover
		 * @param	ccross int Number of points to cross over in crossover operation
		 */
		public function GeneticEngine(f:EvolvableFactory, mutate:Boolean = true, crossover:Boolean = true, npg:int = 1, mprob:Number = 0.5, cparents:int = 2, ccross:int =1 ) {
			factory = f;
			_mutate = mutate;
			_crossover = crossover;
			numNewPerGeneration = npg;
			_mutateProb = mprob;
			_crossoverNumParents = cparents;
			_crossoverNumPoints = ccross;
			_selectionMode = ROULETTE;
			_tournamentComparator = this;
		}

		/**
		 * generate a new population of psize.  OR if population is already an existing array, replace it with an array of the same size
		 * which is full of random individuals
		 * @param	psize int
		 */
		public function randomPopulation(psize:int):void {
			if (population != null) {
				popSize = population.length;
			}else
			{
				popSize = psize;
				population = new Array();
			}
			for (var i:int = 0; i < popSize; i++) {
				population[i] = factory.makeRandomEvolvable();
			}
		}
		
		/**
		 * set population to array of Evolvables
		 * @param	pop
		 */
		public function setPopulation(pop:Array):void {
			this.population = pop;
			popSize = population.length;
		}
		
		/**
		 * gets population.
		 * @return
		 */
		public function getPopulation():Array {
			return population;
		}
		
		/**
		 * alters the existing population array to contain entries from a
		 * @param	a
		 */
		private function replacePopulation(a:Array):void {
			for (var i:int = 0; i < a.length; i++) {
				this.population[i] = a[i];
			}
			//trace("replacePop.  poplength:" + population.length+" alength:"+a.length);
			if (this.population.length > a.length) {
				this.population.splice(a.length -1, a.length - this.population.length); //delete the rest
				//trace("replacePop after.  poplength:" + population.length);
			}
		}
		
		/**
		 * set whether to use mutation in generating new individuals
		 * @param	m
		 */
		public function useMutate(m:Boolean):void {
			_mutate = m;
		}
		
		/**
		 * set probability of mutation in generating new individuals
		 * @param	n
		 */
		public function setMutateProbability(n:Number):void {
		  if ((n < 0) || (n > 1)) {
			  throw new ArgumentError("bad probability given (" + n + ").  Should be between 0 and 1");
		  }
		  _mutateProb = n;
		}
		
		/**
		 * set whether to use crossover in generating new individuals
		 * @param	c
		 */
		public function useCrossover(c:Boolean):void {
			_crossover = true;
		}
		
		/**
		 * set how many parents to use for crossover - should be <= number of crossover points +1
		 * @param	n
		 */
		public function setCrossoverNumParents(n:int):void {
			if (n < 1) {
				throw new ArgumentError("bad number of parents given (" + n + ").  Must be at least 1");
			}
			_crossoverNumParents = n;
		}
		
		/**
		 * set number of crossover points
		 * @param	n
		 */
		public function setCrossoverNumPoints(n:int):void {
			if (n < 0) {
				throw new ArgumentError("bad number of crossover points given (" + n + "). Must be non-negative");
			}
			_crossoverNumPoints = n;
		}
		
		/**
		 * set EvolvableFactory to use to create new Evolvables
		 * @param	fac
		 */
		public function setFactory(fac:EvolvableFactory):void {
			factory = fac;
		}
		
		/**
		 * main work method.  Calls to this will change the population array.
		 */
		public function nextGeneration():void
		{
			switch (_selectionMode) {
				case ROULETTE : 
					nextGenerationRoulette();
					break;
				case TOURNAMENT :
					nextGenerationTournament();
					break;
			}
		}
		
		private function nextGenerationRoulette():void {
			//sort population by fitness
			population.sort(compareFitness);
			//trace("sorted pop: " + population.join("\n"));
			var fitnessTotal:Number = 0;
			for (var i:int = 0; i < population.length; i++) {
				//trace("fitTotal. poplength:" + population.length + " i:" + i);
				fitnessTotal += population[i].getFitness();
			}
			var matingPool:Array = new Array(population.length); //of Number, representing normalized accumlated fitness
			var last:Number = 0;
			for (i = 0; i < population.length; i++) {
				matingPool[i] = population[i].getFitness() / fitnessTotal + last;
				last = matingPool[i];
			}
			//trace("fitnessTotal: " + fitnessTotal);
			//trace("matingPool: " + matingPool);
			//for each member of new population, choose parents by fitness weighted random choice
			var newPop:Array = new Array(); //of new Evolvables
			var r:Number;
			var rand:Function = Math.random;
			var parents:Array; //of Genome
			var genome:Genome;
			for (i = 0; i < population.length - numNewPerGeneration; i++) {
				if (_crossover) {
					parents = new Array(); //of Genome
					for (var j:int = 0; j < _crossoverNumParents; j++) {
						r = rand();
						var selectedIdx:int = selectParentIndex(matingPool, r);
						//trace("selectedParent: " + population[selectedIdx]);
						//trace("selectedParent idx: " + selectedIdx+", r:"+r);
						parents.push(population[selectedIdx].getGenome());
					}
					genome = parents[0].crossover(parents, _crossoverNumPoints);
				}else {
					genome = population[selectParentIndex(matingPool, rand())].clone();
				}
				if (_mutate) {
					genome = genome.mutate(_mutateProb);
				}
				//use factory to create new Evolvable from new Genome
				newPop.push(factory.makeEvolvable(genome));
			}
			for (i = 0; i < numNewPerGeneration; i++) {
				newPop.push(factory.makeRandomEvolvable());
			}
			
			//if using carryover, replace random member with fittest members from prev. generation.
			for (i = 0; i < _carryOverNum; i++)
			{
				//trace("preserving: " + population[i]);
				//newPop[Math.floor(rand() * newPop.length)] = population[i];
				newPop[i] = population[i];
			}
			replacePopulation(newPop);
		}
		
		private function nextGenerationTournament():void
		{
			var rand:Function = Math.random;
			var matingPool:Array = new Array(population.length); //of Evolvable, filled by tournament selection
			var i:int;
			var e1:Evolvable;
			var e2:Evolvable;
			for (i = 0; i < population.length; i++)
			{
				//pick two at random, compare, put fitter in matingPool
				e1 = population[Math.floor(rand() * population.length)];
				e2 = population[Math.floor(rand() * population.length)];
				//trace("comparing " + e1 + " \n to: " + e2);
				if (e1 == e2) //if picked the same, shortcut possibly expensive evaluation
				{
					matingPool[i] = e1;
				}else
				{
					if (_tournamentComparator.compareFitness(e1, e2) <= 0)
					{
						matingPool[i] = e1;
					}else
					{
						matingPool[i] = e2;
					}
				}
				//trace("selected " + matingPool[i]);
			}
			//trace("matingPool: " + matingPool);
			//for each member of new population, choose parents by random choice
			var newPop:Array = new Array(); //of new Evolvables
			var r:Number;
			var parents:Array; //of Genome
			var genome:Genome;
			for (i = 0; i < population.length - numNewPerGeneration; i++) {
				if (_crossover) {
					parents = new Array(); //of Genome
					for (var j:int = 0; j < _crossoverNumParents; j++) {
						r = rand();
						var selectedIdx:int = Math.floor(rand() * matingPool.length);
						//trace("selectedParent: " + population[selectedIdx]);
						//trace("selectedParent idx: " + selectedIdx+", r:"+r);
						parents.push(matingPool[selectedIdx].getGenome());
					}
					genome = parents[0].crossover(parents, _crossoverNumPoints);
				}else {
					genome = matingPool[Math.floor(rand()*matingPool.length)].clone();
				}
				if (_mutate) {
					genome = genome.mutate(_mutateProb);
				}
				//use factory to create new Evolvable from new Genome
				newPop.push(factory.makeEvolvable(genome));
			}
			for (i = 0; i < numNewPerGeneration; i++) {
				newPop.push(factory.makeRandomEvolvable());
			}
			
			//tournament doesn't use carryover
			replacePopulation(newPop);
			
		}
		
		/**
		 * return the average fitness of the population.
		 * This may be an EXPENSIVE operation if getFitness is expensive
		 * @return
		 */
		public function getAvgPopFitness():Number
		{
			var tot:Number = 0;
			for (var i:int = 0; i < population.length; i++)
			{
				tot += population[i].getFitness();
			}
			return (tot / population.length);
		}

		/**
		 * how many of the fittest of previous generation to put in new pop.  Not used in TOURNAMENT selection
		 * @param	n
		 */
		public function setCarryOverNum(n:int):void
		{
			_carryOverNum = n;
		}
		
		/**
		 * set selectionMode to ROULETTE or TOURNAMENT
		 * @param	s
		 */
		public function setSelectionMode(s:int):void
		{
			if ((s != ROULETTE) && (s != TOURNAMENT))
			{
				throw new ArgumentError("illegal selection mode.  Use ROULETTE or TOURNAMENT");
			}
			_selectionMode = s; 
		}
		
		/**
		 * set EvolvableCOmparator to use during TOURNAMENT selection
		 * @param	e
		 */
		public function setTournamentComparator(e:EvolvableComparator):void
		{
			_tournamentComparator = e;
		}
		
		/**
		 * set number of new random individuals per generation.  1 or 0 usually.
		 * @param	n
		 */
		public function setNumNewPerGeneration(n:int):void
		{
			if (n > popSize)
			{
				throw new ArgumentError("can't have more new per generation than generation size");
			}
			numNewPerGeneration = n;
		}
		
		/**
		 * performs a binary search on pool to find the index of the value which is closest to (but not less than) n
		 * @param	pool array of Number representing normalized accumulated fitness
		 * @param	n Number 0-1
		 */
		private function selectParentIndex(pool:Array, n:Number):int {
			//trace("selectParentIndex.  pool:" + pool + ", n:" + n);
			var low:int = 0;
			var high:int = pool.length -1;
			var mid:int;
			if (pool[0] > n)
			{
				return 0;
			}
			while (low < high -1) {
				mid = (low + high) / 2;
				//trace("low: "+low+", high: "+high+", mid: " + mid);
				if (pool[mid] > n) {
					high = mid;
				}else if (pool[mid] < n) {
					low = mid;
				}else {
					//trace("returning " + mid);
					return mid;
				}
			}
			if (high < 0)
			{
				high = 0; //does this bias the 0th to be more likely?
			}
			//trace("returning high: " + high);
			return high; //instead of -1 for not found, return high (because it's now <= low)
		}
		
		/**
		 * Used both in ROULETTE and as default EvolvableComparator function for TOURNAMENT selection
		 * @param	a
		 * @param	b
		 * @return
		 */
		public function compareFitness(a:Evolvable, b:Evolvable):int {
			var diff:Number = b.getFitness() - a.getFitness();
			if (diff < 0) {
				return -1;
			}else if (diff > 0) {
				return 1;
			}
			return 0;
		}
		
	}
	
}