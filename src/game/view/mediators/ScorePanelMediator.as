package game.view.mediators
{
	import game.model.GameModel;
	import game.view.ScorePanel;
	
	import mvc.mediator.AbstractMediator;
	import mvc.view.AbstractView;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.text.TextField;
	
	public class ScorePanelMediator extends AbstractMediator
	{
		private var turnImg:Image;
		private var p1Score:TextField;
		private var p2Score:TextField;
		private var gameModel:GameModel;
		public function ScorePanelMediator(thisView:AbstractView=null)
		{
			super(thisView);
			nativeVIew.addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			
			gameModel = GameModel.instance;
			gameModel.registerCallBack(GameModel.SWAP_PLAYER,onSwapPlaer);
			gameModel.registerCallBack(GameModel.NEW_SCORE,onNewScore);
		}
		
		override public function dispose():void
		{
			gameModel.removeCallBack(GameModel.SWAP_PLAYER,onSwapPlaer);
			gameModel.removeCallBack(GameModel.NEW_SCORE,onNewScore);
			gameModel = null;
			turnImg = null;
			p1Score = null;
			p2Score = null;
			super.dispose();
		}
		
		override protected function setNativeVIew():AbstractView
		{
			return new ScorePanel();
		}
		
		private function onAddedToStage(event:Event):void
		{
			nativeVIew.removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			turnImg = nativeVIew.getChildByName(ScorePanel.PLAY_TURN) as Image;
			onSwapPlaer();
			p1Score = nativeVIew.getChildByName(ScorePanel.PLAYER1_SCORE) as TextField;
			p2Score = nativeVIew.getChildByName(ScorePanel.PLAYER2_SCORE) as TextField;
		}
		
		private function onSwapPlaer():void
		{
			turnImg.color = gameModel.nextPlayerColor();
		}
		
		private function onNewScore():void
		{
			p1Score.text = gameModel.player1Score.toString();
			p2Score.text = gameModel.player2Score.toString();
		}
	}
}