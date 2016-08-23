package game.view.cellstates
{
	import game.view.CellView;
	
	public class CellPosibleMoveState extends AbstractCellState
	{
		public function CellPosibleMoveState()
		{
		}
		
		override public function applyToView(cellV:CellView):void
		{
			cellV.getChildByName(CellView.STONE).visible = false;
			cellV.getChildByName(CellView.POSIBLE_MOVE).visible = true;
			super.applyToView(cellV);
		}
	}
}