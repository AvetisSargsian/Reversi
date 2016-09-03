package game.view.statefactory.cellstates
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
			invokeCallBack();
		}
		
		public function setCallBack(func:Function):void
		{
			callBack = func;
		}
		
		public function invokeCallBack():void
		{
			if (callBack != null)
			callBack();
		}
		
		public function dispose():void
		{
			callBack = null;
		}	
	}
}