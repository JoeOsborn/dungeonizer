package
{
	import mx.containers.Canvas;
	import mx.core.UIComponent;
  import com.dungeonizer.Dungeon;
  import com.dungeonizer.DungeonViewer;
  
	public class FlexDungeonizer extends Canvas
	{
	  private var dungeonizer : TheDungeonizer;
		public function FlexDungeonizer()
		{
			super();
			dungeonizer = new TheDungeonizer();
			var dgComp = new UIComponent();
			dgComp.addChild(dungeonizer);
			addChild(dgComp);
		}
	}
}