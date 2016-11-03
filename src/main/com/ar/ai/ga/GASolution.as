package com.ar.ai.ga
{
	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class GASolution
	{
		private var _genes:Vector.<GAGene> = new Vector.<GAGene>();

		public static function createFromString( genes:String ):GASolution
		{
			return new GASolution( GAGene.createSequenceFromString( genes ) );
		}

		public function GASolution( genes:Vector.<GAGene> )
		{
			_genes = genes;
		}

		internal function determineFitness( individual:GAIndividual ):int
		{
			var fitness:int = 0;

			for( var i:int = 0; i < individual.numGenes && i < _genes.length; i++ )
			{
				if( individual.getGene( i ).value == _genes[i].value )
				{
					fitness++;
				}
			}

			return fitness;
		}

		internal function getMaxFitness():int
		{
			return _genes.length;
		}

		public function toString():String
		{
			return "[GAFitness]";
		}
	}
}