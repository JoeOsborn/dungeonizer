package
{
	import com.dungeonizer.DrawingCanvas;
	import com.dungeonizer.Dungeon;
	import com.dungeonizer.DungeonViewer;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.*;

	public class TheDungeonizer extends Sprite
	{
		public var dungeon : Dungeon;
		private var dungeonViewer : DungeonViewer;
		private var drawingCanvas:DrawingCanvas;
		private var touchArea:Sprite;
		public function TheDungeonizer()
		{
			super();
			dungeon = new Dungeon();
			dungeon.setupEntityTest();
			drawingCanvas = new DrawingCanvas(dungeon.map);
			addChild(drawingCanvas);
			drawingCanvas.drawMapState();
			dungeonViewer = new DungeonViewer(dungeon);
			addChild(dungeonViewer);
			
			touchArea = new Sprite();
			initTouchArea(touchArea);
			touchArea.addEventListener(MouseEvent.MOUSE_DOWN,drawingCanvas.handleMouseDown);
			touchArea.addEventListener(MouseEvent.MOUSE_MOVE,drawingCanvas.handleMouseMove);
			touchArea.addEventListener(MouseEvent.MOUSE_UP,drawingCanvas.handleMouseUp);
			addChild(touchArea);
			
  		addEventListener(flash.events.Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		public function addedToStageHandler(e : Event) : void
		{
		  //trace("added");
      stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
      stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
		}
    public function keyDownHandler(e : KeyboardEvent) : void
    {
    	//trace(e.keyCode);
      if(e.keyCode == 37)
      {
        dungeon.player.movement["left"] = true;
      }
      else if(e.keyCode == 38) 
      {
        dungeon.player.movement["up"] = true;
      }
      else if(e.keyCode == 39)
      {
        dungeon.player.movement["right"] = true;
      }
      else if(e.keyCode == 40)
      {
        dungeon.player.movement["down"] = true;
      }
      else if(e.keyCode == 32)
      {
      	if(dungeonViewer.showGrid){
      		dungeonViewer.showGrid = false;
      	} else {
      		dungeonViewer.showGrid = true;
      	}
      }
    }
    public function keyUpHandler(e : KeyboardEvent) : void
    {
      if(e.keyCode == 37)
      {
        dungeon.player.movement["left"] = false;
      }
      else if(e.keyCode == 38) 
      {
        dungeon.player.movement["up"] = false;
      }
      else if(e.keyCode == 39)
      {
        dungeon.player.movement["right"] = false;
      }
      else if(e.keyCode == 40)
      {
        dungeon.player.movement["down"] = false;
      }
    }
    
    private function initTouchArea(area:Sprite){
    	area.graphics.lineStyle(1,0x000000,0);
    	area.graphics.beginFill(0x000000,0);
    	area.graphics.lineTo(stage.stageWidth,0);
    	area.graphics.lineTo(stage.stageWidth,stage.stageHeight);
    	area.graphics.lineTo(0,stage.stageHeight);
    	area.graphics.lineTo(0,0);
    }
    
    private function handleMouseDown(ev:MouseEvent){
    	//trace("badger");
    	drawingCanvas.handleMouseDown(ev);
    }
    private function handleMouseMove(ev:MouseEvent){
    	drawingCanvas.handleMouseMove(ev);
    }
    private function handleMouseUp(ev:MouseEvent){
    	drawingCanvas.handleMouseUp(ev);
    }
 }	
}