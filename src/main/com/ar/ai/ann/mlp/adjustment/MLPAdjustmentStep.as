package com.ar.ai.ann.mlp.adjustment
{
	import com.ar.ai.ann.mlp.IMLPAdjustment;

	/**
	 * Based on the great java mlp version by Davide Gessa.
	 *
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class MLPAdjustmentStep implements IMLPAdjustment
	{
		/**
		 * Creates a new instance of MLPAdjustmentStep.
		 */
		public function MLPAdjustmentStep()
		{
		}

		/**
		 * @inheritDoc
		 */
		public function modify( value:Number ):Number
		{
			return ( value >= 0.0 ) ? 1.0 : 0.0;
		}

		/**
		 * @inheritDoc
		 */
		public function derivative( value:Number ):Number
		{
			return 1.0;
		}

		/**
		 * Creates and returns a string representation of the MLPAdjustmentStep object.
		 */
		public function toString():String
		{
			return "[MLPAdjustmentStep]";
		}
	}
}
