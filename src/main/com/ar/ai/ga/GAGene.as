package com.ar.ai.ga
{
	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public final class GAGene
	{
		public static const T:int = 1;
		public static const F:int = 0;

		private var _value:int;

		public static function createRandom():GAGene
		{
			return new GAGene( ( Math.random() >= 0.5 ? T : F ) );
		}

		public static function createFromChar( c:String ):GAGene
		{
			return new GAGene( ( c.charAt( 0 ) == "1" ) ? T : F );
		}

		public static function createSequenceFromString( genes:String ):Vector.<GAGene>
		{
			const result:Vector.<GAGene> = new Vector.<GAGene>( genes.length );

			for( var i:int = 0; i < genes.length; ++i )
			{
				result[i] = createFromChar( genes.charAt( i ) );
			}

			return result;
		}

		public function GAGene( value:int )
		{
			if( value != T && value != F )
			{
				throw new Error( this + " Could not recognize gene value." );
			}

			_value = value;
		}

		public function get value():int
		{
			return _value;
		}

		public function toString():String
		{
			return "[GAGene value:" + _value + "]";
		}
	}
}