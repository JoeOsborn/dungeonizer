package
{
	import com.dungeonizer.Dungeon;
	import com.dungeonizer.DungeonViewer;
	
	import flash.display.Sprite;

	public class TheDungeonizer extends Sprite
	{
		public var dungeon : Dungeon;
		private var dungeonViewer : DungeonViewer;
		public function TheDungeonizer()
		{
			super();
			dungeon = new Dungeon();
			dungeon.setupEntityTest();
			dungeonViewer = new DungeonViewer(dungeon);
			addChild(dungeonViewer);
		}
		
	}
}