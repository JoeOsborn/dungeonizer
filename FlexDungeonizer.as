package
{
	import mx.containers.Canvas;
  import com.dungeonizer.Map;
	public class FlexDungeonizer extends Canvas
	{
	  public var map : Map;
		public function FlexDungeonizer()
		{
			super();
			map = new Map();
			map.setupEntityTest();
		}
		
	}
}