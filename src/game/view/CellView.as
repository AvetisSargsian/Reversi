package game.view
{
	import mvc.view.AbstractView;
	
	import starling.display.Image;
	
	public class CellView extends AbstractView
	{
		public static const CELL_BG:String = "celBg";
		public static const STONE:String = "stone";
		public static const POSIBLE_MOVE:String = "posibleMove";
		
		public function CellView()
		{
			super();
			this.onAddedToStage = onAdded;
		}
		
		private function onAdded():void
		{
			this.onAddedToStage = null;
				 
			var bg:Image = new Image(assetManager.getTexture("cell_bg"));
			bg.name = CELL_BG;
			addChild(bg);
			
			var stone:Image = new Image(assetManager.getTexture("stone"));
			stone.name = STONE
			addChild(stone);
			stone.x = bg.width /2;
			stone.y = bg.height/2;
			stone.alignPivot();
			
			var posibleMove:Image = new Image(assetManager.getTexture("empty_stone"));
			posibleMove.name = POSIBLE_MOVE;
			addChild(posibleMove);
			posibleMove.x = (bg.width - posibleMove.width)/2;
			posibleMove.y = (bg.height - posibleMove.height)/2;
		}
	}
}