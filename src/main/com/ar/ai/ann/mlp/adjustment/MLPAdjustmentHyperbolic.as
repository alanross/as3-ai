package com.ar.ai.ann.mlp.adjustment
{
	import com.ar.ai.ann.mlp.IMLPAdjustment;

	/**
	 * http://www.math10.com/en/algebra/hyperbolic-functions/hyperbolic-functions.html
	 *
	 * Based on the great java mlp version by Davide Gessa.
	 *
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class MLPAdjustmentHyperbolic implements IMLPAdjustment
	{
		/**
		 * Creates a new instance of MLPAdjustmentHyperbolic.
		 */
		public function MLPAdjustmentHyperbolic()
		{
		}

		/**
		 * @inheritDoc
		 */
		public function modify( value:Number ):Number
		{
			// tanh
			var a:Number = Math.exp( value );
			var b:Number = Math.exp( -value );

			return ( ( a - b ) / 2.0 ) / ( ( a + b ) / 2.0 );
		}

		/**
		 * @inheritDoc
		 */
		public function derivative( value:Number ):Number
		{
			return 1 - Math.pow( value, 2 );
		}

		/**
		 * Creates and returns a string representation of the MLPAdjustmentHyperbolic object.
		 */
		public function toString():String
		{
			return "[MLPAdjustmentHyperbolic]";
		}
	}
}
