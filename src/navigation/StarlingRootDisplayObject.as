package navigation
{
	import mvc.view.AbstractView;
	
	import navigation.controller.NavigationController;
	import navigation.model.NavigationModel;
	
	public class StarlingRootDisplayObject extends AbstractView
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