package game.view.mediators
{
	import game.controller.GameController;
	import game.view.ButtonsPanel;
	
	import mvc.mediator.AbstractMediator;
	import mvc.view.BaseView;
	
	import navigation.controller.NavigationController;
	
	import starling.display.Button;
	import starling.events.Event;
	
	public class ButtonsPanelMediator extends AbstractMediator
	{	
		public function ButtonsPanelMediator(thisVeiw:BaseView = null)
		{
			super(thisVeiw);
			
			nativeVIew.addEventListener(Event.TRIGGERED,onButtonPushed);
		}
		
		override public function dispose():void
		{
			nativeVIew.removeEventListener(Event.TRIGGERED,onButtonPushed);
			super.dispose();
		}
		
		override protected function setNativeVIew():BaseView
		{
			return new ButtonsPanel();
		}
		
		private function onButtonPushed(event:Event):void
		{
			var name:String = (event.target as Button).name;
			switch(name)
			{
				case ButtonsPanel.NEW_GAME:
				{
					GameController.instance.restartGame();
					break;
				}
				case ButtonsPanel.MAIN_MENU:
				{	
					NavigationController.instance.changeScene(Constants.MAIN_MENU_SCENE);
					break;
				}
			}
			event.stopImmediatePropagation();
		}	
	}
}