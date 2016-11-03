package com.ar.ai.ga
{
	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class GAIndividual
	{
		public static var defaultNumGenes:int = 64;

		public var fitness:int = 0;

		private var _genes:Vector.<GAGene>;

		public static function createWithRandomGenes():GAIndividual
		{
			const individual:GAIndividual = new GAIndividual();

			individual.randomize();

			return individual;
		}

		public function GAIndividual()
		{
			_genes = new Vector.<GAGene>( defaultNumGenes );
		}

		internal function randomize():void
		{
			const n:int = _genes.length;

			for( var i:int = 0; i < n; ++i )
			{
				_genes[i] = GAGene.createRandom();
			}
		}

		internal function getGene( index:int ):GAGene
		{
			return _genes[ index ];
		}

		internal function setGene( index:int, gene:GAGene ):void
		{
			_genes[ index ] = gene;

			fitness = 0;
		}

		internal function get numGenes():int
		{
			return _genes.length;
		}

		internal function info():String
		{
			var str:String = "";

			for( var i:int = 0; i < _genes.length; ++i )
			{
				str += _genes[ i ].value;
			}

			return str;
		}

		public function toString():String
		{
			return "[GAIndividual genes:" + info() + "]";
		}
	}
}