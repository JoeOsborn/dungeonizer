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
		private var _sketchingClip:Shape;
		private var _map:Map;
		public function DrawingCanvas(map:Map)
		{
			
			_pointBuffer = new Array();
			_drawing = false;
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
			
		}
		public function handleMouseUp(ev:MouseEvent) : void {
			_pointBuffer.push(new Point(ev.localX, ev.localY));
			_drawing = false;
			finishShape();
		}
		public function handleMouseMove(ev:MouseEvent) : void {
			if(_drawing){
				_pointBuffer.push(new Point(ev.localX, ev.localY));
				drawBufferShape();
			}
		}
		
		private function drawBufferShape() : void {
			_sketchingClip.graphics.clear();
			_sketchingClip.graphics.moveTo(_pointBuffer[0].x, _pointBuffer[0].y);
			_sketchingClip.graphics.lineStyle(2,0xFFFFFF,1.0);
			_sketchingClip.graphics.beginFill(0xFFFFFF,1.0);
			for(var i:int = 1; i < _pointBuffer.length; i++){
				_sketchingClip.graphics.lineTo(_pointBuffer[i].x,_pointBuffer[i].y);
			}
			_sketchingClip.graphics.endFill();
		}
		
		private function finishShape() : void {
			updateMap(_sketchingClip);
			//removeChild(_sketchingClip);
			_sketchingClip = new Shape();
			addChild(_sketchingClip);
			_pointBuffer = new Array();
		}
		
		private function updateMap(mapClip:Shape) : void {
			var boundingRect:Rectangle = mapClip.getBounds(this);
			for(var i:int = boundingRect.x-10; i< boundingRect.x+boundingRect.width+10;i+=10){
				for(var j:int = boundingRect.y-10; j< boundingRect.y+boundingRect.height+10; j+=10){
					if(mapClip.hitTestPoint(i+5,j+5,true)){
						_map.setCellAtXY(_map.FLOOR,int(i/10),int(j/10));
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

	}
}