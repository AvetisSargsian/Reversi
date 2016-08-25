package game.view
{
	import mvc.view.AbstractView;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.text.TextField;
	import starling.text.TextFormat;
	import starling.utils.Color;
	
	public class ScorePanel extends AbstractView
	{
		public static const PLAY_TURN:String = "playTurn";
		public static const PLAYER1_SCORE:String = "PLAYER1_SCORE";
		public static const PLAYER2_SCORE:String = "PLAYER2_SCORE";
		
		public function ScorePanel()
		{
			super();
			this.onAddedToStage = onAdded;
		}
		
		private function onAdded():void
		{
			this.onAddedToStage = null;
			
			var fielsdSide:Number = Constants.FIELD_SIZE * Constants.CECLL_SIZE;
			var bg:Quad = new Quad(fielsdSide,Constants.STAGE_HEIGHT - fielsdSide);
			bg.color = Color.GRAY;
			addChild(bg);
			
			var turnImg:Image = new Image(assetManager.getTexture("stone"));
			turnImg.x = 3;
			turnImg.y = 3;
			turnImg.name = PLAY_TURN;
			addChild(turnImg);
			
			var player:Image = new Image(assetManager.getTexture("player1"));
			player.color = Color.YELLOW
			player.x = 105;
			player.y = 3;
			addChild(player);
			
			var score:Image = new Image(assetManager.getTexture("open-score_small"));
			score.color = Color.YELLOW;
			score.x = player.x;
			score.y = player.height + 3;
			score.scale = 0.9;
			addChild(score);
			
			player = new Image(assetManager.getTexture("player2"));
			player.color = Color.YELLOW
			player.x = 280;
			player.y = 3;
			
			addChild(player);
			
			score= new Image(assetManager.getTexture("open-score_small"));
			score.color = Color.YELLOW;
			score.x = player.x;
			score.y = player.height + 3;
			score.scale = 0.9;
			addChild(score);
			
			var txtFormat:TextFormat = new TextFormat("Verdana",20,Color.BLACK);
			var scoreTxt:TextField = new TextField(50,50,"0")
			scoreTxt.format = txtFormat; 
			scoreTxt.x = 115;
			scoreTxt.y = score.y +10;
			scoreTxt.name = PLAYER1_SCORE;
			addChild(scoreTxt);
			
			scoreTxt = new TextField(50,50,"0");
			scoreTxt.format = txtFormat;
			scoreTxt.x = 300;
			scoreTxt.y = score.y + 10;
			scoreTxt.name = PLAYER2_SCORE;
			addChild(scoreTxt);
			
			
		}
	}
}