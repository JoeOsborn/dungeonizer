package com.dungeonizer
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class DrawingCanvas extends Sprite
	{
		public const WIDTH:int = 800;
		public const HEIGHT:int = 600;
		private var _pointBuffer:Array;
		private var _drawing:Boolean;
		private var _erasing:Boolean;
		private var _sketchingClip:Shape;
		private var _map:Map;
		public function DrawingCanvas(map:Map)
		{
			
			_pointBuffer = new Array();
			_drawing = false;
			_erasing = false;
			_sketchingClip = new Shape();
			
			_map = map;
			
			/*addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
			addEventListener(MouseEvent.MOUSE_MOVE,handleMouseMove);
			addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);*/
			
			graphics.beginFill(0x333333,1.0);
			graphics.lineTo(WIDTH,0);
			graphics.lineTo(WIDTH,HEIGHT);
			graphics.lineTo(0,HEIGHT);
			
			addChild(_sketchingClip);
			this.cacheAsBitmap = true;
			
			
		}
		
		public function handleMouseDown(ev:MouseEvent) : void {
			_pointBuffer.push(new Point(ev.localX, ev.localY));
			_drawing = true;
			if(ev.shiftKey){
				_erasing = true;
			} else {
				_erasing = false;
			}
			
		}
		public function handleMouseUp(ev:MouseEvent) : void {
			_pointBuffer.push(new Point(ev.localX, ev.localY));
			_drawing = false;
			drawBufferShape(_erasing,true);
			finishShape(_erasing);
		}
		public function handleMouseMove(ev:MouseEvent) : void {
			if(_drawing){
				_pointBuffer.push(new Point(ev.localX, ev.localY));
				drawBufferShape(_erasing,false);
			}
		}
		
		private function drawBufferShape(erase:Boolean, finish:Boolean) : void {
			_sketchingClip.graphics.clear();
			_sketchingClip.graphics.moveTo(_pointBuffer[0].x, _pointBuffer[0].y);
			if(erase){
				if(finish){
					_sketchingClip.graphics.lineStyle(1,0x333333,1.0);
					_sketchingClip.graphics.beginFill(0x333333,1.0);
				} else {
					_sketchingClip.graphics.lineStyle(2,0x000000,1.0);
					_sketchingClip.graphics.beginFill(0x333333,1.0);
				}
			} else {
				if(finish){
					_sketchingClip.graphics.lineStyle(1,0xFFFFFF,1.0);
					_sketchingClip.graphics.beginFill(0xFFFFFF,1.0);
				} else {
					_sketchingClip.graphics.lineStyle(2,0x000000,1.0);	
				}
			}
			for(var i:int = 1; i < _pointBuffer.length; i++){
				_sketchingClip.graphics.lineTo(_pointBuffer[i].x,_pointBuffer[i].y);
			}
			_sketchingClip.graphics.endFill();
		}
		
		private function finishShape(erase:Boolean) : void {
			updateMap(_sketchingClip, erase);
			//removeChild(_sketchingClip);
			_sketchingClip = new Shape();
			addChild(_sketchingClip);
			_pointBuffer = new Array();
		}
		
		private function updateMap(mapClip:Shape, erase:Boolean) : void {
		  var tr : Number = Dungeon.TILE_RATIO;
			var boundingRect:Rectangle = mapClip.getBounds(this);
			for(var i:int = boundingRect.x; i<= boundingRect.x+boundingRect.width;i+=tr){
				for(var j:int = boundingRect.y; j<= boundingRect.y+boundingRect.height; j+=tr){
					if(mapClip.hitTestPoint(i,j,true)){
						if(erase){
							_map.setCellAtXY(_map.WALL,int(i/tr),int(j/tr));
						} else {
							_map.setCellAtXY(_map.FLOOR,int(i/tr),int(j/tr));
						}
					}
				}
			}
		}
		
		public function get map():Map{
			return _map;
		}
		
		public function set map(newMap:Map) : void {
			_map = newMap;
		}

		public function drawMapState(): void{
		  var tr : Number = Dungeon.TILE_RATIO;
			var mapShape:Shape = new Shape();
			for(var i:int=0; i < map.WIDTH; i++){
				for(var j:int = 0; j < map.HEIGHT; j++){
					if(map.cellAtXY(i,j) == map.FLOOR){
						mapShape.graphics.lineStyle(1,0xffffff,1);
						mapShape.graphics.moveTo(i*tr,j*tr);
						mapShape.graphics.beginFill(0xFFFFFF,1);
						mapShape.graphics.lineTo(i*tr+tr,j*tr);
						mapShape.graphics.lineTo(i*tr+tr,j*tr+tr);
						mapShape.graphics.lineTo(i*tr,j*tr+tr);
						mapShape.graphics.lineTo(i*tr,j*tr);
					}
				}
			}
			addChild(mapShape);
			
		}
	}
}