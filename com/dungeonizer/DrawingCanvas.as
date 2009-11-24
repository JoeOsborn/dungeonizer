package com.dungeonizer
{
	import flash.display.MovieClip;
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
		private var _dungeon:Dungeon;
		private var _dungeonViewer:DungeonViewer;
		private var _map:Map;
		private var _ui:DrawingCanvasUI;
		
		
		public function DrawingCanvas(dungeon:Dungeon, viewer:DungeonViewer)
		{
			
			_pointBuffer = new Array();
			_drawing = false;
			_erasing = false;
			_sketchingClip = new Shape();
			
			_dungeon = dungeon;
			_dungeonViewer = viewer;
			_map = dungeon.map;
			
			_ui = new DrawingCanvasUI();
			_ui.x = WIDTH/2 - _ui.width/2;
			_ui.y = HEIGHT + 20;
			addChild(_ui);
			
			
			graphics.beginFill(0x333333,1.0);
			graphics.lineTo(WIDTH,0);
			graphics.lineTo(WIDTH,HEIGHT);
			graphics.lineTo(0,HEIGHT);
			
			addChild(_sketchingClip);
			this.cacheAsBitmap = true;
			
		}
		
		public function handleMouseDown(ev:MouseEvent) : void {
			if(ev.localY > HEIGHT){
				_ui.handleMouseDown(ev);
			} else {
				addBufferPoint(ev.localX, ev.localY);
				_drawing = true;
			}
			
		}
		public function handleMouseUp(ev:MouseEvent) : void {
			if(_drawing){
				addBufferPoint(ev.localX, ev.localY);
				_drawing = false;
				if(_ui.activePallet == DrawingCanvasUI.FLOOR){
					drawFloorShape();
					updateMap(_sketchingClip, false);
					finishShape();				
				} else if(_ui.activePallet == DrawingCanvasUI.WALL){
					drawWallShape();
					updateMap(_sketchingClip, true);
					finishShape();
				} else if(_ui.activePallet == DrawingCanvasUI.MONSTER){
					addMonster();
					_sketchingClip.graphics.clear();
					finishShape();
				} else if(_ui.activePallet == DrawingCanvasUI.PRINCESS){
					addPrincess();
					_sketchingClip.graphics.clear();
					finishShape();
				} else {
					drawColorShape(getColor());
					finishShape();
				}
			}
		}
		
		public function handleMouseMove(ev:MouseEvent) : void {
			if(_drawing){
				addBufferPoint(ev.localX, ev.localY);
				if(_ui.activePallet == DrawingCanvasUI.FLOOR){
					drawColorShape(0x000000);
				} else if(_ui.activePallet == DrawingCanvasUI.WALL){
					drawColorShape(0x000000);
				} else {
					drawColorShape(getColor());
				}
			}
		}
		
		private function addBufferPoint(px,py){
			
			if(px > WIDTH){
				px = WIDTH;
			} else if(px < 0){
				px = 0;
			}
			
			if(py > HEIGHT){
				py = HEIGHT;
			} else if(py < 0){
				py = 0;
			}
			//trace("adding point: "+px+" "+py);
			_pointBuffer.push(new Point(px,py));
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
		
		private function drawFloorShape(){
			_sketchingClip.graphics.clear();
			_sketchingClip.graphics.moveTo(_pointBuffer[0].x, _pointBuffer[0].y);
			_sketchingClip.graphics.lineStyle(1,0xFFFFFF,1.0);
			_sketchingClip.graphics.beginFill(0xFFFFFF,1.0);
			drawShape();
			_sketchingClip.graphics.endFill()
		}
		
		private function drawWallShape(){
			_sketchingClip.graphics.clear();
			_sketchingClip.graphics.moveTo(_pointBuffer[0].x, _pointBuffer[0].y);
			_sketchingClip.graphics.lineStyle(1,0x333333,1.0);
			_sketchingClip.graphics.beginFill(0x333333,1.0);
			drawShape();
			_sketchingClip.graphics.endFill()
		}
		
		private function drawColorShape(color:uint){
			_sketchingClip.graphics.clear();
			_sketchingClip.graphics.lineStyle(2,color,1);
			_sketchingClip.graphics.moveTo(_pointBuffer[0].x, _pointBuffer[0].y);
			drawShape();
		}
		
		private function finishShape() : void {
			_sketchingClip = new Shape();
			addChild(_sketchingClip);
			_pointBuffer = new Array();
		}
		
		
		private function drawShape(){
			for(var i:int = 1; i < _pointBuffer.length; i++){
				_sketchingClip.graphics.lineTo(_pointBuffer[i].x,_pointBuffer[i].y);
			}
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
			for(var i:int=0; i < Map.WIDTH; i++){
				for(var j:int = 0; j < Map.HEIGHT; j++){
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
		
		private function getColor():uint{
			var ret = 0x000000;
			if(_ui.activePallet == DrawingCanvasUI.BLACK){
				ret = 0x000000;
			} else if (_ui.activePallet == DrawingCanvasUI.BLUE){
				ret = 0x000099;
			} else if (_ui.activePallet == DrawingCanvasUI.RED){
				ret = 0x990000;
			}  else if (_ui.activePallet == DrawingCanvasUI.GREEN){
				ret = 0x009900;
			}
			return ret;
		}
		
		private function addMonster(){
			
			var boundingRect:Rectangle = _sketchingClip.getBounds(this);
			var cellWidth = WIDTH / Map.WIDTH;
			var cellHeight = HEIGHT / Map.HEIGHT;
			
			var size = int((boundingRect.width/cellWidth + boundingRect.height / cellHeight) / 4);
			var mx = int((boundingRect.x + boundingRect.width/2) / cellWidth);
			var my = int((boundingRect.y + boundingRect.height/2) / cellHeight);
			if(size > 12){
				size = 12;
			}
			var monster:Monster = new Monster(_dungeon.map,mx,my,size);
			_dungeon.addMonster(monster);
			var viewerClip:MovieClip = new MonsterClip();
			viewerClip.scaleX *= size;
			viewerClip.scaleY *= size;
			var viewer:EntityViewer = new EntityViewer(monster,viewerClip);
			_dungeonViewer.addEntityViewer(viewer);
			
		}
		
		private function addPrincess(){
			var boundingRect:Rectangle = _sketchingClip.getBounds(this);
			var cellWidth = WIDTH / Map.WIDTH;
			var cellHeight = HEIGHT / Map.HEIGHT;
			
			var size = int((boundingRect.width/cellWidth + boundingRect.height / cellHeight) / 4);
			var mx = int((boundingRect.x + boundingRect.width/2) / cellWidth);
			var my = int((boundingRect.y + boundingRect.height/2) / cellHeight);
			if(size > 12){
				size = 12;
			}
			var princess:Princess = new Princess(_dungeon.map,mx,my,size);
			_dungeon.addEntity(princess);
			var viewerClip:MovieClip = new PrincessClip();
			viewerClip.scaleX *= size;
			viewerClip.scaleY *= size;
			var viewer:EntityViewer = new EntityViewer(princess,viewerClip);
			_dungeonViewer.addEntityViewer(viewer);
		}
	}
}