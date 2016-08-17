package mvc.mediator
{
	import flash.ui.Keyboard;
	
	import mvc.view.AbstractView;
	import mvc.view.Scene;
	
	import starling.events.KeyboardEvent;
	
	public class SceneMediator extends AbstractMediator
	{
		public function SceneMediator()
		{
			super();
			nativeVIew.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
		}
		
		override public function dispose():void
		{
			nativeVIew.removeEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			super.dispose();
		}
		
		override protected function setNativeVIew():AbstractView
		{
			return new Scene();
		}
		
		protected function onKeyboardBACK():void {}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.ESCAPE:
				case Keyboard.BACK:
					onKeyboardBACK();
					event.preventDefault();
					break;
				default:
					break;
			}
		}
	}
}