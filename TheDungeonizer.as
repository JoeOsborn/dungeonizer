package
{
	import flash.display.Sprite;
  import com.dungeonizer.Dungeon;
	public class TheDungeonizer extends Sprite
	{
	  public var dungeon : Dungeon;
		public function TheDungeonizer()
		{
			super();
			dungeon = new Dungeon();
			dungeon.setupEntityTest();
		}
		
	}
}