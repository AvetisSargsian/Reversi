package loading.scene.mediator
{
	import loading.model.AssetsModel;
	import loading.scene.LoadingScene;
	
	import mvc.view.AbstractView;
	import mvc.mediator.SceneMediator;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.utils.Color;
	
	public class LoadingSceneMediator extends SceneMediator
	{
		private var assetsModel:AssetsModel;
		private var pBar:DisplayObject;
		
		public function LoadingSceneMediator()
		{
			super();
			nativeVIew.addEventListener(Event.ADDED_TO_STAGE,onAdded);
			
			assetsModel = AssetsModel.instance;
			assetsModel.registerCallBack(AssetsModel.UPDATE,onModelUpdate);
			assetsModel.registerCallBack(AssetsModel.NO_ASSETS,onNoAssetsToLoad);
		}
		
		private function onAdded():void
		{
			nativeVIew.removeEventListener(Event.ADDED_TO_STAGE,onAdded);
			pBar = nativeVIew.getChildByName(LoadingScene.PROGRESS_BAR_NAME);
		}
		
		override public function dispose():void
		{
			assetsModel.removeCallBack(AssetsModel.UPDATE,onModelUpdate);
			assetsModel.removeCallBack(AssetsModel.NO_ASSETS,onNoAssetsToLoad);
			assetsModel = null;
			pBar = null;
			super.dispose();
		}
		
		override protected function setNativeVIew():AbstractView
		{
			return new LoadingScene();
		}
		
		private function onModelUpdate():void
		{
			var ratio:Number = assetsModel.ratio;
			pBar.scaleX = Math.max(0.0, Math.min(1.0, ratio));
		}
		
		private function onNoAssetsToLoad():void
		{			
			var txtField:TextField = new TextField(145,70,"NO ASSETS TO LOAD","Verdana",45,Color.RED);
			txtField.name = "txtField";
			txtField.x = Constants.STAGE_WIDTH/2;
			txtField.y = pBar.y - txtField.height/2;
			txtField.hAlign   = starling.utils.HAlign.RIGHT;
			txtField.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			txtField.alignPivot();
			nativeVIew.addChild(txtField);
		}
	}
}