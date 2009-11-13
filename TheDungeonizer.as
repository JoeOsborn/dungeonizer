package
{
	import com.dungeonizer.Map;
	import com.dungeonizer.MapViewer;
	
	import flash.display.Sprite;
	public class TheDungeonizer extends Sprite
	{
	  public var map : Map;
	  public var mapViewer : MapViewer;
		public function TheDungeonizer()
		{
			super();
			map = new Map();
			map.setupEntityTest();
			mapViewer = new MapViewer();
			
			addChild(mapViewer);
			mapViewer.displayMap(map);
			
		}
		
	}
}