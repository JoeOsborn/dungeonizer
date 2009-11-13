package
{
	import mx.containers.Canvas;
	import mx.core.UIComponent;
	public class FlexDungeonizer extends Canvas
	{
	  private var dungeonizer : TheDungeonizer;
	  private var dgComponent : UIComponent;
		public function FlexDungeonizer()
		{
			super();
			dungeonizer = new TheDungeonizer();
			dgComponent = new UIComponent();
			dgComponent.addChild(dungeonizer);
			addChild(dgComponent);
		}
	}
}