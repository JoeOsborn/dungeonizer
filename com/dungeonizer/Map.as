package com.dungeonizer
{
	public class Map
	{
		public const WIDTH:int = 160;
		public const HEIGHT:int = 120;
		
		public const WALL:uint = 0;
		public const FLOOR:uint = 1;
		
		protected var _cells:Array;
		
		public function Map()
		{
			_cells = new Array(WIDTH*HEIGHT);
			
			for(var i:int = 0; i < _cells.length; i++)
			{
				_cells[i] = WALL;
			}
		}
		public function cellAt(idx:uint) : uint 
		{
		  if(idx < 0 || idx >= WIDTH*HEIGHT) { return WALL; }
		  return _cells[idx];
		}
		public function setCellAt(cell:uint, idx:uint) : void 
		{
		  if(idx < 0 || idx >= WIDTH*HEIGHT) { return; }
		  _cells[idx] = cell;
		}
		public function outOfBounds(cx:int, cy:int) : Boolean
		{
		  return cx < 0 || cx >= WIDTH || cy < 0 || cy >= HEIGHT;
		}
		public function cellAtXY(cx:int, cy:int) : uint 
		{
		  if(outOfBounds(cx, cy)) 
		  {
		    return WALL;
		  }
		  return cellAt(cy*WIDTH+cx);
		}
		public function setCellAtXY(cell : uint, cx : int, cy : int) : void 
		{
		  if(outOfBounds(cx, cy)) 
		  {
		    return;
		  }
		  setCellAt(cell, cy*WIDTH+cx);
		}
		
		//test fixture functions
		public function setBox(cell : uint, bx : int, by : int, bw : int, bh : int) : void
		{
		  for(var i : int = bx; i < bx + bw; i++) 
		  {
		    for(var j : int = by; j < by + bh; j++) 
		    {
		      setCellAtXY(cell, i, j);
		    }
		  }
		}
	}
}