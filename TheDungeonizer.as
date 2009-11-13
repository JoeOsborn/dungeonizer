package
{
	import com.dungeonizer.DrawingCanvas;
	import com.dungeonizer.Dungeon;
	import com.dungeonizer.DungeonViewer;
  import flash.events.*;
	
	import flash.display.Sprite;

	public class TheDungeonizer extends Sprite
	{
		public var dungeon : Dungeon;
		private var dungeonViewer : DungeonViewer;
		private var drawingCanvas:DrawingCanvas;
		public function TheDungeonizer()
		{
			super();
			dungeon = new Dungeon();
			dungeon.setupEntityTest();
			dungeonViewer = new DungeonViewer(dungeon);
			addChild(dungeonViewer);
			drawingCanvas = new DrawingCanvas(dungeon.map);
			addChild(drawingCanvas);
  		addEventListener(flash.events.Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		public function addedToStageHandler(e : Event) : void
		{
		  trace("added");
      stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
      stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
		}
    public function keyDownHandler(e : KeyboardEvent) : void
    {
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
	}
}