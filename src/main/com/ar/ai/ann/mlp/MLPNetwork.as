package com.ar.ai.ann.mlp
{
	/**
	 * Multi-Layer Perceptron using back propagation.
	 *
	 * Based on the great java mlp version by Davide Gessa.
	 *
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class MLPNetwork
	{
		private var _layers:Vector.<MLPNeuronLayer>;
		private var _transfer:IMLPAdjustment;

		public function MLPNetwork( layers:Vector.<int>, transfer:IMLPAdjustment )
		{
			_transfer = transfer;

			_layers = new Vector.<MLPNeuronLayer>( layers.length );

			_layers[0] = new MLPNeuronLayer( layers[0], 0 );

			for( var i:int = 1; i < layers.length; i++ )
			{
				_layers[i] = new MLPNeuronLayer( layers[i], layers[i - 1] );
			}
		}

		/**
		 * Sends a pattern through the network. Returns the values of the output layer neurons.
		 */
		public function process( pattern:Vector.<Number> ):Vector.<Number>
		{
			// copy pattern values to input layer neuron values
			_layers[0].setValues( pattern );

			// process hidden layers and output layer
			for( var l:int = 1; l < _layers.length; l++ )
			{
				var l1:MLPNeuronLayer = _layers[ l ];
				var l2:MLPNeuronLayer = _layers[ l - 1 ];

				for( var i:int = 0; i < l1.neuronCount; i++ )
				{
					var neuron:MLPNeuron = l1.neurons[i];

					var value:Number = 0.0;

					for( var j:int = 0; j < l2.neuronCount; j++ )
					{
						value += neuron.weights[j] * l2.neurons[j].value;
					}

					value += l1.neurons[i].bias;

					l1.neurons[i].value = _transfer.modify( value );
				}
			}

			// copy output layer neuron values and return them as vector
			return _layers[ _layers.length - 1 ].getValues();
		}

		public function learn( input:Vector.<Number>, output:Vector.<Number>, learningRate:Number ):Number
		{
			// try out feed forward.

			return backPropagation( input, output, learningRate );
		}

		private function backPropagation( pattern:Vector.<Number>, expected:Vector.<Number>, learnRate:Number ):Number
		{
			var result:Vector.<Number> = process( pattern );

			var k:int = 0;

			var neurons:Vector.<MLPNeuron> = _layers[ _layers.length - 1 ].neurons;

			for( ; k < neurons.length; ++k )
			{
				neurons[k].error = _transfer.derivative( result[k] ) * ( expected[k] - result[k] /* exp[] - res[] = error */ );
			}

			k = _layers.length - 1;

			while( --k > -1 )
			{
				var l1:MLPNeuronLayer = _layers[ k ];
				var l2:MLPNeuronLayer = _layers[ k + 1 ];

				var i:int;
				var j:int;

				// calculate layer error and adjust delta
				for( i = 0; i < l1.neuronCount; i++ )
				{
					var error:Number = 0.0;

					for( j = 0; j < l2.neuronCount; j++ )
					{
						error += l2.neurons[j].error * l2.neurons[j].weights[i];
					}

					l1.neurons[i].error = _transfer.derivative( l1.neurons[i].value ) * error;
				}

				// update weights of the next layer
				for( i = 0; i < l2.neuronCount; i++ )
				{
					for( j = 0; j < l1.neuronCount; j++ )
					{
						l2.neurons[i].weights[j] += learnRate * l2.neurons[i].error * l1.neurons[j].value;
					}

					l2.neurons[i].bias += learnRate * l2.neurons[i].error;
				}
			}

			return calculateOverallError( result, expected );
		}

		private function calculateOverallError( patternResult:Vector.<Number>, expectedResult:Vector.<Number> ):Number
		{
			var error:Number = 0.0;
			var n:int = expectedResult.length;

			for( var k:int = 0; k < n; ++k )
			{
				error += Math.abs( patternResult[k] - expectedResult[k] );
			}

			return ( error / n );
		}

		/**
		 * Creates and returns a string representation of the MLPNetwork object.
		 */
		public function toString():String
		{
			return "[MultiLayerPerceptron]";
		}
	}
}