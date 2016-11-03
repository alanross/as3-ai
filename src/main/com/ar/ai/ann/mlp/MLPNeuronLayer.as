package com.ar.ai.ann.mlp
{
	/**
	 * Based on the great java mlp version by Davide Gessa.
	 *
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class MLPNeuronLayer
	{
		private var _neurons:Vector.<MLPNeuron>;

		/**
		 * Creates a new instance of MLPLayer.
		 */
		public function MLPNeuronLayer( numNeurons:int, preLayerNeuronsCount:int )
		{
			_neurons = new Vector.<MLPNeuron>( numNeurons, true );

			for( var i:int = 0; i < numNeurons; ++i )
			{
				_neurons[i] = new MLPNeuron( preLayerNeuronsCount );
			}
		}

		/**
		 *
		 */
		public function getValues():Vector.<Number>
		{
			const n:int = neurons.length;

			const values:Vector.<Number> = new Vector.<Number>( n );

			for( var i:int = 0; i < n; i++ )
			{
				values[i] = neurons[i].value;
			}

			return values;
		}

		/**
		 *
		 */
		public function setValues( values:Vector.<Number> ):void
		{
			const n:int = neurons.length;

			if( n > values.length )
			{
				throw new Error();
			}

			for( var i:int = 0; i < n; ++i )
			{
				neurons[i].value = values[i];
			}
		}

		/**
		 *
		 */
		public function getInfo():String
		{
			var info:String = "";

			info += "\n\count: " + _neurons.length;
			info += ",\n\tneurons: {" + _neurons.join( "," ) + "}";

			return "[MLPNeuronLayer " + info + " ]";
		}

		/**
		 *
		 */
		public function get neurons():Vector.<MLPNeuron>
		{
			return _neurons;
		}

		/**
		 *
		 */
		public function get neuronCount():int
		{
			return _neurons.length;
		}

		/**
		 * Creates and returns a string representation of the MLPLayer object.
		 */
		public function toString():String
		{
			return "[MLPNeuronLayer]";
		}
	}
}