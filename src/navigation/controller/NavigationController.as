package navigation.controller
{
	import game.controller.GameController;
	import game.scene.mediator.GameSceneMediator;
	
	import loading.model.AssetsModel;
	import loading.scene.mediator.LoadingSceneMediator;
	
	import menu.mediator.MainMenuSceneMediator;
	
	import mvc.controller.AbstractController;
	
	import navigation.model.NavigationModel;
	
	import starling.events.Event;
	
	public class NavigationController extends AbstractController
	{
		private static var _instance:NavigationController;
		private var navModel:NavigationModel;
		private var assetsModel:AssetsModel
		
		public function NavigationController(pvt:PrivateClass)
		{
			super();
			navModel = NavigationModel.instance;
			assetsModel = AssetsModel.instance;
			assetsModel.addEventListener(AssetsModel.LOADING_COMPLETE,onLoadingComplete);
			assetsModel.addEventListener(AssetsModel.LOADING_PRECOMPLETE, onLoadingPREComplete);
		}
		
		public static function get instance( ):NavigationController
		{
			if (_instance == null)
				_instance = new NavigationController (new PrivateClass());		
			return _instance;
		}
		
		public function changeScene(sceneDef:String):void
		{
			switch(sceneDef)
			{
				case Constants.FIRST_LOAD:
				{
					navModel.nextSceneMediator = new MainMenuSceneMediator();
					navModel.curentSceneMediator  = new LoadingSceneMediator();
					assetsModel.enqueueAsset("sprite","config.json");
					assetsModel.loadAssets();
					break;
				}
				case Constants.MAIN_MENU_SCENE:
				{
					navModel.nextSceneMediator = new MainMenuSceneMediator();
					onLoadingComplete();
					break;
				}
				case Constants.GAME_SCENE:
				{
					navModel.nextSceneMediator = new GameSceneMediator();
					onLoadingComplete();
					break;
				}
			}
		}
		
		override public function dispose():void
		{
			navModel = null;
			assetsModel.removeEventListener(AssetsModel.LOADING_COMPLETE,onLoadingComplete);
			assetsModel.removeEventListener(AssetsModel.LOADING_PRECOMPLETE, onLoadingPREComplete);
			assetsModel = null;
			super.dispose();
		}
		
		private function loadAssets(...loads):void
		{
			assetsModel.enqueueAsset(loads);
			assetsModel.loadAssets();
		}
		
		/**
		 * called 2 seconds before Loading Complete
		 */		
		private function onLoadingPREComplete(event:Event = null):void
		{
			if(navModel.nextSceneMediator is MainMenuSceneMediator)
			{
				GameController.instance.passDtat(AssetsModel.instance.getJSONObject("config"));
			}	
		}
		
		//TODO:Add change scene animation class after Loading Complete
		private function onLoadingComplete(event:Event = null):void
		{	
			navModel.curentSceneMediator  = navModel.nextSceneMediator;
			navModel.nextSceneMediator = null;
		}
	}
}
class PrivateClass
{
	public function PrivateClass( )	{}
}