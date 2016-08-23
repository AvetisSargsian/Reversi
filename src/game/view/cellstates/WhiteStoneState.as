package game.view.cellstates
{
	import game.model.GameModel;
	import game.view.CellView;
	
	import starling.display.Image;

	public class WhiteStoneState extends AbstractCellState
	{
		public function WhiteStoneState()
		{
			super();
		}
		
		override public function applyToView(cellV:CellView):void
		{
			var stone:Image = cellV.getChildByName(CellView.STONE) as Image;
			stone.color = GameModel.instance.stone1Color;
			stone.visible = true;
			cellV.getChildByName(CellView.POSIBLE_MOVE).visible = false;
			super.applyToView(cellV);
		}
		
	}
}