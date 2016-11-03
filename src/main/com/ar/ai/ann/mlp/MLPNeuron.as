package com.ar.ai.ann.mlp
{

	/**
	 * Based on the great java mlp version by Davide Gessa.
	 *
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class MLPNeuron
	{
		private static var SCALE:Number = 10000000000000.0;

		public var value:Number;
		public var bias:Number;
		public var error:Number;
		public var weights:Vector.<Number>;

		/**
		 * Creates a new instance of MLPNeuron.
		 */
		public function MLPNeuron( prevLayerNeuronCount:int )
		{
			bias = Math.random() / SCALE;
			error = Math.random() / SCALE;
			value = Math.random() / SCALE;

			weights = new Vector.<Number>( prevLayerNeuronCount, true );

			for( var i:int = 0; i < weights.length; i++ )
			{
				weights[i] = Math.random() / SCALE;
			}
		}

		/**
		 *
		 */
		public function getInfo():String
		{
			var info:String = "";

			info += "\n\t\value: " + value;
			info += ",\n\bias: " + bias;
			info += ",\n\delta: " + error;
			info += ",\n\tweights: {" + weights.join( "," ) + "}";

			return "[MLPNeuron " + info + " ]";
		}

		/**
		 * Creates and returns a string representation of the MLPNeuron object.
		 */
		public function toString():String
		{
			return "[MLPNeuron]";
		}
	}
}