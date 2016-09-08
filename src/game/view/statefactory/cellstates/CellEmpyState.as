package game.view.statefactory.cellstates
{
	import game.view.CellView;

	public class CellEmpyState extends AbstractCellState
	{
		override public function applyToView(cellV:CellView):void
		{
			cellV.getChildByName(CellView.STONE).visible = false;
			cellV.getChildByName(CellView.POSIBLE_MOVE).visible = false;
			invokeCallBack();
		}
	}
}