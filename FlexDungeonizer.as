package
{
	import mx.containers.Canvas;
	import mx.core.UIComponent;
  
	public class FlexDungeonizer extends Canvas
	{
		public function FlexDungeonizer()
		{
			super();
			var theDungeonizer:TheDungeonizer = new TheDungeonizer();
      		var dgComponent:UIComponent = new UIComponent();
      		dgComponent.addChild(theDungeonizer);
      		this.addChild(dgComponent);
		}
	}
}