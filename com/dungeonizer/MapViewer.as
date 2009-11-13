package com.dungeonizer
{
	import flash.display.MovieClip;
	public class MapViewer extends MovieClip
	{
		public function MapViewer()
		{
			super();
		}
		
		public function displayMap(map:Map) : void {
			//graphics.lineStyle(1,0x333333,1);
			for(var i:int = 0; i < map.WIDTH; i++){
				for(var j:int = 0; j < map.HEIGHT; j++){
					var nx:Number = i*10;
					var ny:Number = j*10;
					graphics.moveTo(nx,ny);
					if(map.cellAtXY(i,j) == map.FLOOR){
						graphics.beginFill(0xFFFFFF,1);
					} else {
						graphics.beginFill(0x333333,1);
					}
					graphics.lineTo(nx+9,ny);
					graphics.lineTo(nx+9,ny+9);
					graphics.lineTo(nx,ny+9);
				}
			}
			
		}
		
	}
}