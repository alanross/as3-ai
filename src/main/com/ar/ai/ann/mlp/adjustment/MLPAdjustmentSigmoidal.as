package com.ar.ai.ann.mlp.adjustment
{
	import com.ar.ai.ann.mlp.IMLPAdjustment;

	/**
	 * Based on the great java mlp version by Davide Gessa.
	 *
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class MLPAdjustmentSigmoidal implements IMLPAdjustment
	{
		/**
		 * Creates a new instance of MLPAdjustmentSigmoidal.
		 */
		public function MLPAdjustmentSigmoidal()
		{
		}

		/**
		 * @inheritDoc
		 */
		public function modify( value:Number ):Number
		{
			return 1.0 / ( 1.0 + Math.pow( Math.E, -value ) );
		}

		/**
		 * @inheritDoc
		 */
		public function derivative( value:Number ):Number
		{
			return ( value - Math.pow( value, 2 ) );
		}

		/**
		 * Creates and returns a string representation of the MLPAdjustmentSigmoidal object.
		 */
		public function toString():String
		{
			return "[MLPAdjustmentSigmoidal]";
		}
	}
}

