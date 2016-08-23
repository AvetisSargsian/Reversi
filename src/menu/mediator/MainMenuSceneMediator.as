package menu.mediator
{
	import game.view.mediators.MenuSettingsPanelMediator;
	
	import menu.MainMenuScene;
	
	import mvc.mediator.IMediator;
	import mvc.mediator.SceneMediator;
	import mvc.view.AbstractView;
	
	import navigation.controller.NavigationController;
	
	import starling.display.Button;
	import starling.events.Event;
	
	public class MainMenuSceneMediator extends SceneMediator
	{
		private var pickColorMediator:IMediator;
		
		public function MainMenuSceneMediator()
		{
			super();
			nativeVIew.addEventListener(Event.TRIGGERED, mainMenuClickEvent);
			nativeVIew.addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		override public function dispose():void
		{
			nativeVIew.removeEventListener(Event.TRIGGERED, mainMenuClickEvent);
			pickColorMediator = null;
			super.dispose();
		}
		
		override protected function setNativeVIew():AbstractView
		{
			return new MainMenuScene();
		}
		
		override protected function onKeyboardBACK():void {}
		
		
		private function onAddedToStage():void
		{
			nativeVIew.removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			
			pickColorMediator = new MenuSettingsPanelMediator();
			pickColorMediator.addToParent(nativeVIew);
		}
		
		
		private function mainMenuClickEvent(event:Event):void
		{
			var name:String = (event.target as Button).name;
			switch(name)
			{
				case MainMenuScene.START_GAME:
					NavigationController.instance.changeScene(Constants.GAME_SCENE);
					break;
			}
		}
	}
}