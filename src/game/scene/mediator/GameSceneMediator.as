package game.scene.mediator
{
	import game.controller.GameController;
	import game.view.mediators.ButtonsPanelMediator;
	import game.view.mediators.GameOverViewMediator;
	import game.view.mediators.PlayFieldViewMediator;
	import game.view.mediators.ScorePanelMediator;
	
	import mvc.mediator.IMediator;
	import mvc.mediator.SceneMediator;
	
	import navigation.controller.NavigationController;
	
	import starling.events.Event;
	
	public class GameSceneMediator extends SceneMediator
	{	
		private var playFieldMediator:IMediator;
		private var btnPanelMediator:IMediator;
		private var scorePanelMediator:IMediator;
		private var gameOverMediator:IMediator;
		
		public function GameSceneMediator()
		{
			super();
			
			nativeVIew.addEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		
		override public function dispose():void
		{
			nativeVIew.removeEventListener(Event.ADDED_TO_STAGE,onAdded);
			
			playFieldMediator.dispose();
			playFieldMediator = null;
			btnPanelMediator.dispose();
			btnPanelMediator = null;
			scorePanelMediator.dispose();
			scorePanelMediator = null;
			gameOverMediator.dispose();
			gameOverMediator = null;
			
			super.dispose();
		}
		
		override protected function onKeyboardBACK():void
		{
			NavigationController.instance.changeScene(Constants.MAIN_MENU_SCENE);
		}
		
		private function onAdded():void
		{
			nativeVIew.removeEventListener(Event.ADDED_TO_STAGE,onAdded);
			
			playFieldMediator = new PlayFieldViewMediator();
			playFieldMediator.addToParent(nativeVIew);
			
			scorePanelMediator = new ScorePanelMediator();
			scorePanelMediator.addToParent(nativeVIew);
			scorePanelMediator.nativeVIew.x = playFieldMediator.nativeVIew.x;
			scorePanelMediator.nativeVIew.y = playFieldMediator.nativeVIew.y + Constants.CECLL_SIZE*Constants.FIELD_SIZE + 3;
			
			btnPanelMediator = new ButtonsPanelMediator();
			btnPanelMediator.addToParent(nativeVIew);
			btnPanelMediator.nativeVIew.y = Constants.STAGE_HEIGHT - btnPanelMediator.nativeVIew.height;
			btnPanelMediator.nativeVIew.x = playFieldMediator.nativeVIew.x + btnPanelMediator.nativeVIew.width/2;
			
			gameOverMediator = new GameOverViewMediator();
			gameOverMediator.addToParent(nativeVIew);
			
			GameController.instance.restartGame();
		}
	}
}