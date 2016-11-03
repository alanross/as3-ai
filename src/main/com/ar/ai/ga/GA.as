package com.ar.ai.ga
{
	/**
	 * Based on the genetic algorithm by Lee Jacobson, http://www.theprojectspot.com
	 *
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class GA
	{
		private var _solution:GASolution;

		private var _tournamentSize:int;
		private var _uniformity:Number;
		private var _mutation:Number;
		private var _elitism:Boolean;

		public function GA( solution:GASolution, uniformity:Number = 0.4, mutation:Number = 0.01, tournamentSize:int = 10, elitism:Boolean = false )
		{
			_solution = solution;
			_uniformity = uniformity;
			_mutation = mutation;
			_tournamentSize = tournamentSize;
			_elitism = elitism;
		}

		private function mutation( individual:GAIndividual ):void
		{
			for( var i:int = 0; i < individual.numGenes; ++i )
			{
				if( Math.random() <= _mutation )
				{
					individual.setGene( i, GAGene.createRandom() );
				}
			}
		}

		private function crossover( a:GAIndividual, b:GAIndividual ):GAIndividual
		{
			var c:GAIndividual = new GAIndividual();

			for( var i:int = 0; i < a.numGenes; ++i )
			{
				// use gene from the one or the other parent
				c.setGene( i, ( ( Math.random() <= _uniformity ) ? a.getGene( i ) : b.getGene( i ) ) );
			}

			return c;
		}

		private function parentSelection( population:GAPopulation ):GAIndividual
		{
			var tournament:GAPopulation = new GAPopulation( _tournamentSize );

			for( var i:int = 0; i < _tournamentSize; ++i )
			{
				tournament.setIndividual( i, population.getRandomIndividual() );
			}

			return tournament.findFittest();
		}

		private function setFitness( individual:GAIndividual ):void
		{
			individual.fitness = _solution.determineFitness( individual );
		}

		public function evolve( population:GAPopulation ):GAPopulation
		{
			var newPopulation:GAPopulation = new GAPopulation( population.numIndividuals );

			var offset:int = 0;

			if( _elitism )
			{
				// keep best of last population individual
				newPopulation.setIndividual( 0, population.findFittest() );

				setFitness( newPopulation.getIndividual( 0 ) );

				offset = 1;
			}

			for( var i:int = offset; i < population.numIndividuals; ++i )
			{
				var parentA:GAIndividual = parentSelection( population );
				var parentB:GAIndividual = parentSelection( population );

				// create cross overs from two parents
				newPopulation.setIndividual( i, crossover( parentA, parentB ) );

				// mutate population
				mutation( newPopulation.getIndividual( i ) );

				// calculate fitness
				setFitness( newPopulation.getIndividual( i ) );
			}

			return newPopulation;
		}

		public function hasSolution( population:GAPopulation ):GAIndividual
		{
			var individual:GAIndividual = population.findFittest();

			return ( individual.fitness < _solution.getMaxFitness() ? null : individual );
		}

		public function getFittest( population:GAPopulation ):GAIndividual
		{
			return population.findFittest();
		}

		public function toString():String
		{
			return "[GeneticAlgorithm]";
		}
	}
}