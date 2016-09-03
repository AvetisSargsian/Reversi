package game.view.statefactory.cellstates
{
	import game.view.CellView;
	
	import mvc.disposeble.IDisposeble;

	public interface ICellState extends IDisposeble
	{
		function applyToView(cellV:CellView):void;
		function setCallBack(func:Function):void;
		function invokeCallBack():void
	}
}