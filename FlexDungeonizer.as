package
{
	import mx.containers.Canvas;
	import mx.core.UIComponent;
  import com.dungeonizer.Dungeon;
  import com.dungeonizer.MapViewer;
  
	public class FlexDungeonizer extends Canvas
	{
	  public var dungeon : Dungeon;
	  private var mvComponent : UIComponent;
	  private var mapViewer : MapViewer;
		public function FlexDungeonizer()
		{
			super();
			dungeon = new Dungeon();
			dungeon.setupEntityTest();
			mapViewer = new MapViewer();
			mapViewer.displayMap(dungeon.map);
      mvComponent = new UIComponent();
      mvComponent.addChild(mapViewer);
      this.addChild(mvComponent);
		}
	}
}