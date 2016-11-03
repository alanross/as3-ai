package com.ar.ai.ga
{
	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class GAPopulation
	{
		private var _individuals:Vector.<GAIndividual>;

		public static function createRandomizedPopulation( numIndividuals:int ):GAPopulation
		{
			var population:GAPopulation = new GAPopulation( numIndividuals );

			population.randomize();

			return population;
		}

		public function GAPopulation( numIndividuals:int )
		{
			_individuals = new Vector.<GAIndividual>( numIndividuals );
		}

		internal function randomize():void
		{
			var n:int = _individuals.length;

			for( var i:int = 0; i < n; ++i )
			{
				_individuals[ i ] = GAIndividual.createWithRandomGenes();
			}
		}

		internal function findFittest():GAIndividual
		{
			var individual:GAIndividual = _individuals[ 0 ];

			for( var i:int = 1; i < _individuals.length; ++i )
			{
				if( individual.fitness <= _individuals[i].fitness )
				{
					individual = _individuals[ i ];
				}
			}

			return individual;
		}

		internal function getIndividual( index:int ):GAIndividual
		{
			return _individuals[ index ];
		}

		internal function getRandomIndividual():GAIndividual
		{
			return _individuals[ Math.floor( Math.random() * _individuals.length ) ];
		}

		internal function setIndividual( index:int, individual:GAIndividual ):void
		{
			_individuals[ index ] = individual;
		}

		internal function get numIndividuals():int
		{
			return _individuals.length;
		}

		public function toString():String
		{
			return "[GAPopulation]";
		}
	}
}