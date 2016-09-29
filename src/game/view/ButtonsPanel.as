package game.view
{
	import mvc.view.BaseView;
	
	import starling.display.Button;
	
	public class ButtonsPanel extends BaseView
	{
		public static const MAIN_MENU:String = "MAIN_MENU";
		public static const NEW_GAME:String = "NEW_GAME";
		
		public function ButtonsPanel()
		{
			super();
			this.onAddedToStage = onAdded; 
		}
		
		private function onAdded():void
		{
			this.onAddedToStage = null;
			
			var newWaveBtn:Button = new Button(assetManager.getTexture("button_small"));
			newWaveBtn.text = NEW_GAME; 
			newWaveBtn.name = NEW_GAME;
			addChild(newWaveBtn);
			
			var pouseGameBtn:Button = new Button(assetManager.getTexture("button_small"));
			pouseGameBtn.text = MAIN_MENU;
			pouseGameBtn.name = MAIN_MENU;
			pouseGameBtn.x = newWaveBtn.x + 100 + 15;
			addChild(pouseGameBtn);
		}
	}
}