package game.view.mediator
{
	import game.model.GameModel;
	import game.view.GameOverView;
	
	import mvc.mediator.AbstractMediator;
	import mvc.view.AbstractView;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.text.TextField;
	
	public class GameOverViewMediator extends AbstractMediator
	{
		private var gameModel:GameModel;
		private var stone:Image;
		private var text:TextField;
		
		public function GameOverViewMediator(thisView:AbstractView=null)
		{
			super(thisView);
			
			nativeVIew.addEventListener(Event.ADDED_TO_STAGE,onAddedTostage);
			gameModel = GameModel.instance;
			gameModel.registerCallBack(GameModel.GAME_OVER,onGameOver);
			gameModel.registerCallBack(GameModel.NEW_GAME,onNewGame);
		}
	
		override public function dispose():void
		{
			gameModel.removeCallBack(GameModel.GAME_OVER,onGameOver);
			gameModel.removeCallBack(GameModel.NEW_GAME,onNewGame);
			gameModel = null;
			stone = null;
			text = null;
			super.dispose();
		}
		
		override protected function setNativeVIew():AbstractView
		{
			return new GameOverView();
		}
		
		private function onGameOver():void
		{
			nativeVIew.visible = true;
			if (gameModel.player1Score > gameModel.player2Score)
			{
				stone.color = gameModel.stone1Color;
				text.text = "Player 1 Win";
			}else if (gameModel.player1Score == gameModel.player2Score)
			{
				text.text = "DRAW";
				stone.setVertexColor(0,gameModel.stone1Color);
				stone.setVertexColor(1,gameModel.stone1Color);
				stone.setVertexColor(2,gameModel.stone2Color);
				stone.setVertexColor(3,gameModel.stone2Color);
			}else
			{
				text.text = "Player 2 Win";
				stone.color = gameModel.stone2Color;
			}
		}
		
		private function onNewGame():void
		{
			nativeVIew.visible = false;
		}
		
		private function onAddedTostage():void
		{
			nativeVIew.removeEventListener(Event.ADDED_TO_STAGE,onAddedTostage);
			
			stone = nativeVIew.getChildByName(GameOverView.PLAYER_STONE) as Image;
			text = nativeVIew.getChildByName(GameOverView.WIN_TXT) as TextField;
		}
	}
}