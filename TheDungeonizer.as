package
{
	import flash.display.Sprite;
  import com.dungeonizer.Map;
	public class TheDungeonizer extends Sprite
	{
	  public var map : Map;
		public function TheDungeonizer()
		{
			super();
			map = new Map();
			map.setupEntityTest();
		}
		
	}
}