package
{
	import mx.containers.Canvas;
	import mx.core.UIComponent;
  
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