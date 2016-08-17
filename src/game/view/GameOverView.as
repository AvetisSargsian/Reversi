package game.view
{
	import mvc.view.AbstractView;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.text.TextField;
	import starling.utils.Color;
	
	public class GameOverView extends AbstractView
	{
		public static const PLAYER_STONE:String = "playTurn";
		public static const WIN_TXT:String = "WIN_TXT";
		
		public function GameOverView()
		{
			super();
			this.onAddedToStage = onAdded;
		}
		
		private function onAdded():void
		{
			this.onAddedToStage = null;
			
			this.x = (Constants.STAGE_WIDTH - Constants.CECLL_SIZE * Constants.FIELD_SIZE)/2; 
			
			var fielsdSide:Number = Constants.FIELD_SIZE * Constants.CECLL_SIZE;
			var bg:Quad = new Quad(fielsdSide,fielsdSide);
			bg.color = Color.GRAY;
			addChild(bg);
			
			var img:Image = new Image(assetManager.getTexture("stone"));
			img.x = img.y = fielsdSide/2 ;
			img.alignPivot();
			img.name = PLAYER_STONE;
			addChild(img);
			
			var text:TextField = new TextField(250, 100,"WIN","Verdana",30);
			text.x = img.x
			text.y = img.y + 60;
			text.name = WIN_TXT;
			text.alignPivot();
			addChild(text);
		}
	}
}