package
{
	import com.dungeonizer.DrawingCanvas;
	import com.dungeonizer.Dungeon;
	import com.dungeonizer.MapViewer;
	
	import flash.display.Sprite;
	public class TheDungeonizer extends Sprite
	{
		public var mapViewer : MapViewer;
		public var drawingCanvas : DrawingCanvas;
		public var dungeon : Dungeon;
		public function TheDungeonizer()
		{
			super();
			dungeon = new Dungeon();
			dungeon.setupEntityTest();
			mapViewer = new MapViewer();
			drawingCanvas = new DrawingCanvas();
			
			
			addChild(mapViewer);
			addChild(drawingCanvas);
			mapViewer.displayMap(dungeon.map);
		}
		
	}
}