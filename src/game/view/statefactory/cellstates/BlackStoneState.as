package game.view.statefactory.cellstates
{
	import game.model.GameModel;
	import game.view.CellView;
	
	import starling.display.Image;

	public class BlackStoneState extends AbstractCellState
	{
		public function BlackStoneState()
		{
			super();
		}
		
		override public function applyToView(cellV:CellView):void
		{
			var stone:Image = cellV.getChildByName(CellView.STONE) as Image;
			stone.color = GameModel.instance.stone2Color;
			stone.visible = true;
			cellV.getChildByName(CellView.POSIBLE_MOVE).visible = false;
			super.applyToView(cellV);
		}
	}
}