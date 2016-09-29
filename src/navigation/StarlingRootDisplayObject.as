package navigation
{
	import mvc.view.BaseView;
	
	import navigation.controller.NavigationController;
	import navigation.model.NavigationModel;
	
	public class StarlingRootDisplayObject extends BaseView
	{
		public function StarlingRootDisplayObject()
		{
			super();
			this.onAddedToStage = onAdded;
			NavigationModel.instance.init(this);
		}
		
		private function onAdded():void
		{
			this.onAddedToStage = null;			
			NavigationController.instance.changeScene(Constants.FIRST_LOAD);
		}
	}
}