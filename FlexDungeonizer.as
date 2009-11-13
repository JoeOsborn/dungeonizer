package
{
	import mx.containers.Canvas;
	import mx.core.UIComponent;
  import com.dungeonizer.Dungeon;
  import com.dungeonizer.DungeonViewer;
  
	public class FlexDungeonizer extends Canvas
	{
	  public var dungeon : Dungeon;
	  private var dungeonViewer : DungeonViewer;
	  private var dgComponent : UIComponent;
		public function FlexDungeonizer()
		{
			super();
			dungeon = new Dungeon();
			dungeon.setupEntityTest();
			dungeonViewer = new DungeonViewer(dungeon);
      dgComponent = new UIComponent();
      dgComponent.addChild(dungeonViewer);
      this.addChild(dgComponent);
		}
	}
}