package game.view.cellstates
{
	import game.view.CellView;
	
	public class AbstractCellState implements ICellState
	{
		private var callBack:Function;
		
		public function AbstractCellState()
		{
		}
		
		public function applyToView(cellV:CellView):void
		{
			if (callBack != null)
				callBack();
		}
		
		public function setCallBack(func:Function):void
		{
			callBack = func;
		}
		
		public function dispose():void
		{
			callBack = null;
		}	
	}
}