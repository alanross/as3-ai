package com.ar.ai.ann.mlp
{
	/**
	 * Based on the great java mlp version by Davide Gessa.
	 *
	 * @author Alan Ross
	 * @version 0.1
	 */
	public interface IMLPAdjustment
	{
		/**
		 *
		 */
		function modify( value:Number ):Number;

		/**
		 *
		 */
		function derivative( value:Number ):Number;
	}
}