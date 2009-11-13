package
{
	import com.dungeonizer.DrawingCanvas;
	import com.dungeonizer.Dungeon;
	import com.dungeonizer.DungeonViewer;
	
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
      stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
      stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
		}
    public function keyDownHandler(e : KeyboardEvent) : void
    {
      if(e.keyCode == 37)
      {
        dungeon.player.velocity.x = -1;
      }
      else if(e.keyCode == 38) 
      {
        dungeon.player.velocity.y = -1;
      }
      else if(e.keyCode == 39)
      {
        dungeon.player.velocity.x = 1;
      }
      else if(e.keyCode == 40)
      {
        dungeon.player.velocity.y = 1;
      }
    }
    public function keyUpHandler(e : KeyboardEvent) : void
    {
      if(e.keyCode == 37)
      {
        dungeon.player.velocity.x = 0;
      }
      else if(e.keyCode == 38) 
      {
        dungeon.player.velocity.y = 0;
      }
      else if(e.keyCode == 39)
      {
        dungeon.player.velocity.x = 0;
      }
      else if(e.keyCode == 40)
      {
        dungeon.player.velocity.y = 0;
      }
    }		
	}
}