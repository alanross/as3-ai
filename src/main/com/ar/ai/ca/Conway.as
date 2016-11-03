package com.ar.ai.ca
{
	import com.ar.math.Maths;

	import flash.display.BitmapData;
	import flash.geom.Point;

	/**
	 * @author Alan Ross
	 * @version 0.1
	 */
	public class Conway
	{
		private static const LIVE:int = 0x0000000;
		private static const DEAD:int = 0xFFFFFFFF;

		private const zero:Point = new Point();
		private const offsets:Vector.<Offset> = new Vector.<Offset>;

		private var _thisGenMap:BitmapData;
		private var _nextGenMap:BitmapData;

		private var _width:int;
		private var _height:int;

		private var _genCount:int; // number of generations

		/**
		 * Creates a new instance of Conway.
		 */
		public function Conway( map:BitmapData )
		{
			_width = map.width;
			_height = map.height;

			_nextGenMap = new BitmapData( _width, _height, false, DEAD );
			_thisGenMap = new BitmapData( _width, _height, false, DEAD );
			_thisGenMap.copyPixels( map, map.rect, zero );

			// table of neighbours defined by their relative offsets to current cell
			offsets.push( new Offset( -1, -1 ) );
			offsets.push( new Offset( -1, 0 ) );
			offsets.push( new Offset( -1, 1 ) );
			offsets.push( new Offset( 0, -1 ) );
			offsets.push( new Offset( 0, 1 ) );
			offsets.push( new Offset( 1, -1 ) );
			offsets.push( new Offset( 1, 0 ) );
			offsets.push( new Offset( 1, 1 ) );
		}

		/**
		 * Process the next generation of cells.
		 */
		public function iterate():void
		{
			_genCount++;

			for( var y:int = 1; y <= _height; y++ )
			{
				for( var x:int = 1; x <= _width; x++ )
				{
					var neighbors:int = 0;

					const n:int = offsets.length;

					for( var i:int = 0; i < n; ++i )
					{
						var p:Offset = offsets[i];
						var nx:int = x + p.x;
						var ny:int = y + p.y;

						if( nx < 1 || nx >= _width || ny < 1 || ny >= _height )
						{
							continue;
						}

						if( ( _thisGenMap.getPixel( nx, ny ) == LIVE ) )
						{
							neighbors++;
						}
					}

					// rules http://en.wikipedia.org/wiki/Conway's_Game_of_Life:
					// 1) Under-population: A cell with less than two neighbours dies.
					// 2) Overcrowding: A cell with more than three live neighbours dies.
					// 3) Reproduction: A dead cell with exactly three live neighbours becomes a live cell.
					// 4) A cell with two or three live neighbours lives on to the next generation.

					if( ( _thisGenMap.getPixel( x, y ) == LIVE ) )
					{
						if( neighbors < 2 || neighbors > 3 )
						{
							_nextGenMap.setPixel( x, y, DEAD );
						}
						else
						{
							_nextGenMap.setPixel( x, y, LIVE );
						}
					}
					else
					{
						if( neighbors == 3 )
						{
							_nextGenMap.setPixel( x, y, LIVE );
						}
					}
				}
			}

			_thisGenMap.copyPixels( _nextGenMap, _nextGenMap.rect, zero );

			// clear the map for next time around
			_nextGenMap.fillRect( _nextGenMap.rect, DEAD );
		}

		/**
		 * Paint a block shape
		 */
		public function paintBlock( x:int, y:int ):void
		{
			x = Maths.clamp( x, 1, _width - 2 );
			y = Maths.clamp( y, 1, _height - 2 );

			_nextGenMap.setPixel( x, y, LIVE );
			_nextGenMap.setPixel( x + 1, y, LIVE );
			_nextGenMap.setPixel( x, y + 1, LIVE );
			_nextGenMap.setPixel( x + 1, y + 1, LIVE );
		}

		/**
		 * Paint a block shape
		 */
		public function paintGlider( x:int, y:int ):void
		{
			x = Maths.clamp( x, 1, _width - 4 );
			y = Maths.clamp( y, 1, _height - 4 );

			_nextGenMap.setPixel( x, y, LIVE );
			_nextGenMap.setPixel( x + 2, y, LIVE );

			_nextGenMap.setPixel( x, y + 1, LIVE );
			_nextGenMap.setPixel( x + 3, y + 1, LIVE );

			_nextGenMap.setPixel( x + 1, y + 2, LIVE );
			_nextGenMap.setPixel( x + 2, y + 2, LIVE );
		}

		/**
		 * Create a random map
		 */
		public function random():void
		{
			_nextGenMap.perlinNoise( 10, 10, 3, Math.random() * 1000, true, false, 7, true );
			_nextGenMap.threshold( _nextGenMap, _nextGenMap.rect, zero, "<=", 0xFF666666, 0xFF000000, 0xFFFFFFFF, false );
			_nextGenMap.threshold( _nextGenMap, _nextGenMap.rect, zero, ">", 0xFF000000, 0xFFFFFFFF, 0xFFFFFFFF, false );
		}

		/**
		 * The map containing all current, alive cells
		 */
		public function get map():BitmapData
		{
			return _thisGenMap;
		}

		/**
		 * Creates and returns a string representation of the Conway object.
		 */
		public function toString():String
		{
			return "[Conway]";
		}
	}
}

class Offset
{
	public var x:int;
	public var y:int;

	public function Offset( x:int, y:int )
	{
		this.x = x;
		this.y = y;
	}
}

