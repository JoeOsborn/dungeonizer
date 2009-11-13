package com.dungeonizer
{
  import flash.utils.Timer;
  import flash.events.TimerEvent;
  import flash.events.KeyboardEvent;
	import flash.display.MovieClip;
	public class DungeonViewer extends MovieClip
	{
	  private var dungeon : Dungeon;
	  private var timer : Timer;
		public function DungeonViewer(d : Dungeon)
		{
			super();
			dungeon = d;
			timer = new Timer(1000.0/30.0);
			timer.addEventListener(TimerEvent.TIMER, timerHandler);
      timer.start();
		}
		
		public function timerHandler(e : TimerEvent) : void
		{
		  graphics.clear();
		  
		  displayMap();
		  displayEntities();
		}
		
		public function displayMap() : void 
		{
			//graphics.lineStyle(1,0x333333,1);
			var map : Map = dungeon.map;
			for(var i:int = 0; i < map.WIDTH; i++)
			{
				for(var j:int = 0; j < map.HEIGHT; j++)
				{
					var nx:Number = i*10;
					var ny:Number = j*10;
					graphics.moveTo(nx,ny);
					if(map.cellAtXY(i,j) == map.FLOOR)
					{
						graphics.beginFill(0xFFFFFF,1);
					} 
					else 
					{
						graphics.beginFill(0x333333,1);
					}
					graphics.lineTo(nx+9,ny);
					graphics.lineTo(nx+9,ny+9);
					graphics.lineTo(nx,ny+9);
				}
			}
		}
		public function displayEntities() : void 
		{
			graphics.lineStyle(1,0xEE3333,1);
			for each (var e : Entity in dungeon.entities)
			{
			  var nx : Number = (e.x) * 10;
			  var ny : Number = (e.y) * 10;
			  var ns : Number = e.size * 10;
			  graphics.beginFill(0xEE3333,1);
			  graphics.drawCircle(nx, ny, ns);
			  graphics.endFill();
			  var m : Monster = e as Monster;
			  if(m != null)
			  {
  			  graphics.drawCircle(nx, ny, m.sightRadius*10);
			  }
			}
		}
	}
}