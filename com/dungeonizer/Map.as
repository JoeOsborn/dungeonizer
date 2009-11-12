package com.dungeonizer
{
	import flash.utils.ByteArray;
	
	public class Map
	{
		public const WIDTH:int = 80;
		public const HEIGHT:int = 60;
		
		public const WALL:uint = 0;
		public cosnt FLOOR:uint = 1;
		
		
		protected var _cells:Array;
		
		public function Map()
		{
			_cells = new Array(WIDTH*HEIGHT);
			
			for(var i:int = 0; i < _cells.length; i++){
				_cells[i] = WALL;
			}
		
		}
		
		
		

	}
}