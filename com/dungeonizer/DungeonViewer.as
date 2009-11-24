package com.dungeonizer
{
  import flash.display.MovieClip;
  import flash.events.TimerEvent;
  import flash.utils.Timer;
	public class DungeonViewer extends MovieClip
	{
	  private var dungeon : Dungeon;
	  private var timer : Timer;
	  public var showGrid : Boolean;
		public function DungeonViewer(d : Dungeon)
		{
			super();
			dungeon = d;
			timer = new Timer(1000.0/30.0);
			timer.addEventListener(TimerEvent.TIMER, timerHandler);
			
			showGrid = false;
      timer.start();
		}
		
		public function timerHandler(e : TimerEvent) : void
		{
		  graphics.clear();
		  
		  if(showGrid){
		  	displayMap();
		  }
		  displayEntities();
		}
		
		public function displayMap() : void 
		{
			//graphics.lineStyle(1,0x333333,1);
		  var tr : Number = Dungeon.TILE_RATIO;
			var map : Map = dungeon.map;
			for(var i:int = 0; i < Map.WIDTH; i++)
			{
				for(var j:int = 0; j < Map.HEIGHT; j++)
				{
					var nx:Number = i*tr;
					var ny:Number = j*tr;
					graphics.moveTo(nx,ny);
					if(map.cellAtXY(i,j) == map.FLOOR)
					{
						graphics.beginFill(0xFFFFFF,0.3);
					} 
					else 
					{
						graphics.beginFill(0x333333,0.3);
					}
					graphics.lineTo(nx+9,ny);
					graphics.lineTo(nx+9,ny+9);
					graphics.lineTo(nx,ny+9);
				}
			}
		}
		public function displayEntities() : void 
		{
		  var tr : Number = Dungeon.TILE_RATIO;
			graphics.lineStyle(1,0xEE3333,1);
			for each (var e : Entity in dungeon.entities)
			{
			  var nx : Number = (e.x) * tr;
			  var ny : Number = (e.y) * tr;
			  var ns : Number = e.size * tr;
			  graphics.beginFill(0xEE3333,1);
			  graphics.drawCircle(nx, ny, ns);
			  graphics.endFill();
			  var m : Monster = e as Monster;
			  if(m != null)
			  {
  			  graphics.drawCircle(nx, ny, m.sightRadius*tr);
			  }
			}
		}
	}
}