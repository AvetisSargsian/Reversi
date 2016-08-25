package game.view
{
	import mvc.view.AbstractView;
	
	import starling.display.Button;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.text.TextFormat;
	import starling.utils.Align;
	import starling.utils.Color;
	
	public class MenuSettingsPanel extends AbstractView
	{
		public static const P1_COLOR:String = "P1COLOR";
		public static const P2_COLOR:String = "P2COLOR";
		public static const COMP_BTN:String = "COMP_BTN";
			
		public function MenuSettingsPanel()
		{
			super();
			this.onAddedToStage = onAdded;
		}
		
		private function onAdded():void
		{
			var btn:Button = new Button(assetManager.getTexture("stone"));
			btn.name = P1_COLOR;
			btn.y = 80;
			btn.x = 80;
			addChild(btn);
			
			btn = new Button(assetManager.getTexture("stone"));
			btn.name = P2_COLOR;
			btn.x = Constants.CECLL_SIZE*2 + 80;
			btn.y = 80;
			btn.alpha = 0.7;
			addChild(btn);
			
			var txtFormat:TextFormat = new TextFormat("Verdana",30,Color.YELLOW);
			var txt:TextField = new TextField(50,50,"?");
			txt.format = txtFormat;
			txt.x = Constants.CECLL_SIZE + 80;
			txt.y = 80;
			addChild(txt);
			
			txt = new TextField(0,50,"Computer Opponent");//("Verdana",20,Color.YELLOW);
			txtFormat.verticalAlign = Align.CENTER
			txtFormat.size = 20;
			txt.format = txtFormat;
			txt.autoSize = TextFieldAutoSize.HORIZONTAL;
			addChild(txt);
			
			btn = new Button(assetManager.getTexture("button_small"));
			btn.text = "OFF";
			btn.name = COMP_BTN;
			btn.x = 220;
			addChild(btn);
			
			this.x = Constants.STAGE_WIDTH/2;
			this.y = Constants.STAGE_HEIGHT - Constants.CECLL_SIZE*2.5;
			alignPivot();
		}
	}
}