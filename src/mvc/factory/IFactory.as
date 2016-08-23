package mvc.factory
{
	import mvc.disposeble.IDisposeble;
	import mvc.view.AbstractView;
	

	public interface IFactory extends IDisposeble
	{
		function produce(cellV:AbstractView, type:int):void
	}
}