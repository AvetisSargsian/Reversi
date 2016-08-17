package menu
{
	import mvc.view.Scene;
	
	import starling.display.Button;
	
	public class MainMenuScene extends Scene
	{
		public static const START_GAME:String = "START GAME"; 
		public function MainMenuScene()
		{
			super();
			this.onAddedToStage = onAdded;
		}
		
		private function onAdded():void
		{	
			var btn:Button = new Button(assetManager.getTexture("button"));
			btn.text = 	START_GAME;
			btn.name = START_GAME;
			btn.alignPivot();
			btn.x = Constants.STAGE_WIDTH/2;
			btn.y = Constants.STAGE_HEIGHT/2;
			addChild(btn);
		}
	}
}