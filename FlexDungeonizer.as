package
{
	import mx.containers.Canvas;
	import com.dungeonizer.Dungeon;
	public class FlexDungeonizer extends Canvas
	{
	  public var dungeon : Dungeon;
		public function FlexDungeonizer()
		{
			super();
			dungeon = new Dungeon();
			dungeon.setupEntityTest();
		}
		
	}
}