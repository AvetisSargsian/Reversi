package menu.mediator
{
	import game.controller.GameController;
	import game.model.GameModel;
	import menu.MenuSettingsPanel;
	
	import mvc.mediator.AbstractMediator;
	import mvc.view.BaseView;
	
	import starling.display.Button;
	import starling.events.Event;
	
	public class MenuSettingsPanelMediator extends AbstractMediator
	{
		private var gameModel:GameModel;
		private var btn1:Button;
		private var btn2:Button;
		private var btn3:Button;
		
		public function MenuSettingsPanelMediator(thisView:BaseView=null)
		{
			super(thisView);
			nativeVIew.addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			nativeVIew.addEventListener(Event.TRIGGERED,onBtnTriger);
			gameModel = GameModel.instance;
		}
		
		override public function dispose():void
		{
			gameModel = null;
			btn1 = null;
			btn2 = null;
			btn3 = null;
			
			super.dispose();
		}
		
		override protected function setNativeVIew():BaseView
		{
			return new MenuSettingsPanel();
		}
		
		private function onBtnTriger(event:Event):void
		{
			var btn:Button = event.target as Button; 
			if (btn == btn1 && btn1.alpha == 0.7)
			{
				GameController.instance.swapStoneColors();
				btn1.alpha = 1;
				btn2.alpha = 0.7;
			}
			else if (btn == btn2 && btn2.alpha == 0.7)
			{
				GameController.instance.swapStoneColors();
				btn1.alpha = 0.7;
				btn2.alpha = 1;	
			}
			else if(btn == btn3)
			{
				btn3.text = gameModel.isOpponentComputer ? "OFF" : "ON";
				GameController.instance.compOppSwitcher(!gameModel.isOpponentComputer);
			}
			event.stopImmediatePropagation();
		}
		
		private function onAddedToStage():void
		{
			nativeVIew.removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			
			btn1 = nativeVIew.getChildByName(MenuSettingsPanel.P1_COLOR) as Button;
			btn1.color = gameModel.stone1Color;
			btn2 = nativeVIew.getChildByName(MenuSettingsPanel.P2_COLOR) as Button;
			btn2.color = gameModel.stone2Color;
			btn3 = nativeVIew.getChildByName(MenuSettingsPanel.COMP_BTN) as Button;
			btn3.text = gameModel.isOpponentComputer ? "ON" : "OFF";
		}
	}
}