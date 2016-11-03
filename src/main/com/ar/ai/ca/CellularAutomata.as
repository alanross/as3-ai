package com.ar.ai.ca
{
	import com.ar.core.log.Context;
	import com.ar.core.log.Log;

	import flash.display.BitmapData;
	import flash.geom.Point;

	/**
	 * http://mathworld.wolfram.com/ElementaryCellularAutomaton.html
	 *
	 * @author Alan Ross
	 * @version 0.1
	 */
	public class CellularAutomata
	{
		private const zero: Point = new Point();

		private var _output:BitmapData;
		private var _width:int;
		private var _height:int;

		public function CellularAutomata( output:BitmapData ):void
		{
			_output = output;

			_width = _output.width;
			_height = _output.height;
		}

		public function generate( rule:int ):void
		{
			// Create rule table. 000, 001, 010, 011, 100, 101, 110, 111
			var table:Array = new Array( 8 );

			var n:int = table.length;

			for( var i:int = 0; i < n; ++i )
			{
				table[i] = ( ( rule >> i ) & 1 ) ? 1 : 0;
			}

			// first generation pixel, the seed.
			_output.fillRect( _output.rect, 0 );
			_output.setPixel( Math.round( _width / 2 ), 0, 1 );

			for( var y:int = 1; y < _height; ++y )
			{
				for( var x:int = 1; x < _width; ++x )
				{
					// output of the last generation, values are either 0 or 1
					var l:int = _output.getPixel( x - 1, y - 1 );
					var c:int = _output.getPixel( x, y - 1 );
					var r:int = _output.getPixel( x + 1, y - 1 );

					// using bit shift to replace long if else
					// if( l == 0 && c == 0 && r == 0 ) -> table[0];
					// if( l == 0 && c == 0 && r == 1 )  -> table[1];
					// if( l == 0 && c == 1 && r == 0 )  -> table[2];
					// if( l == 0 && c == 1 && r == 1 )  -> table[3];
					// ...

					var index:int = l << 2 | c << 1 | r;

					// only setting 1 or 0 as value, palette map will map 0 and 1 to real colors
					_output.setPixel( x, y, table[ index ] );
				}
			}

			// map 0 and 1 to real black and white
			_output.paletteMap( _output, _output.rect, zero, [], [], [0xFFFFFF, 0x000000] );

			Log.info( Context.DEFAULT, this, "Rule:" + rule + " [" + table.reverse().join( " " ) + "]" );
		}

		public function get output():BitmapData
		{
			return _output;
		}

		public function toString():String
		{
			return "[CellularAutomata]";
		}
	}
}