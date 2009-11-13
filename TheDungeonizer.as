package
{
	import com.dungeonizer.Map;
	import com.dungeonizer.MapViewer;
	
	import flash.display.Sprite;
	import com.dungeonizer.Dungeon;
	public class TheDungeonizer extends Sprite
	{
		public var mapViewer : MapViewer;
		public var dungeon : Dungeon;
		public function TheDungeonizer()
		{
			super();
			dungeon = new Dungeon();
			dungeon.setupEntityTest();
			mapViewer = new MapViewer();
			
			addChild(mapViewer);
			mapViewer.displayMap(dungeon.map);
		}
		
	}
}